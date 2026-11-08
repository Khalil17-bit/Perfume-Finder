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

export default function QuizPage() {
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

  // Current question answers
  const currentAnswers = FALLBACK_ANSWERS.filter(
    (ans) => ans.question_id === currentQuestion.id
  );

  const answeredCount = Object.keys(selectedAnswers).length;
  const totalQuestions = questions.length;
  const progressPercent = Math.round(((currentStepIndex + 1) / totalQuestions) * 100);
  const accuracyPercent = getAccuracyPercentage(totalQuestions);

  // Sync state if already answered
  useEffect(() => {
    const existing = selectedAnswers[currentQuestion.id] || null;
    setSelectedInCurrentStep(existing);
  }, [currentQuestion.id, selectedAnswers]);

  const handleSelectAnswer = (answerId: string) => {
    setSelectedInCurrentStep(answerId);
    selectAnswer(currentQuestion.id, answerId, false);

    // 300ms luxury delay before advancing (PRD Section 4 & Design Section 4)
    setTimeout(() => {
      if (currentStepIndex + 1 >= totalQuestions) {
        // Last question answered -> proceed to results
        startTransition(() => {
          router.push('/results');
        });
      } else {
        useQuizStore.getState().nextStep();
      }
    }, 300);
  };

  const handleEarlyExit = () => {
    startTransition(() => {
      router.push('/results');
    });
  };

  const handleBack = () => {
    if (currentStepIndex > 0) {
      goToPreviousStep();
    } else {
      router.push('/');
    }
  };

  const questionText = resolveLocalized(currentQuestion.question_text, locale);
  const helperText = resolveLocalized(currentQuestion.helper_text, locale);

  return (
    <div className="relative flex min-h-screen flex-col justify-between bg-background text-textPrimary select-none">
      {/* 1. Thin Accent Progress Bar (Top of Viewport) */}
      <div className="fixed top-0 inset-x-0 z-50 h-1 bg-surface">
        <div
          className="h-full bg-gradient-to-r from-amberAccent to-gold transition-all duration-300 ease-out"
          style={{ width: `${progressPercent}%` }}
        />
      </div>

      {/* 2. Top Header Bar: Back Button & Dynamic Accuracy Indicator */}
      <header className="relative z-20 flex w-full items-center justify-between px-6 pt-6 pb-2 sm:px-12">
        {/* Back Button */}
        <button
          type="button"
          onClick={handleBack}
          className="group inline-flex items-center gap-2 rounded-full border border-zinc-800 bg-surface/70 px-4 py-2 text-xs font-medium text-zinc-300 backdrop-blur-md transition-transform duration-150 active:scale-95 hover:border-gold/40 hover:text-gold"
          aria-label={t('back')}
        >
          {isRTL ? (
            <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-0.5" />
          ) : (
            <ArrowLeft className="h-4 w-4 transition-transform group-hover:-translate-x-0.5" />
          )}
          <span>{t('back')}</span>
        </button>

        {/* Dynamic Accuracy Indicator (PRD Section 5) */}
        <div className="inline-flex items-center gap-2 rounded-full border border-zinc-800/80 bg-surface/80 px-4 py-2 text-xs font-semibold text-zinc-200 backdrop-blur-md shadow-inner">
          <Zap className="h-3.5 w-3.5 text-gold animate-pulse" />
          <span className="text-zinc-400">{t('accuracyPrefix')}</span>
          <span className="font-bold text-gold">{accuracyPercent}%</span>
          <span className="hidden sm:inline text-zinc-500">
            ({currentStepIndex + 1}/{totalQuestions})
          </span>
        </div>
      </header>

      {/* 3. Main Question Container */}
      <main className="relative z-10 mx-auto flex w-full max-w-3xl flex-1 flex-col items-center justify-center px-6 py-6 text-center">
        {/* Step Pill */}
        <span className="mb-3 text-xs font-semibold tracking-widest text-gold uppercase">
          {t('question')} {currentStepIndex + 1} {t('of')} {totalQuestions}
        </span>

        {/* Large Centered Question */}
        <h2 className="max-w-2xl text-2xl font-bold tracking-tight text-zinc-50 sm:text-3xl md:text-4xl animate-fade-in">
          {questionText}
        </h2>

        {/* Helper Sub-prompt */}
        {helperText && (
          <p className="mt-2 text-sm text-textMuted sm:text-base animate-fade-in">
            {helperText}
          </p>
        )}

        {/* 4. Answers Grid (1-Col Mobile, 2-Col Tablet/Desktop) */}
        <div className="mt-8 grid w-full grid-cols-1 gap-4 sm:grid-cols-2">
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
                  'group relative flex min-h-[120px] flex-col justify-center rounded-2xl border p-5 text-start transition-all duration-200 active:scale-95 cursor-pointer',
                  isSelected
                    ? 'border-gold bg-gold/10 shadow-[0_0_20px_rgba(212,175,55,0.25)] scale-[0.98]'
                    : 'border-zinc-800 bg-surface/90 hover:border-zinc-700 hover:bg-surfaceElevated'
                )}
              >
                {/* Visual Checkmark indicator when active */}
                <div className="flex items-start justify-between gap-3">
                  <h3
                    className={clsx(
                      'text-base font-bold sm:text-lg transition-colors',
                      isSelected ? 'text-gold' : 'text-zinc-100 group-hover:text-zinc-50'
                    )}
                  >
                    {title}
                  </h3>
                  {isSelected && (
                    <CheckCircle2 className="h-5 w-5 text-gold shrink-0 animate-fade-in" />
                  )}
                </div>

                {/* Subtitle explanation */}
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

      {/* 5. Sticky Bottom Bar: Early Exit CTA (Unlocked after >= 2 answers) */}
      <footer className="relative z-20 flex min-h-[80px] w-full items-center justify-center border-t border-zinc-900 bg-background/80 backdrop-blur-md px-6 py-4">
        {canEarlyExit() ? (
          <button
            type="button"
            onClick={handleEarlyExit}
            disabled={isPending}
            className="group inline-flex items-center gap-2 rounded-full border border-gold/40 bg-gold/10 px-6 py-2.5 text-xs font-semibold text-gold shadow-sm backdrop-blur-md transition-all duration-200 active:scale-95 hover:bg-gold hover:text-zinc-950 sm:text-sm"
          >
            <Sparkles className="h-4 w-4 transition-transform group-hover:rotate-12" />
            <span>{t('skipAndShowResults')}</span>
          </button>
        ) : (
          <p className="text-xs text-zinc-500">
            {locale === 'ar'
              ? 'أجب عن سؤالين على الأقل لإمكانية عرض النتائج فوراً'
              : locale === 'fr'
              ? 'Répondez à au moins 2 questions pour afficher les résultats'
              : 'Answer at least 2 questions to unlock instant results'}
          </p>
        )}
      </footer>
    </div>
  );
}
