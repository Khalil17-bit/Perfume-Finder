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
  Check,
} from 'lucide-react';
import clsx from 'clsx';

export default function QuizPage() {
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
    goToStep,
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

  const answeredCount = Object.keys(selectedAnswers).length;
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
          router.push('/results');
        });
      } else {
        useQuizStore.getState().nextStep();
      }
    }, 300);
  };

  const handleEarlyExit = () => {
    if (advanceTimerRef.current) {
      clearTimeout(advanceTimerRef.current);
    }
    startTransition(() => {
      router.push('/results');
    });
  };

  const handleBack = () => {
    if (advanceTimerRef.current) {
      clearTimeout(advanceTimerRef.current);
    }
    if (safeIndex > 0) {
      goToPreviousStep();
    } else {
      router.push('/');
    }
  };

  const questionText = resolveLocalized(currentQuestion.question_text, locale);
  const helperText = resolveLocalized(currentQuestion.helper_text, locale);

  // Macro stages for the studio sidebar stepper (inspired by reference screenshot)
  const sidebarStages = [
    {
      step: 1,
      label:
        locale === 'ar'
          ? 'الهوية والطابع'
          : locale === 'fr'
          ? 'Identité & Sillage'
          : 'Select Identity & Vibe',
      active: safeIndex <= 1,
      done: safeIndex > 1,
      targetStep: 0,
    },
    {
      step: 2,
      label:
        locale === 'ar'
          ? 'المناسبة والفوحان'
          : locale === 'fr'
          ? 'Occasion & Intensité'
          : 'Choose Occasion & Sillage',
      active: safeIndex >= 2 && safeIndex <= 4,
      done: safeIndex > 4,
      targetStep: 2,
    },
    {
      step: 3,
      label:
        locale === 'ar'
          ? 'التركيز والملمس العطري'
          : locale === 'fr'
          ? 'Concentration & Texture'
          : 'Customize Notes & Texture',
      active: safeIndex >= 5 && safeIndex <= 7,
      done: safeIndex > 7,
      targetStep: 5,
    },
    {
      step: 4,
      label:
        locale === 'ar'
          ? 'الحضور والنتائج النهائية'
          : locale === 'fr'
          ? 'Signature & Résultats'
          : 'Persona & Final Matches',
      active: safeIndex >= 8,
      done: false,
      targetStep: 8,
    },
  ];

  return (
    <div className="relative flex min-h-screen flex-col lg:flex-row bg-[#0B0B0D] text-textPrimary select-none">
      {/* Top Mobile Progress Bar */}
      <div className="fixed top-0 inset-x-0 z-50 h-1 bg-[#1B1B20] lg:hidden">
        <div
          className="h-full bg-[#FF5500] transition-transform duration-300 ease-out origin-left"
          style={{ width: `${progressPercent}%` }}
        />
      </div>

      {/* LEFT STUDIO SIDEBAR (Matches "SEAMLESS CUSTOM BUNDLES" Reference UI) */}
      <aside className="hidden lg:flex lg:w-72 xl:w-80 shrink-0 flex-col justify-between border-e border-[#1E1E24] bg-[#0E0E11] p-8">
        <div>
          {/* Top Profile Counter & Orange Progress Bar */}
          <span className="text-[11px] font-semibold tracking-[0.18em] text-[#8E8E98] uppercase">
            {locale === 'ar'
              ? 'بصمتك العطرية'
              : locale === 'fr'
              ? 'VOTRE PROFIL OLFACTIF'
              : 'YOUR SCENT PROFILE'}
          </span>

          <div className="mt-3 flex items-baseline justify-between">
            <p className="text-2xl font-bold tracking-tight text-white">
              {answeredCount} {locale === 'ar' ? 'من' : 'of'} {totalQuestions}{' '}
              <span className="block text-lg font-medium text-zinc-300">
                {locale === 'ar' ? 'تم اختيارها' : locale === 'fr' ? 'sélectionnés' : 'selected'}
              </span>
            </p>
          </div>

          {/* Crisp Orange Progress Bar */}
          <div className="mt-4 h-1.5 w-full overflow-hidden rounded-full bg-[#222228]">
            <div
              className="h-full rounded-full bg-[#FF5500] transition-all duration-300 ease-out"
              style={{ width: `${Math.max(10, progressPercent)}%` }}
            />
          </div>

          {/* Connected Vertical Stepper */}
          <nav className="mt-12 space-y-6 relative" aria-label="Quiz Stages">
            {sidebarStages.map((stage, idx) => (
              <div key={stage.step} className="relative flex items-center gap-3.5">
                {idx < sidebarStages.length - 1 && (
                  <div
                    className={clsx(
                      'absolute top-8 start-3.5 -bottom-6 w-px',
                      stage.done ? 'bg-[#FF5500]/50' : 'bg-[#25252C]'
                    )}
                    aria-hidden="true"
                  />
                )}
                <button
                  type="button"
                  disabled={stage.targetStep > answeredCount}
                  onClick={() => goToStep(stage.targetStep)}
                  className={clsx(
                    'relative z-10 flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-xs font-bold transition-colors',
                    stage.active
                      ? 'bg-[#FF5500] text-zinc-950 shadow-[0_0_14px_rgba(255,85,0,0.45)]'
                      : stage.done
                      ? 'bg-[#FF5500]/20 text-[#FF5500] border border-[#FF5500]/40 cursor-pointer'
                      : 'bg-[#1C1C22] text-zinc-500 border border-[#2A2A32]'
                  )}
                >
                  {stage.done ? <Check className="h-3.5 w-3.5 stroke-[2.5]" /> : stage.step}
                </button>
                <span
                  className={clsx(
                    'text-xs font-medium transition-colors',
                    stage.active
                      ? 'text-white font-semibold'
                      : stage.done
                      ? 'text-zinc-300'
                      : 'text-zinc-500'
                  )}
                >
                  {stage.label}
                </span>
              </div>
            ))}
          </nav>
        </div>

        {/* Bottom Curated Info Card (Matches Reference Screenshot Bottom-Left Box) */}
        <div className="rounded-2xl border border-[#222228] bg-[#121216] p-5">
          <Sparkles className="h-4 w-4 text-[#FF5500] mb-3" />
          <h4 className="text-xs font-bold text-zinc-100 leading-snug">
            {locale === 'ar'
              ? 'مصمم خصيصاً لشخصيتك'
              : locale === 'fr'
              ? 'Sélectionné pour votre aura'
              : 'Curated for your persona'}
          </h4>
          <p className="mt-1.5 text-[11px] leading-relaxed text-[#8E8E98]">
            {locale === 'ar'
              ? 'يتم تحليل كل إجابة لمطابقة أدق النوتات العطرية الفاخرة مع ذوقك الخاص.'
              : locale === 'fr'
              ? 'Chaque création est rigoureusement filtrée pour révéler votre signature idéale.'
              : 'Every composition is handpicked and scored to support your signature presence.'}
          </p>
        </div>
      </aside>

      {/* RIGHT MAIN STAGE */}
      <div className="flex flex-1 flex-col justify-between min-w-0">
        {/* Top Navigation & Accuracy Bar */}
        <header className="relative z-20 flex w-full items-center justify-between px-6 pt-6 pb-2 sm:px-10">
          <button
            type="button"
            onClick={handleBack}
            className="group inline-flex items-center gap-2 rounded-full border border-[#26262E] bg-[#141417] px-4 py-2 text-xs font-medium text-zinc-300 transition-transform duration-150 active:scale-95 hover:border-[#FF5500]/50 hover:text-white cursor-pointer"
            aria-label={t('back')}
          >
            {isRTL ? (
              <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-0.5" />
            ) : (
              <ArrowLeft className="h-4 w-4 transition-transform group-hover:-translate-x-0.5" />
            )}
            <span>{t('back')}</span>
          </button>

          {/* Dynamic Accuracy Indicator */}
          <div className="inline-flex items-center gap-2 rounded-full border border-[#26262E] bg-[#141417] px-4 py-2 text-xs font-semibold text-zinc-200">
            <Zap className="h-3.5 w-3.5 text-[#FF5500]" />
            <span className="text-[#8E8E98]">{t('accuracyPrefix')}</span>
            <span className="font-bold text-[#FF5500]">{accuracyPercent}%</span>
            <span className="hidden sm:inline text-zinc-500">
              ({safeIndex + 1}/{totalQuestions})
            </span>
          </div>
        </header>

        {/* Main Editorial Question & Studio Cards Grid */}
        <main className="relative z-10 mx-auto flex w-full max-w-4xl flex-1 flex-col justify-center px-6 py-6 sm:px-10">
          {/* Editorial Header */}
          <div className="max-w-2xl">
            <span className="inline-block text-[11px] font-bold tracking-[0.2em] text-[#FF5500] uppercase mb-2">
              {t('question')} {safeIndex + 1} {t('of')} {totalQuestions}
            </span>

            <h1 className="text-2xl font-black tracking-tight text-white sm:text-4xl md:text-[42px] md:leading-[1.08] uppercase animate-fade-in">
              {questionText}
            </h1>

            {helperText && (
              <p className="mt-3 text-xs sm:text-sm text-[#8E8E98] leading-relaxed animate-fade-in">
                {helperText}
              </p>
            )}
          </div>

          {/* Section Sub-Header matching reference ("Select your products" -> "Select your preference") */}
          <div className="mt-8 mb-4 flex items-center justify-between">
            <h2 className="text-xs sm:text-sm font-semibold text-zinc-200 tracking-tight">
              {locale === 'ar'
                ? 'اختر التفضيل الأنسب لك'
                : locale === 'fr'
                ? 'Sélectionnez votre préférence'
                : 'Select your preference'}
            </h2>
            <span className="text-[11px] text-zinc-500 font-mono">
              {currentAnswers.length} {locale === 'ar' ? 'خيارات' : 'options'}
            </span>
          </div>

          {/* Studio Object Cards Grid */}
          <div
            className={clsx(
              'grid w-full gap-4 sm:gap-5',
              currentAnswers.length === 3
                ? 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3'
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
                />
              );
            })}
          </div>
        </main>

        {/* Sticky Bottom Bar: Early Exit CTA (Unlocked after >= 2 answers) */}
        <footer className="relative z-20 flex min-h-[76px] w-full items-center justify-between border-t border-[#1C1C22] bg-[#0B0B0D]/90 backdrop-blur-md px-6 sm:px-10 py-4">
          <span className="text-xs text-[#8E8E98]">
            {canEarlyExit()
              ? locale === 'ar'
                ? 'يمكنك عرض العطور المطابقة الآن أو إكمال الأسئلة لدقة أعلى'
                : locale === 'fr'
                ? 'Vous pouvez afficher vos résultats ou continuer pour plus de précision'
                : 'Ready for instant matches, or continue for higher precision'
              : locale === 'ar'
              ? 'أجب عن سؤالين على الأقل لإمكانية عرض النتائج فوراً'
              : locale === 'fr'
              ? 'Répondez à au moins 2 questions pour afficher les résultats'
              : 'Answer at least 2 questions to unlock instant results'}
          </span>

          {canEarlyExit() && (
            <button
              type="button"
              onClick={handleEarlyExit}
              disabled={isPending}
              className="group inline-flex items-center gap-2 rounded-full bg-[#FF5500] px-6 py-2.5 text-xs font-bold text-zinc-950 shadow-[0_0_20px_rgba(255,85,0,0.35)] transition-transform duration-200 active:scale-95 hover:bg-[#FF7129] cursor-pointer sm:text-sm"
            >
              <Sparkles className="h-4 w-4 transition-transform group-hover:rotate-12" />
              <span>{t('skipAndShowResults')}</span>
            </button>
          )}
        </footer>
      </div>
    </div>
  );
}
