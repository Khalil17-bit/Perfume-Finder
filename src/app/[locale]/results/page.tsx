'use client';

import { Suspense, useEffect, useMemo, useRef } from 'react';
import { useRouter } from '@/i18n/routing';
import { useSearchParams } from 'next/navigation';
import { useLocale, useTranslations } from 'next-intl';
import confetti from 'canvas-confetti';
import { useQuizStore } from '@/lib/store/useQuizStore';
import {
  FALLBACK_PERFUMES,
  FALLBACK_PERFUME_TAGS,
  FALLBACK_ANSWERS,
  FALLBACK_ANSWER_TAG_WEIGHTS,
  FALLBACK_TAGS,
} from '@/lib/data/fallback-data';
import { calculateFragranceMatches, ScoredPerfume } from '@/lib/scoring-engine';
import { resolveLocalized } from '@/lib/i18n-helper';
import { createClient } from '@/lib/supabase/client';
import {
  Sparkles,
  RotateCcw,
  Tag as TagIcon,
  Crown,
  Compass,
} from 'lucide-react';
import clsx from 'clsx';
import { LanguageSwitcher } from '@/components/LanguageSwitcher';

function ResultsContent() {
  const locale = useLocale();
  const router = useRouter();
  const searchParams = useSearchParams();
  const t = useTranslations('results');
  const loggedRef = useRef(false);

  const { selectedAnswers, resetQuiz } = useQuizStore();

  // Support both in-memory store and sanitized URL query param for phone QR handoff (?ans=id1,id2...)
  const selectedAnswerIds = useMemo(() => {
    const validIds = new Set(FALLBACK_ANSWERS.map((a) => a.id));
    const queryAns = searchParams.get('ans');
    if (queryAns && queryAns.trim().length > 0) {
      return queryAns
        .split(',')
        .map((s) => s.trim())
        .filter((id) => validIds.has(id))
        .slice(0, 15);
    }
    return Object.values(selectedAnswers).filter((id) => validIds.has(id));
  }, [searchParams, selectedAnswers]);

  // Compute matches using client-side Two-Stage Adaptive Scoring Engine (< 50ms)
  const scoringResult = useMemo(() => {
    return calculateFragranceMatches({
      perfumes: FALLBACK_PERFUMES,
      perfumeTags: FALLBACK_PERFUME_TAGS,
      answers: FALLBACK_ANSWERS,
      answerTagWeights: FALLBACK_ANSWER_TAG_WEIGHTS,
      selectedAnswerIds,
    });
  }, [selectedAnswerIds]);

  const { topMatches, otherMatches, rankedPerfumes } = scoringResult;
  const topPerfume = topMatches[0] || null;

  // Tag dictionary for fast localized chip lookup
  const tagMap = useMemo(() => {
    const map = new Map<string, string>();
    FALLBACK_TAGS.forEach((t) => {
      map.set(t.id, resolveLocalized(t.label, locale));
    });
    return map;
  }, [locale]);

  // Luxury Confetti & Telemetry on Mount
  useEffect(() => {
    try {
      confetti({
        particleCount: 80,
        spread: 60,
        origin: { y: 0.5 },
        colors: ['#D4AF37', '#E5C158', '#FAFAFA', '#B45309'],
        disableForReducedMotion: true,
      });
    } catch {
      // Ignore
    }

    if (!loggedRef.current && topPerfume) {
      loggedRef.current = true;
      (async () => {
        try {
          const supabase = createClient();
          await (supabase.from('analytics_logs') as any).insert({
            mode: 'web',
            answered_count: selectedAnswerIds.length,
            top_perfume_id: topPerfume.perfume.id,
            selected_answer_ids: selectedAnswerIds,
          });
        } catch {
          // Fallback safe if table not yet migrated
        }
      })();
    }
  }, [topPerfume, selectedAnswerIds]);

  const handleRetake = () => {
    resetQuiz();
    router.push('/quiz');
  };

  return (
    <div className="relative min-h-screen bg-background text-textPrimary">
      <div
        className="pointer-events-none fixed inset-0 z-0 bg-[radial-gradient(ellipse_70%_60%_at_50%_-10%,rgba(212,175,55,0.08),transparent)]"
        aria-hidden="true"
      />

      <header className="relative z-10 mx-auto flex w-full max-w-6xl items-center justify-between px-6 py-6 sm:px-12">
        <div className="flex items-center gap-2.5">
          <div className="flex h-9 w-9 items-center justify-center rounded-full border border-gold/40 bg-surface/90">
            <Compass className="h-4 w-4 text-gold" />
          </div>
          <span className="text-xs font-semibold tracking-wider text-zinc-300 uppercase">
            {locale === 'ar' ? 'نتائج التوصية العطرية' : locale === 'fr' ? 'Recommandations Sur-Mesure' : 'Custom Fragrance Matches'}
          </span>
        </div>

        <LanguageSwitcher />
      </header>

      <main className="relative z-10 mx-auto max-w-5xl px-6 py-6 sm:px-12">
        <div className="text-center">
          <div className="inline-flex items-center gap-2 rounded-full border border-gold/30 bg-gold/10 px-4 py-1.5 text-xs font-semibold text-gold">
            <Sparkles className="h-3.5 w-3.5" />
            <span>{t('headline')}</span>
          </div>

          <h1 className="mt-3 text-3xl font-extrabold tracking-tight sm:text-4xl md:text-5xl">
            <span className="bg-gradient-to-b from-zinc-50 to-zinc-400 bg-clip-text text-transparent">
              {t('topMatches')}
            </span>
          </h1>

          <p className="mt-3 text-sm text-textMuted sm:text-base max-w-xl mx-auto">
            {t('subheadline')}
          </p>
        </div>

        {rankedPerfumes.length === 0 ? (
          <div className="mt-12 rounded-2xl border border-zinc-800 bg-surface p-12 text-center">
            <p className="text-textMuted">{t('emptyNotice')}</p>
            <button
              type="button"
              onClick={handleRetake}
              className="mt-6 rounded-full bg-gold px-6 py-2.5 text-xs font-bold text-background"
            >
              {t('retake')}
            </button>
          </div>
        ) : (
          <div className="mt-10 space-y-12">
            <section aria-label={t('topMatches')}>
              <div className="grid grid-cols-1 gap-6 md:grid-cols-3">
                {topMatches.map((scored, idx) => (
                  <HeroPerfumeCard
                    key={scored.perfume.id}
                    scored={scored}
                    rank={idx + 1}
                    locale={locale}
                    tagMap={tagMap}
                    matchLabel={t('matchBadge')}
                  />
                ))}
              </div>
            </section>

            {otherMatches.length > 0 && (
              <section aria-label={t('otherMatches')} className="pt-6 border-t border-zinc-900">
                <h2 className="mb-6 text-xl font-bold tracking-tight text-zinc-300">
                  {t('otherMatches')} ({otherMatches.length})
                </h2>

                <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
                  {otherMatches.map((scored) => (
                    <SecondaryPerfumeCard
                      key={scored.perfume.id}
                      scored={scored}
                      locale={locale}
                      tagMap={tagMap}
                      matchLabel={t('matchBadge')}
                    />
                  ))}
                </div>
              </section>
            )}

            <div className="flex flex-col items-center justify-center pt-8 text-center">
              <button
                type="button"
                onClick={handleRetake}
                className="group inline-flex items-center gap-2.5 rounded-full border border-zinc-800 bg-surface px-8 py-3.5 text-sm font-semibold text-zinc-200 shadow-lg backdrop-blur-md transition-all active:scale-95 hover:border-gold/40 hover:text-gold cursor-pointer"
              >
                <RotateCcw className="h-4 w-4 transition-transform group-hover:-rotate-90 duration-200" />
                <span>{t('retake')}</span>
              </button>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}

export default function ResultsPage() {
  return (
    <Suspense fallback={<div className="flex min-h-screen items-center justify-center bg-background text-gold">Loading...</div>}>
      <ResultsContent />
    </Suspense>
  );
}

// ---------------------------------------------------------------------
// Hero Perfume Card (Top 3 Matches) - Strictly Typographic, Image-Free
// ---------------------------------------------------------------------
interface CardProps {
  scored: ScoredPerfume;
  rank?: number;
  locale: string;
  tagMap: Map<string, string>;
  matchLabel: string;
}

function HeroPerfumeCard({ scored, rank = 1, locale, tagMap, matchLabel }: CardProps) {
  const { perfume, matchPercentage, matchedTagIds } = scored;
  const description = resolveLocalized(perfume.description, locale);
  const isWinner = rank === 1;

  return (
    <article
      className={clsx(
        'group relative flex flex-col justify-between rounded-3xl border p-7 backdrop-blur-md transition-all duration-300 hover:-translate-y-1',
        isWinner
          ? 'border-gold/50 bg-gradient-to-b from-surface via-surface to-gold/5 shadow-[0_0_30px_rgba(212,175,55,0.18)] ring-1 ring-gold/40'
          : 'border-zinc-800 bg-surface shadow-md hover:border-zinc-700'
      )}
    >
      <div>
        <div className="flex items-center justify-between gap-2">
          <div className="inline-flex items-center gap-1.5 rounded-full bg-zinc-800/80 px-2.5 py-1 text-[11px] font-semibold tracking-wider text-zinc-300">
            {isWinner && <Crown className="h-3.5 w-3.5 text-gold" />}
            <span>#{rank}</span>
          </div>

          <div
            className={clsx(
              'rounded-full px-3 py-1 text-xs font-bold tracking-wide shadow-sm',
              isWinner
                ? 'bg-gold text-zinc-950 font-black'
                : 'bg-zinc-800 border border-gold/40 text-gold'
            )}
          >
            {matchPercentage}% {matchLabel}
          </div>
        </div>

        <div className="mt-5">
          {perfume.brand && (
            <p className="font-latin text-xs font-semibold tracking-widest text-gold uppercase">
              {perfume.brand}
            </p>
          )}
          <h3 className="font-latin mt-1 text-xl font-bold tracking-tight text-zinc-50 group-hover:text-gold transition-colors duration-200">
            {perfume.name}
          </h3>
        </div>

        <p className="mt-3 text-xs leading-relaxed text-zinc-400 sm:text-sm">
          {description}
        </p>

        {matchedTagIds.length > 0 && (
          <div className="mt-4 flex flex-wrap gap-1.5">
            {matchedTagIds.map((tagId) => {
              const label = tagMap.get(tagId);
              if (!label) return null;
              return (
                <span
                  key={tagId}
                  className="inline-flex items-center gap-1 rounded-md bg-zinc-900 border border-zinc-800 px-2 py-0.5 text-[11px] font-medium text-zinc-300"
                >
                  <TagIcon className="h-2.5 w-2.5 text-gold/70" />
                  <span>{label}</span>
                </span>
              );
            })}
          </div>
        )}
      </div>

      {perfume.price && (
        <div className="mt-6 pt-4 border-t border-zinc-800/60 flex items-center justify-between text-xs">
          <span className="text-zinc-500 font-medium">
            {locale === 'ar' ? 'السعر التقديري' : locale === 'fr' ? 'Prix estimé' : 'Estimated Price'}
          </span>
          <span className="font-bold text-zinc-200">
            {perfume.price} {locale === 'ar' ? 'د.ت' : 'TND'}
          </span>
        </div>
      )}
    </article>
  );
}

// ---------------------------------------------------------------------
// Secondary Perfume Card (Other Compatible Matches) - Typographic
// ---------------------------------------------------------------------
function SecondaryPerfumeCard({ scored, locale, tagMap, matchLabel }: CardProps) {
  const { perfume, matchPercentage, matchedTagIds } = scored;
  const description = resolveLocalized(perfume.description, locale);

  return (
    <article className="group flex flex-col justify-between rounded-2xl border border-zinc-800/90 bg-surface/80 p-5 backdrop-blur-sm transition-all duration-200 hover:border-zinc-700 hover:bg-surface">
      <div>
        <div className="flex items-center justify-between gap-2">
          {perfume.brand && (
            <span className="font-latin text-[10px] font-semibold tracking-wider text-zinc-400 uppercase">
              {perfume.brand}
            </span>
          )}
          <span className="rounded-full bg-zinc-800/90 border border-zinc-700/60 px-2.5 py-0.5 text-[11px] font-bold text-gold">
            {matchPercentage}% {matchLabel}
          </span>
        </div>

        <h3 className="font-latin mt-2 text-base font-bold text-zinc-100 group-hover:text-gold transition-colors">
          {perfume.name}
        </h3>

        <p className="mt-2 text-xs leading-relaxed text-zinc-400 line-clamp-3">
          {description}
        </p>

        {matchedTagIds.length > 0 && (
          <div className="mt-3 flex flex-wrap gap-1">
            {matchedTagIds.slice(0, 3).map((tagId) => {
              const label = tagMap.get(tagId);
              if (!label) return null;
              return (
                <span
                  key={tagId}
                  className="rounded bg-zinc-900 border border-zinc-800/80 px-1.5 py-0.5 text-[10px] text-zinc-300"
                >
                  {label}
                </span>
              );
            })}
          </div>
        )}
      </div>

      {perfume.price && (
        <div className="mt-4 pt-3 border-t border-zinc-800/40 text-end text-xs font-semibold text-zinc-300">
          {perfume.price} {locale === 'ar' ? 'د.ت' : 'TND'}
        </div>
      )}
    </article>
  );
}
