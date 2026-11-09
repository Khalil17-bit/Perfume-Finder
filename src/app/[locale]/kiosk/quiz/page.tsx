'use client';

import { useEffect, useRef, useState, useTransition } from 'react';
import { useRouter } from '@/i18n/routing';
import { useLocale, useTranslations } from 'next-intl';
import { useQuizStore } from '@/lib/store/useQuizStore';
import {
  FALLBACK_QUESTIONS,
  FALLBACK_ANSWERS,
} from '@/lib/data/fallback-data';
import { resolveLocalized } from '@/lib/i18n-helper';
import { ParallaxAnswerCard } from '@/components/quiz/ParallaxAnswerCard';
import {
  ArrowLeft,
  ArrowRight,
  Sparkles,
  Zap,
} from 'lucide-react';
import clsx from 'clsx';

export default function KioskQuizPage() {
  const locale = useLocale();
  const router = useRouter();
  const t = useTranslations('quiz');
  const isRTL = locale === 'ar';

  const [isPending, startTransition] = useTransition();
  const [selectedInCurrentStep, setSelectedInCurrentStep] = useState<string | null>(null);
  const advanceTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  const {
    selectedAnswers,
    currentStepIndex,
    selectAnswer,
    goToPreviousStep,
    canEarlyExit,
    getAccuracyPercentage,
  } = useQuizStore();

  const questions = FALLBACK_QUESTIONS;
  const totalQuestions = questions.length;
  const safeIndex = Math.min(Math.max(0, currentStepIndex), totalQuestions - 1);
  const currentQuestion = questions[safeIndex] || questions[0];

  const currentAnswers = FALLBACK_ANSWERS.filter(
    (ans) => ans.question_id === currentQuestion.id
  );

  const progressPercent = Math.round(((safeIndex + 1) / totalQuestions) * 100);
  const accuracyPercent = getAccuracyPercentage(totalQuestions);

  useEffect(() => {
    const existing = selectedAnswers[currentQuestion.id] || null;
    setSelectedInCurrentStep(existing);
  }, [currentQuestion.id, selectedAnswers]);

  useEffect(() => {
    return () => {
      if (advanceTimerRef.current) {
        clearTimeout(advanceTimerRef.current);
      }
    };
  }, []);

  const handleSelectAnswer = (answerId: string) => {
    if (advanceTimerRef.current) {
      clearTimeout(advanceTimerRef.current);
    }

    setSelectedInCurrentStep(answerId);
    selectAnswer(currentQuestion.id, answerId, false);

    advanceTimerRef.current = setTimeout(() => {
      advanceTimerRef.current = null;
      if (safeIndex + 1 >= totalQuestions) {
        startTransition(() => {
          router.push('/kiosk/results');
        });
      } else {
        useQuizStore.getState().nextStep();
      }
    }, 40);
  };

  const handleEarlyExit = () => {
    if (advanceTimerRef.current) {
      clearTimeout(advanceTimerRef.current);
    }
    startTransition(() => {
      router.push('/kiosk/results');
    });
  };

  const handleBack = () => {
    if (advanceTimerRef.current) {
      clearTimeout(advanceTimerRef.current);
    }
    if (safeIndex > 0) {
      goToPreviousStep();
    } else {
      router.push('/kiosk');
    }
  };

  const questionText = resolveLocalized(currentQuestion.question_text, locale);
  const helperText = resolveLocalized(currentQuestion.helper_text, locale);

  return (
    <div className="relative flex min-h-[calc(100vh-80px)] flex-col justify-between bg-[#0B0B0D] px-6 py-6 sm:px-12 select-none">
      {/* Question Progress Line */}
      <div className="fixed top-[65px] inset-x-0 z-30 h-1 bg-[#1B1B20]">
        <div
          className="h-full bg-[#FF5500] transition-all duration-300 ease-out"
          style={{ width: `${progressPercent}%` }}
        />
      </div>

      {/* Sub-Header: Back & Accuracy Indicator */}
      <div className="flex items-center justify-between">
        <button
          type="button"
          onClick={handleBack}
          className="group inline-flex items-center gap-2.5 rounded-full border border-[#26262E] bg-[#141417] px-5 py-2.5 text-xs sm:text-sm font-semibold text-zinc-300 transition-transform active:scale-95 hover:border-[#FF5500]/50 hover:text-white cursor-pointer"
        >
          {isRTL ? (
            <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
          ) : (
            <ArrowLeft className="h-4 w-4 transition-transform group-hover:-translate-x-1" />
          )}
          <span>{t('back')}</span>
        </button>

        <div className="inline-flex items-center gap-2 rounded-full border border-[#26262E] bg-[#141417] px-4 py-2 text-xs sm:text-sm font-bold text-zinc-200">
          <Zap className="h-4 w-4 text-[#FF5500]" />
          <span className="text-[#8E8E98]">{t('accuracyPrefix')}</span>
          <span className="text-[#FF5500]">{accuracyPercent}%</span>
          <span className="text-zinc-500 hidden sm:inline">
            ({safeIndex + 1}/{totalQuestions})
          </span>
        </div>
      </div>

      {/* Main Question Focus */}
      <main className="mx-auto flex w-full max-w-5xl flex-1 flex-col justify-center py-6">
        <div className="max-w-3xl">
          <span className="mb-2 inline-block text-xs sm:text-sm font-bold tracking-[0.2em] text-[#FF5500] uppercase">
            {t('question')} {safeIndex + 1} {t('of')} {totalQuestions}
          </span>

          <h2 className="text-2xl font-black tracking-tight text-white sm:text-4xl md:text-5xl uppercase animate-fade-in">
            {questionText}
          </h2>

          {helperText && (
            <p className="mt-3 text-sm sm:text-base text-[#8E8E98] max-w-2xl animate-fade-in">
              {helperText}
            </p>
          )}
        </div>

        {/* Oversized Kiosk Studio Object Cards */}
        <div
          className={clsx(
            'mt-8 grid w-full gap-5',
            currentAnswers.length === 3
              ? 'grid-cols-1 sm:grid-cols-3'
              : 'grid-cols-1 sm:grid-cols-2'
          )}
        >
          {currentAnswers.map((answer, idx) => {
            const isSelected = selectedInCurrentStep === answer.id;
            const title = resolveLocalized(answer.title, locale);
            const subtitle = resolveLocalized(answer.subtitle_explanation, locale);

            return (
              <ParallaxAnswerCard
                key={answer.id}
                id={answer.id}
                index={idx}
                title={title}
                subtitle={subtitle}
                imageUrl={answer.image_url}
                isSelected={isSelected}
                onSelect={handleSelectAnswer}
                isKiosk
              />
            );
          })}
        </div>
      </main>

      {/* Sticky Bottom Bar: Early Exit */}
      <footer className="flex min-h-[70px] w-full items-center justify-center py-4">
        {canEarlyExit() ? (
          <button
            type="button"
            onClick={handleEarlyExit}
            disabled={isPending}
            className="group inline-flex items-center gap-2.5 rounded-full bg-[#FF5500] px-8 py-3 text-xs sm:text-sm font-bold text-zinc-950 shadow-[0_0_24px_rgba(255,85,0,0.4)] transition-transform active:scale-95 hover:bg-[#FF7129] cursor-pointer"
          >
            <Sparkles className="h-4 w-4 transition-transform group-hover:rotate-12" />
            <span>{t('skipAndShowResults')}</span>
          </button>
        ) : (
          <p className="text-xs text-[#8E8E98]">
            {locale === 'ar'
              ? 'أجب عن سؤالين على الأقل لإمكانية عرض التوصيات فوراً'
              : locale === 'fr'
              ? 'Répondez à 2 questions pour afficher les résultats'
              : 'Answer at least 2 questions to unlock instant results'}
          </p>
        )}
      </footer>
    </div>
  );
}
