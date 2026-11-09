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
import { PerfumeBottleDisplay } from '@/components/results/PerfumeBottleDisplay';

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
  const { perfume, matchPercentage } = scored;
  const description = resolveLocalized(perfume.description, locale);
  const isWinner = rank === 1;

  return (
    <article
      className={clsx(
        'group relative flex flex-col justify-between rounded-3xl border p-6 backdrop-blur-md transition-all duration-300 hover:-translate-y-1',
        isWinner
          ? 'border-[#FF5500]/60 bg-gradient-to-b from-[#141418] via-[#101014] to-[#FF5500]/10 shadow-[0_0_35px_rgba(255,85,0,0.18)] ring-1 ring-[#FF5500]/40'
          : 'border-zinc-800/90 bg-[#121216] shadow-lg hover:border-zinc-700'
      )}
    >
      <div>
        {/* Top Badges */}
        <div className="flex items-center justify-between gap-2">
          <div className="inline-flex items-center gap-1.5 rounded-full bg-zinc-800/80 px-2.5 py-1 text-[11px] font-semibold tracking-wider text-zinc-300">
            {isWinner && <Crown className="h-3.5 w-3.5 text-[#FF5500]" />}
            <span>#{rank}</span>
          </div>

          <div
            className={clsx(
              'rounded-full px-3 py-1 text-xs font-bold tracking-wide shadow-sm',
              isWinner
                ? 'bg-[#FF5500] text-zinc-950 font-black'
                : 'bg-zinc-800 border border-[#FF5500]/40 text-[#FF5500]'
            )}
          >
            {matchPercentage}% {matchLabel}
          </div>
        </div>

        {/* Dynamic Transparent Perfume Bottle Stage with 3D Projected Label */}
        <div className="my-3">
          <PerfumeBottleDisplay
            id={perfume.id}
            name={perfume.name}
            brand={perfume.brand}
            isHero={true}
          />
        </div>

        {/* Product Identity */}
        <div className="mt-2 text-center sm:text-start">
          {perfume.brand && (
            <p className="font-latin text-xs font-bold tracking-widest text-[#FF5500] uppercase">
              {perfume.brand}
            </p>
          )}
          <h3 className="font-latin mt-0.5 text-lg sm:text-xl font-black tracking-tight text-white group-hover:text-[#FF5500] transition-colors duration-200">
            {perfume.name}
          </h3>
        </div>

        {/* Description (Tags are hidden per user request) */}
        <p className="mt-2.5 text-xs sm:text-sm leading-relaxed text-zinc-400">
          {description}
        </p>
      </div>

      {perfume.price && (
        <div className="mt-6 pt-4 border-t border-zinc-800/60 flex items-center justify-between text-xs">
          <span className="text-zinc-500 font-medium">
            {locale === 'ar' ? 'السعر التقديري' : locale === 'fr' ? 'Prix estimé' : 'Estimated Price'}
          </span>
          <span className="font-bold text-white text-sm">
            {perfume.price} {locale === 'ar' ? 'د.ت' : 'TND'}
          </span>
        </div>
      )}
    </article>
  );
}

// ---------------------------------------------------------------------
// Secondary Perfume Card (Other Compatible Matches)
// ---------------------------------------------------------------------
function SecondaryPerfumeCard({ scored, locale, tagMap, matchLabel }: CardProps) {
  const { perfume, matchPercentage } = scored;
  const description = resolveLocalized(perfume.description, locale);

  return (
    <article className="content-auto group flex flex-col justify-between rounded-2xl border border-zinc-800/90 bg-[#121216]/90 p-5 backdrop-blur-sm transition-all duration-200 hover:border-zinc-700 hover:bg-[#15151B]">
      <div>
        <div className="flex items-center justify-between gap-2">
          {perfume.brand && (
            <span className="font-latin text-[10px] font-bold tracking-wider text-[#FF5500] uppercase">
              {perfume.brand}
            </span>
          )}
          <span className="rounded-full bg-zinc-800/90 border border-[#FF5500]/40 px-2.5 py-0.5 text-[11px] font-bold text-[#FF5500]">
            {matchPercentage}% {matchLabel}
          </span>
        </div>

        {/* Dynamic Transparent Perfume Bottle Stage with 3D Projected Label */}
        <div className="my-2">
          <PerfumeBottleDisplay
            id={perfume.id}
            name={perfume.name}
            brand={perfume.brand}
            isHero={false}
          />
        </div>

        <h3 className="font-latin mt-1 text-base font-bold text-white group-hover:text-[#FF5500] transition-colors">
          {perfume.name}
        </h3>

        {/* Description (Tags are hidden per user request) */}
        <p className="mt-2 text-xs leading-relaxed text-zinc-400 line-clamp-3">
          {description}
        </p>
      </div>

      {perfume.price && (
        <div className="mt-4 pt-3 border-t border-zinc-800/40 text-end text-xs font-semibold text-zinc-200">
          {perfume.price} {locale === 'ar' ? 'د.ت' : 'TND'}
        </div>
      )}
    </article>
  );
}
