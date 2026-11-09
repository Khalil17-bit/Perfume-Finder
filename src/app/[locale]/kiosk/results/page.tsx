'use client';

import { useEffect, useMemo, useRef, useState } from 'react';
import { useRouter } from '@/i18n/routing';
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
import { QrModal } from '@/components/kiosk/QrModal';
import { PerfumeBottleDisplay } from '@/components/results/PerfumeBottleDisplay';
import {
  Sparkles,
  RotateCcw,
  Tag as TagIcon,
  Crown,
  Smartphone,
  MapPin,
  CheckCircle2,
} from 'lucide-react';
import clsx from 'clsx';

export default function KioskResultsPage() {
  const locale = useLocale();
  const router = useRouter();
  const t = useTranslations('results');
  const tKiosk = useTranslations('kiosk');
  const loggedRef = useRef(false);

  const [isQrOpen, setIsQrOpen] = useState(false);
  const [qrUrl, setQrUrl] = useState('');

  const { selectedAnswers, resetQuiz } = useQuizStore();

  const selectedAnswerIds = useMemo(() => {
    return Object.values(selectedAnswers);
  }, [selectedAnswers]);

  // Client-Side Scoring Engine
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

  const tagMap = useMemo(() => {
    const map = new Map<string, string>();
    FALLBACK_TAGS.forEach((t) => {
      map.set(t.id, resolveLocalized(t.label, locale));
    });
    return map;
  }, [locale]);

  // Construct dynamic QR handoff URL and celebration on mount
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const origin = window.location.origin;
      const ansParam = selectedAnswerIds.length > 0 ? selectedAnswerIds.join(',') : '';
      setQrUrl(`${origin}/${locale}/results?ans=${encodeURIComponent(ansParam)}`);
    }

    try {
      confetti({
        particleCount: 90,
        spread: 70,
        origin: { y: 0.4 },
        colors: ['#D4AF37', '#E5C158', '#FAFAFA', '#B45309'],
        disableForReducedMotion: true,
      });
    } catch {
      // Ignore
    }

    // Telemetry logging for Kiosk session
    if (!loggedRef.current && topPerfume) {
      loggedRef.current = true;
      (async () => {
        try {
          const supabase = createClient();
          await (supabase.from('analytics_logs') as any).insert({
            mode: 'kiosk',
            answered_count: selectedAnswerIds.length,
            top_perfume_id: topPerfume.perfume.id,
            selected_answer_ids: selectedAnswerIds,
          });
        } catch {
          // Ignore if unmigrated
        }
      })();
    }
  }, [locale, selectedAnswerIds, topPerfume]);

  const handleDoneNewCustomer = () => {
    setIsQrOpen(false);
    resetQuiz();
    router.push('/kiosk');
  };

  return (
    <div className="relative min-h-[calc(100vh-80px)] px-6 py-6 sm:px-12">
      {/* Background Radiance */}
      <div
        className="pointer-events-none fixed inset-0 z-0 bg-[radial-gradient(ellipse_70%_60%_at_50%_0%,rgba(212,175,55,0.08),transparent)]"
        aria-hidden="true"
      />

      <main className="relative z-10 mx-auto max-w-6xl">
        {/* Results Header + QR Handoff Action Bar */}
        <div className="flex flex-col md:flex-row items-center justify-between gap-6 pb-6 border-b border-zinc-800">
          <div className="text-center md:text-start">
            <div className="inline-flex items-center gap-2 rounded-full border border-gold/40 bg-gold/15 px-4 py-1.5 text-xs font-bold text-gold">
              <Sparkles className="h-3.5 w-3.5" />
              <span>{t('headline')}</span>
            </div>
            <h1 className="mt-2 text-3xl sm:text-4xl font-extrabold tracking-tight text-zinc-50">
              {t('topMatches')}
            </h1>
            <p className="mt-1 text-xs sm:text-sm text-textMuted max-w-lg">
              {locale === 'ar'
                ? 'توجه إلى الرف المحدد بجانب كل عطر لتجربة زجاجة التستر مباشرة في المتجر.'
                : 'Directly locate the designated shelf next to each perfume to test the bottle in-store.'}
            </p>
          </div>

          {/* Dominant QR Code Handoff Button (PRD Section 4.2 & Design Section 5) */}
          <button
            type="button"
            onClick={() => setIsQrOpen(true)}
            className="group flex items-center gap-3 rounded-full bg-gradient-to-r from-gold via-gold-light to-gold px-8 py-4 text-sm sm:text-base font-extrabold text-zinc-950 shadow-[0_0_25px_rgba(212,175,55,0.35)] transition-transform duration-150 active:scale-95 hover:scale-105 cursor-pointer"
          >
            <Smartphone className="h-5 w-5 text-zinc-950" />
            <span>{tKiosk('saveToPhone')}</span>
          </button>
        </div>

        {/* Empty State */}
        {rankedPerfumes.length === 0 ? (
          <div className="mt-12 rounded-3xl border border-zinc-800 bg-surface p-12 text-center">
            <p className="text-textMuted">{t('emptyNotice')}</p>
            <button
              type="button"
              onClick={handleDoneNewCustomer}
              className="mt-6 rounded-full bg-gold px-6 py-2.5 text-xs font-bold text-background"
            >
              {tKiosk('startOver')}
            </button>
          </div>
        ) : (
          <div className="mt-8 space-y-12">
            {/* 1. TOP 3 HERO MATCHES WITH SHELF LOCATIONS */}
            <section aria-label={t('topMatches')}>
              <div className="grid grid-cols-1 gap-6 md:grid-cols-3">
                {topMatches.map((scored, idx) => (
                  <KioskPerfumeCard
                    key={scored.perfume.id}
                    scored={scored}
                    rank={idx + 1}
                    locale={locale}
                    tagMap={tagMap}
                    matchLabel={t('matchBadge')}
                    shelfLabel={tKiosk('shelfBadge')}
                  />
                ))}
              </div>
            </section>

            {/* 2. OTHER MATCHES */}
            {otherMatches.length > 0 && (
              <section aria-label={t('otherMatches')} className="pt-6 border-t border-zinc-900">
                <h2 className="mb-6 text-xl font-bold tracking-tight text-zinc-300">
                  {t('otherMatches')} ({otherMatches.length})
                </h2>

                <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
                  {otherMatches.map((scored) => (
                    <KioskPerfumeCard
                      key={scored.perfume.id}
                      scored={scored}
                      locale={locale}
                      tagMap={tagMap}
                      matchLabel={t('matchBadge')}
                      shelfLabel={tKiosk('shelfBadge')}
                      isCompact
                    />
                  ))}
                </div>
              </section>
            )}

            {/* Bottom Actions */}
            <div className="flex flex-col sm:flex-row items-center justify-center gap-4 pt-8">
              <button
                type="button"
                onClick={() => setIsQrOpen(true)}
                className="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 rounded-full border border-gold/40 bg-gold/10 px-8 py-3.5 text-sm font-bold text-gold transition-colors hover:bg-gold hover:text-zinc-950 cursor-pointer"
              >
                <Smartphone className="h-4 w-4" />
                <span>{tKiosk('saveToPhone')}</span>
              </button>

              <button
                type="button"
                onClick={handleDoneNewCustomer}
                className="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 rounded-full border border-zinc-800 bg-surface px-8 py-3.5 text-sm font-semibold text-zinc-300 transition-colors hover:bg-zinc-800 hover:text-zinc-100 cursor-pointer"
              >
                <RotateCcw className="h-4 w-4" />
                <span>{tKiosk('startOver')}</span>
              </button>
            </div>
          </div>
        )}
      </main>

      {/* QR Modal Component */}
      <QrModal
        isOpen={isQrOpen}
        onClose={() => setIsQrOpen(false)}
        onDoneNewCustomer={handleDoneNewCustomer}
        qrUrl={qrUrl}
        locale={locale}
      />
    </div>
  );
}

// ---------------------------------------------------------------------
// Kiosk Perfume Card with Dominant Shelf Location Display (PRD Section 4.2)
// ---------------------------------------------------------------------
interface KioskCardProps {
  scored: ScoredPerfume;
  rank?: number;
  locale: string;
  tagMap: Map<string, string>;
  matchLabel: string;
  shelfLabel: string;
  isCompact?: boolean;
}

function KioskPerfumeCard({
  scored,
  rank,
  locale,
  tagMap,
  matchLabel,
  shelfLabel,
  isCompact = false,
}: KioskCardProps) {
  const { perfume, matchPercentage } = scored;
  const description = resolveLocalized(perfume.description, locale);
  const isWinner = rank === 1;

  return (
    <article
      className={clsx(
        'group relative flex flex-col justify-between rounded-3xl border p-6 backdrop-blur-md transition-all duration-300',
        isWinner
          ? 'border-[#FF5500]/60 bg-gradient-to-b from-[#141418] via-[#101014] to-[#FF5500]/10 shadow-[0_0_35px_rgba(255,85,0,0.18)] ring-1 ring-[#FF5500]/40'
          : 'border-zinc-800 bg-[#121216] shadow-lg hover:border-zinc-700'
      )}
    >
      <div>
        {/* Top Badges */}
        <div className="flex items-center justify-between gap-2">
          {rank ? (
            <div className="inline-flex items-center gap-1.5 rounded-full bg-zinc-800 px-3 py-1 text-xs font-bold text-zinc-200">
              {isWinner && <Crown className="h-4 w-4 text-[#FF5500]" />}
              <span>#{rank}</span>
            </div>
          ) : (
            <div />
          )}

          <div
            className={clsx(
              'rounded-full px-3.5 py-1 text-xs font-black tracking-wide shadow-sm',
              isWinner
                ? 'bg-[#FF5500] text-zinc-950'
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
            isHero={!isCompact}
          />
        </div>

        {/* Perfume Identity */}
        <div className="mt-2 text-center sm:text-start">
          {perfume.brand && (
            <p className="font-latin text-xs font-bold tracking-widest text-[#FF5500] uppercase">
              {perfume.brand}
            </p>
          )}
          <h3
            className={clsx(
              'font-latin font-black tracking-tight text-white group-hover:text-[#FF5500] transition-colors',
              isCompact ? 'text-lg mt-0.5' : 'text-xl sm:text-2xl mt-0.5'
            )}
          >
            {perfume.name}
          </h3>
        </div>

        {/* Shelf Location Badge */}
        {perfume.shelf_location && (
          <div className="mt-3.5 flex items-center gap-2 rounded-xl border border-amber-500/30 bg-amber-500/10 px-3.5 py-2 text-xs font-bold text-amber-300 shadow-sm">
            <MapPin className="h-4 w-4 text-[#FF5500] shrink-0 animate-bounce" />
            <div className="flex flex-col sm:flex-row sm:items-center sm:gap-1.5">
              <span className="text-zinc-400 font-medium text-[11px]">{shelfLabel}</span>
              <span className="text-white tracking-wide">{perfume.shelf_location}</span>
            </div>
          </div>
        )}

        {/* Sensory Description (Tags hidden per user request) */}
        <p className="mt-3 text-xs leading-relaxed text-zinc-400 sm:text-sm">
          {description}
        </p>
      </div>

      {/* Price Footer */}
      {perfume.price && (
        <div className="mt-6 pt-4 border-t border-zinc-800/60 flex items-center justify-between text-xs">
          <span className="text-zinc-500 font-medium">
            {locale === 'ar' ? 'السعر' : 'Prix'}
          </span>
          <span className="font-bold text-white text-sm">
            {perfume.price} {locale === 'ar' ? 'د.ت' : 'TND'}
          </span>
        </div>
      )}
    </article>
  );
}
