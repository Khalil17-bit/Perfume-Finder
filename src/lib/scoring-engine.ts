import { Answer, AnswerTagWeight, Perfume, PerfumeTag } from './supabase/types';

export interface ScoredPerfume {
  perfume: Perfume;
  matchPercentage: number;
  score: number;
  maxScore: number;
  matchedTagIds: string[];
}

export interface ScoringResult {
  rankedPerfumes: ScoredPerfume[];
  topMatches: ScoredPerfume[];
  otherMatches: ScoredPerfume[];
  totalSurvivingStage1: number;
  executionTimeMs: number;
}

export interface ScoringParams {
  perfumes: Perfume[];
  perfumeTags: PerfumeTag[];
  answers: Answer[];
  answerTagWeights: AnswerTagWeight[];
  selectedAnswerIds: string[];
}

/**
 * Two-Stage Client-Side Adaptive Fragrance Matching Engine.
 * Executes in < 50ms with zero server round-trips.
 *
 * Stage 1: Hard Filtering (Strict elimination of drafts, out of stock, and hard filter mismatches).
 * Stage 2: Adaptive Weighted Scoring (Partial-completion safe percentage calculation).
 */
// WeakMap caches to avoid O(N) lookup reconstruction on repeated renders with identical catalog arrays
const answersCache = new WeakMap<Answer[], Map<string, Answer>>();
const perfumeTagsCache = new WeakMap<PerfumeTag[], Map<string, Set<string>>>();
const weightsCache = new WeakMap<AnswerTagWeight[], Map<string, AnswerTagWeight[]>>();

export function calculateFragranceMatches(params: ScoringParams): ScoringResult {
  const startTime = performance.now();
  const { perfumes, perfumeTags, answers, answerTagWeights, selectedAnswerIds } = params;

  // 1. Retrieve or build O(1) lookup structures
  let answersById = answersCache.get(answers);
  if (!answersById) {
    answersById = new Map<string, Answer>();
    answers.forEach((ans) => answersById!.set(ans.id, ans));
    answersCache.set(answers, answersById);
  }

  let tagsByPerfumeId = perfumeTagsCache.get(perfumeTags);
  if (!tagsByPerfumeId) {
    tagsByPerfumeId = new Map<string, Set<string>>();
    perfumeTags.forEach((pt) => {
      let tagSet = tagsByPerfumeId!.get(pt.perfume_id);
      if (!tagSet) {
        tagSet = new Set<string>();
        tagsByPerfumeId!.set(pt.perfume_id, tagSet);
      }
      tagSet.add(pt.tag_id);
    });
    perfumeTagsCache.set(perfumeTags, tagsByPerfumeId);
  }

  let weightsByAnswerId = weightsCache.get(answerTagWeights);
  if (!weightsByAnswerId) {
    weightsByAnswerId = new Map<string, AnswerTagWeight[]>();
    answerTagWeights.forEach((atw) => {
      let list = weightsByAnswerId!.get(atw.answer_id);
      if (!list) {
        list = [];
        weightsByAnswerId!.set(atw.answer_id, list);
      }
      list.push(atw);
    });
    weightsCache.set(answerTagWeights, weightsByAnswerId);
  }

  // Collect selected answers
  const selectedAnswerObjects: Answer[] = [];
  selectedAnswerIds.forEach((id) => {
    const ans = answersById.get(id);
    if (ans) {
      selectedAnswerObjects.push(ans);
    }
  });

  // Split selected answers into hard filters and scoring answers
  const hardFilterAnswers = selectedAnswerObjects.filter((ans) => ans.is_hard_filter);
  const scoringAnswers = selectedAnswerObjects.filter((ans) => !ans.is_hard_filter);

  // -------------------------------------------------------------
  // Stage 1: Hard Filtering (Strict Elimination)
  // -------------------------------------------------------------
  const stage1SurvivingPerfumes = perfumes.filter((perfume) => {
    // Availability & readiness check
    if (!perfume.is_available || perfume.is_draft) {
      return false;
    }

    const perfumeTagSet = tagsByPerfumeId.get(perfume.id) ?? new Set<string>();

    // Evaluate each selected hard filter answer
    for (const hfAnswer of hardFilterAnswers) {
      const linkedWeights = weightsByAnswerId.get(hfAnswer.id) ?? [];

      // If the answer links to specific tags, perfume MUST have at least one
      if (linkedWeights.length > 0) {
        const hasMatchingTag = linkedWeights.some((lw) => perfumeTagSet.has(lw.tag_id));
        if (!hasMatchingTag) {
          return false;
        }
      }
      // If linkedWeights is empty (e.g. "Any / Gift"), no elimination occurs
    }

    return true;
  });

  const totalSurvivingStage1 = stage1SurvivingPerfumes.length;

  // If no perfumes survive Stage 1, return early
  if (totalSurvivingStage1 === 0) {
    const endTime = performance.now();
    return {
      rankedPerfumes: [],
      topMatches: [],
      otherMatches: [],
      totalSurvivingStage1: 0,
      executionTimeMs: Math.round((endTime - startTime) * 100) / 100,
    };
  }

  // -------------------------------------------------------------
  // Stage 2: Adaptive Weighted Scoring (Partial-Completion Safe)
  // -------------------------------------------------------------

  // 1. Calculate Maximum Possible Score (Max_Score) from answered non-hard-filter answers
  let maxScore = 0;
  scoringAnswers.forEach((ans) => {
    const linkedWeights = weightsByAnswerId.get(ans.id) ?? [];
    linkedWeights.forEach((lw) => {
      maxScore += lw.weight_points;
    });
  });

  // Edge Case: If user only answered hard filters or no weights exist
  if (maxScore === 0) {
    const scoredList: ScoredPerfume[] = stage1SurvivingPerfumes.map((perfume) => ({
      perfume,
      matchPercentage: 100,
      score: 0,
      maxScore: 0,
      matchedTagIds: Array.from(tagsByPerfumeId.get(perfume.id) ?? []),
    }));

    // Sort by is_featured DESC, then name ASC
    scoredList.sort((a, b) => {
      if (a.perfume.is_featured !== b.perfume.is_featured) {
        return a.perfume.is_featured ? -1 : 1;
      }
      return a.perfume.name.localeCompare(b.perfume.name);
    });

    const endTime = performance.now();
    return {
      rankedPerfumes: scoredList,
      topMatches: scoredList.slice(0, 3),
      otherMatches: scoredList.slice(3),
      totalSurvivingStage1,
      executionTimeMs: Math.round((endTime - startTime) * 100) / 100,
    };
  }

  // 2. Calculate Individual Perfume Scores
  const allScoredPerfumes: ScoredPerfume[] = stage1SurvivingPerfumes.map((perfume) => {
    const perfumeTagSet = tagsByPerfumeId.get(perfume.id) ?? new Set<string>();
    let perfumeScore = 0;
    const matchedTagIds: string[] = [];

    scoringAnswers.forEach((ans) => {
      const linkedWeights = weightsByAnswerId.get(ans.id) ?? [];
      linkedWeights.forEach((lw) => {
        if (perfumeTagSet.has(lw.tag_id)) {
          perfumeScore += lw.weight_points;
          if (!matchedTagIds.includes(lw.tag_id)) {
            matchedTagIds.push(lw.tag_id);
          }
        }
      });
    });

    const matchPercentage = Math.round((perfumeScore / maxScore) * 100);

    return {
      perfume,
      matchPercentage,
      score: perfumeScore,
      maxScore,
      matchedTagIds,
    };
  });

  // Sort descending by matchPercentage, with tie-breakers: is_featured DESC, score DESC, name ASC
  allScoredPerfumes.sort((a, b) => {
    if (b.matchPercentage !== a.matchPercentage) {
      return b.matchPercentage - a.matchPercentage;
    }
    if (a.perfume.is_featured !== b.perfume.is_featured) {
      return a.perfume.is_featured ? -1 : 1;
    }
    if (b.score !== a.score) {
      return b.score - a.score;
    }
    return a.perfume.name.localeCompare(b.perfume.name);
  });

  // 3. Thresholding: Filter >= 40%
  let qualifyingPerfumes = allScoredPerfumes.filter((sp) => sp.matchPercentage >= 40);

  // Fallback: If fewer than 3 perfumes achieve 40%, display top 3 highest-scoring perfumes
  if (qualifyingPerfumes.length < 3) {
    qualifyingPerfumes = allScoredPerfumes.slice(0, 3);
  }

  const endTime = performance.now();
  const executionTimeMs = Math.round((endTime - startTime) * 100) / 100;

  return {
    rankedPerfumes: qualifyingPerfumes,
    topMatches: qualifyingPerfumes.slice(0, 3),
    otherMatches: qualifyingPerfumes.slice(3),
    totalSurvivingStage1,
    executionTimeMs,
  };
}
