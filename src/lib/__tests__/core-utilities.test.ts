import { resolveLocalized, resolveLocalizedWithDefault, getDirection } from '../i18n-helper';
import { calculateFragranceMatches, ScoredPerfume } from '../scoring-engine';
import { useQuizStore } from '../store/useQuizStore';
import { Perfume, Answer, AnswerTagWeight, PerfumeTag } from '../supabase/types';

function assert(condition: boolean, message: string) {
  if (!condition) {
    throw new Error(`Assertion failed: ${message}`);
  }
  console.log(`✓ ${message}`);
}

async function runTests() {
  console.log('=============================================================');
  console.log('Testing Phase 2: Core Utilities & State Management');
  console.log('=============================================================');

  // -------------------------------------------------------------
  // Test 1: i18n-helper
  // -------------------------------------------------------------
  console.log('\n--- 1. Testing i18n-helper ---');
  const sampleText = {
    ar: 'عطر زهري راقي',
    fr: 'Parfum floral raffiné',
    en: 'Refined floral fragrance',
  };

  assert(resolveLocalized(sampleText, 'ar') === 'عطر زهري راقي', 'Resolves direct Arabic text');
  assert(resolveLocalized(sampleText, 'fr') === 'Parfum floral raffiné', 'Resolves direct French text');
  assert(resolveLocalized(sampleText, 'en') === 'Refined floral fragrance', 'Resolves direct English text');

  // Fallback testing
  const missingFr = {
    ar: 'عطر أصيل',
    fr: '',
    en: 'Authentic Perfume',
  };
  assert(resolveLocalized(missingFr, 'fr', 'ar') === 'عطر أصيل', 'Falls back to Arabic when French is empty');

  const englishOnly = {
    ar: '',
    fr: '',
    en: 'English Scent Only',
  };
  assert(resolveLocalized(englishOnly, 'fr', 'ar') === 'English Scent Only', 'Falls back to English when AR/FR empty');

  const arbitraryKey = {
    custom: 'Special Custom Text',
  };
  assert(resolveLocalized(arbitraryKey as any, 'ar', 'ar') === 'Special Custom Text', 'Falls back to any non-empty string');
  assert(resolveLocalized(null, 'ar') === '', 'Handles null gracefully');
  assert(getDirection('ar') === 'rtl', 'ar direction is rtl');
  assert(getDirection('en') === 'ltr', 'en direction is ltr');
  assert(getDirection('fr') === 'ltr', 'fr direction is ltr');

  // -------------------------------------------------------------
  // Test 2: Two-Stage Scoring Engine
  // -------------------------------------------------------------
  console.log('\n--- 2. Testing Two-Stage Scoring Engine ---');

  const mockPerfumes: Perfume[] = [
    {
      id: 'p-male-citrus',
      name: 'Bleu Intense',
      brand: 'Chanel',
      description: { ar: 'منعش رجالي', fr: 'Frais', en: 'Fresh' },
      price: 120,
      shelf_location: 'Shelf A1',
      is_available: true,
      is_featured: false,
      is_draft: false,
      created_at: new Date().toISOString(),
    },
    {
      id: 'p-female-floral',
      name: 'Miss Blooming',
      brand: 'Dior',
      description: { ar: 'زهري نسائي', fr: 'Floral', en: 'Floral' },
      price: 135,
      shelf_location: 'Shelf B2',
      is_available: true,
      is_featured: true,
      is_draft: false,
      created_at: new Date().toISOString(),
    },
    {
      id: 'p-unisex-woody',
      name: 'Oud Wood Royal',
      brand: 'Tom Ford',
      description: { ar: 'عود خشبي', fr: 'Boisé', en: 'Woody' },
      price: 250,
      shelf_location: 'Shelf C3',
      is_available: true,
      is_featured: true,
      is_draft: false,
      created_at: new Date().toISOString(),
    },
    {
      id: 'p-draft',
      name: 'Draft Perfume',
      brand: 'Testing',
      description: { ar: 'مسودة', fr: 'Draft', en: 'Draft' },
      price: 90,
      shelf_location: null,
      is_available: true,
      is_featured: false,
      is_draft: true, // Should be eliminated
      created_at: new Date().toISOString(),
    },
    {
      id: 'p-out-of-stock',
      name: 'Sold Out Scent',
      brand: 'Testing',
      description: { ar: 'غير متوفر', fr: 'Rupture', en: 'Out of stock' },
      price: 90,
      shelf_location: null,
      is_available: false, // Should be eliminated
      is_featured: false,
      is_draft: false,
      created_at: new Date().toISOString(),
    },
  ];

  const mockPerfumeTags: PerfumeTag[] = [
    { perfume_id: 'p-male-citrus', tag_id: 'tag_male' },
    { perfume_id: 'p-male-citrus', tag_id: 'tag_citrus' },
    { perfume_id: 'p-female-floral', tag_id: 'tag_female' },
    { perfume_id: 'p-female-floral', tag_id: 'tag_floral' },
    { perfume_id: 'p-unisex-woody', tag_id: 'tag_unisex' },
    { perfume_id: 'p-unisex-woody', tag_id: 'tag_woody' },
    { perfume_id: 'p-unisex-woody', tag_id: 'tag_citrus' },
  ];

  const mockAnswers: Answer[] = [
    // Hard filter question: Gender
    {
      id: 'ans-men',
      question_id: 'q-gender',
      sort_order: 1,
      title: { ar: 'للرجال', fr: 'Pour Homme', en: 'For Men' },
      subtitle_explanation: null,
      image_url: null,
      is_hard_filter: true,
      created_at: new Date().toISOString(),
    },
    // Scoring question: Vibe
    {
      id: 'ans-fresh-citrus',
      question_id: 'q-vibe',
      sort_order: 1,
      title: { ar: 'منعش وحمضي', fr: 'Frais & Hespéridé', en: 'Fresh & Citrus' },
      subtitle_explanation: null,
      image_url: null,
      is_hard_filter: false,
      created_at: new Date().toISOString(),
    },
  ];

  const mockWeights: AnswerTagWeight[] = [
    // Hard filter answer: Men allows tag_male and tag_unisex
    { id: 'w1', answer_id: 'ans-men', tag_id: 'tag_male', weight_points: 0 },
    { id: 'w2', answer_id: 'ans-men', tag_id: 'tag_unisex', weight_points: 0 },
    // Scoring answer: Fresh & Citrus awards 30 points to tag_citrus, 10 points to tag_woody
    { id: 'w3', answer_id: 'ans-fresh-citrus', tag_id: 'tag_citrus', weight_points: 30 },
    { id: 'w4', answer_id: 'ans-fresh-citrus', tag_id: 'tag_woody', weight_points: 10 },
  ];

  // Test Stage 1: Selecting "For Men" strictly eliminates female perfume, draft, and out-of-stock
  const result1 = calculateFragranceMatches({
    perfumes: mockPerfumes,
    perfumeTags: mockPerfumeTags,
    answers: mockAnswers,
    answerTagWeights: mockWeights,
    selectedAnswerIds: ['ans-men', 'ans-fresh-citrus'],
  });

  assert(result1.totalSurvivingStage1 === 2, 'Stage 1 eliminated draft, out-of-stock, and female-only perfumes');
  assert(
    result1.rankedPerfumes.every((p) => p.perfume.id !== 'p-female-floral' && p.perfume.id !== 'p-draft'),
    'Female and draft perfumes are strictly excluded'
  );

  // Bleu Intense has tag_citrus (30 pts out of 40 maxScore -> 75%)
  // Oud Wood Royal has tag_citrus (30 pts) and tag_woody (10 pts) -> 40/40 -> 100%
  const topMatch = result1.topMatches[0];
  assert(topMatch.perfume.id === 'p-unisex-woody', 'Highest scoring perfume ranks first');
  assert(topMatch.matchPercentage === 100, 'Top match has 100% match percentage');
  assert(result1.executionTimeMs < 50, `Execution time is fast: ${result1.executionTimeMs}ms (< 50ms)`);

  // Test Edge Case: Only Hard Filter answered (Early Exit on Q1)
  const resultEdgeCase = calculateFragranceMatches({
    perfumes: mockPerfumes,
    perfumeTags: mockPerfumeTags,
    answers: mockAnswers,
    answerTagWeights: mockWeights,
    selectedAnswerIds: ['ans-men'],
  });

  assert(resultEdgeCase.totalSurvivingStage1 === 2, 'Stage 1 still filters gender on edge case');
  assert(resultEdgeCase.rankedPerfumes.every((p) => p.matchPercentage === 100), 'All surviving get 100% when maxScore is 0');
  assert(resultEdgeCase.topMatches[0].perfume.is_featured === true, 'Featured perfume prioritized as tie-breaker');

  // Test Fallback: Top 3 fallback when scores are below 40%
  const lowWeightMock: AnswerTagWeight[] = [
    { id: 'w-low', answer_id: 'ans-fresh-citrus', tag_id: 'non_existent_tag', weight_points: 100 },
  ];
  const resultFallback = calculateFragranceMatches({
    perfumes: mockPerfumes,
    perfumeTags: mockPerfumeTags,
    answers: mockAnswers,
    answerTagWeights: lowWeightMock,
    selectedAnswerIds: ['ans-fresh-citrus'],
  });
  assert(resultFallback.rankedPerfumes.length === 3, 'Falls back to top 3 perfumes when all scores are < 40%');

  // -------------------------------------------------------------
  // Test 3: useQuizStore
  // -------------------------------------------------------------
  console.log('\n--- 3. Testing useQuizStore ---');

  const store = useQuizStore.getState();
  store.resetQuiz();

  assert(store.getAnsweredCount() === 0, 'Initial answered count is 0');
  assert(store.canEarlyExit() === false, 'Cannot early exit with 0 answers');
  assert(store.getAccuracyPercentage() === 0, '0% accuracy at start');

  // Answer question 1
  store.selectAnswer('q1', 'a1');
  assert(store.getAnsweredCount() === 1, '1 answer registered');
  assert(store.canEarlyExit() === false, 'Cannot early exit with 1 answer');
  assert(store.getAccuracyPercentage() === 25, '25% accuracy after 1 answer');

  // Answer question 2 (Early exit unlocked)
  store.selectAnswer('q2', 'a2');
  assert(store.getAnsweredCount() === 2, '2 answers registered');
  assert(store.canEarlyExit() === true, 'Early exit unlocked after 2 answers');
  assert(store.getAccuracyPercentage() === 45, '45% accuracy after 2 answers (matches PRD)');

  // Answer question 3
  store.selectAnswer('q3', 'a3');
  assert(store.getAccuracyPercentage() === 60, '60% accuracy after 3 answers');

  // Backward navigation
  store.goToPreviousStep();
  assert(useQuizStore.getState().history.length === 2, 'Back navigation pops step history');

  // Reset
  store.resetQuiz();
  assert(useQuizStore.getState().getAnsweredCount() === 0, 'Reset cleans up state');

  console.log('\n=============================================================');
  console.log('ALL PHASE 2 TESTS PASSED SUCCESSFULLY!');
  console.log('=============================================================');
}

runTests();
