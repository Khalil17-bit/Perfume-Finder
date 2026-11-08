'use client';

import { useEffect, useState, useTransition } from 'react';
import { useRouter } from '@/i18n/routing';
import { useLocale, useTranslations } from 'next-intl';
import { useQuizStore } from '@/lib/store/useQuizStore';
import {
  FALLBACK_QUESTIONS,
  FALLBACK_ANSWERS,
} from '@/lib/data/fallback-data';
import { resolveLocalized } from '@/lib/i18n-helper';
import {
  ArrowLeft,
  ArrowRight,
  Sparkles,
  Zap,
  CheckCircle2,
} from 'lucide-react';
import clsx from 'clsx';

export default function KioskQuizPage() {
  const locale = useLocale();
  const router = useRouter();
  const t = useTranslations('quiz');
  const isRTL = locale === 'ar';

  const [isPending, startTransition] = useTransition();
  const [selectedInCurrentStep, setSelectedInCurrentStep] = useState<string | null>(null);

  const {
    selectedAnswers,
    currentStepIndex,
    selectAnswer,
    goToPreviousStep,
    canEarlyExit,
    getAccuracyPercentage,
  } = useQuizStore();

  const questions = FALLBACK_QUESTIONS;
  const currentQuestion = questions[currentStepIndex] || questions[0];

  const currentAnswers = FALLBACK_ANSWERS.filter(
    (ans) => ans.question_id === currentQuestion.id
  );

  const totalQuestions = questions.length;
  const progressPercent = Math.round(((currentStepIndex + 1) / totalQuestions) * 100);
  const accuracyPercent = getAccuracyPercentage(totalQuestions);

  useEffect(() => {
    const existing = selectedAnswers[currentQuestion.id] || null;
    setSelectedInCurrentStep(existing);
  }, [currentQuestion.id, selectedAnswers]);

  const handleSelectAnswer = (answerId: string) => {
    setSelectedInCurrentStep(answerId);
    selectAnswer(currentQuestion.id, answerId, false);

    // 300ms touch delay before auto-advancing
    setTimeout(() => {
      if (currentStepIndex + 1 >= totalQuestions) {
        startTransition(() => {
          router.push('/kiosk/results');
        });
      } else {
        useQuizStore.getState().nextStep();
      }
    }, 300);
  };

  const handleEarlyExit = () => {
    startTransition(() => {
      router.push('/kiosk/results');
    });
  };

  const handleBack = () => {
    if (currentStepIndex > 0) {
      goToPreviousStep();
    } else {
      router.push('/kiosk');
    }
  };

  const questionText = resolveLocalized(currentQuestion.question_text, locale);
  const helperText = resolveLocalized(currentQuestion.helper_text, locale);

  return (
    <div className="relative flex min-h-[calc(100vh-80px)] flex-col justify-between px-6 py-6 sm:px-12">
      {/* Question Progress Line */}
      <div className="fixed top-[65px] inset-x-0 z-30 h-1 bg-surface">
        <div
          className="h-full bg-gradient-to-r from-amberAccent to-gold transition-all duration-300 ease-out"
          style={{ width: `${progressPercent}%` }}
        />
      </div>

      {/* Sub-Header: Back & Accuracy Indicator */}
      <div className="flex items-center justify-between">
        <button
          type="button"
          onClick={handleBack}
          className="group inline-flex items-center gap-2.5 rounded-full border border-zinc-800 bg-surface/80 px-5 py-2.5 text-xs sm:text-sm font-semibold text-zinc-300 backdrop-blur-md transition-transform active:scale-95 hover:border-gold/40 hover:text-gold cursor-pointer"
        >
          {isRTL ? (
            <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
          ) : (
            <ArrowLeft className="h-4 w-4 transition-transform group-hover:-translate-x-1" />
          )}
          <span>{t('back')}</span>
        </button>

        <div className="inline-flex items-center gap-2 rounded-full border border-zinc-800 bg-surface/90 px-4 py-2 text-xs sm:text-sm font-bold text-zinc-200">
          <Zap className="h-4 w-4 text-gold animate-pulse" />
          <span className="text-zinc-400">{t('accuracyPrefix')}</span>
          <span className="text-gold">{accuracyPercent}%</span>
          <span className="text-zinc-500 hidden sm:inline">
            ({currentStepIndex + 1}/{totalQuestions})
          </span>
        </div>
      </div>

      {/* Main Question Focus */}
      <main className="mx-auto flex w-full max-w-4xl flex-1 flex-col items-center justify-center py-6 text-center">
        <span className="mb-2 text-xs sm:text-sm font-bold tracking-widest text-gold uppercase">
          {t('question')} {currentStepIndex + 1} {t('of')} {totalQuestions}
        </span>

        <h2 className="max-w-3xl text-2xl font-black tracking-tight text-zinc-50 sm:text-4xl md:text-5xl animate-fade-in">
          {questionText}
        </h2>

        {helperText && (
          <p className="mt-3 text-sm sm:text-lg text-textMuted max-w-2xl animate-fade-in">
            {helperText}
          </p>
        )}

        {/* Oversized Kiosk Touch Cards (2-Column Grid on Tablet) */}
        <div className="mt-8 grid w-full grid-cols-1 gap-5 sm:grid-cols-2">
          {currentAnswers.map((answer) => {
            const isSelected = selectedInCurrentStep === answer.id;
            const title = resolveLocalized(answer.title, locale);
            const subtitle = resolveLocalized(answer.subtitle_explanation, locale);

            return (
              <button
                key={answer.id}
                type="button"
                onClick={() => handleSelectAnswer(answer.id)}
                className={clsx(
                  'group relative flex min-h-[140px] flex-col justify-center rounded-3xl border p-6 text-start transition-all duration-200 active:scale-95 cursor-pointer',
                  isSelected
                    ? 'border-gold bg-gold/15 shadow-[0_0_25px_rgba(212,175,55,0.3)] ring-2 ring-gold/40 scale-[0.98]'
                    : 'border-zinc-800 bg-surface/90 hover:border-zinc-700 hover:bg-surfaceElevated'
                )}
              >
                <div className="flex items-start justify-between gap-3">
                  <h3
                    className={clsx(
                      'text-lg font-bold sm:text-xl transition-colors',
                      isSelected ? 'text-gold' : 'text-zinc-100 group-hover:text-zinc-50'
                    )}
                  >
                    {title}
                  </h3>
                  {isSelected && (
                    <CheckCircle2 className="h-6 w-6 text-gold shrink-0 animate-fade-in" />
                  )}
                </div>

                {subtitle && (
                  <p className="mt-2 text-xs leading-relaxed text-textMuted sm:text-sm">
                    {subtitle}
                  </p>
                )}
              </button>
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
            className="group inline-flex items-center gap-2.5 rounded-full border border-gold/50 bg-gold/15 px-8 py-3 text-xs sm:text-sm font-bold text-gold shadow-md backdrop-blur-md transition-all active:scale-95 hover:bg-gold hover:text-zinc-950 cursor-pointer"
          >
            <Sparkles className="h-4 w-4 transition-transform group-hover:rotate-12" />
            <span>{t('skipAndShowResults')}</span>
          </button>
        ) : (
          <p className="text-xs text-zinc-500">
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
