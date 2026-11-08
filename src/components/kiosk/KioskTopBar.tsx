'use client';

import { useState } from 'react';
import { useRouter } from '@/i18n/routing';
import { useLocale, useTranslations } from 'next-intl';
import { useQuizStore } from '@/lib/store/useQuizStore';
import { LanguageSwitcher } from '../LanguageSwitcher';
import { PinModal } from './PinModal';
import { RotateCcw, Compass, Lock, AlertTriangle } from 'lucide-react';
import clsx from 'clsx';

interface KioskTopBarProps {
  isIdleWarning?: boolean;
  idleSeconds?: number;
}

export function KioskTopBar({ isIdleWarning = false, idleSeconds = 30 }: KioskTopBarProps) {
  const locale = useLocale();
  const router = useRouter();
  const t = useTranslations('kiosk');
  const { resetQuiz } = useQuizStore();
  const [isPinOpen, setIsPinOpen] = useState(false);

  const handleStartOver = () => {
    resetQuiz();
    router.push('/kiosk');
  };

  const handleUnlockSuccess = () => {
    useQuizStore.getState().setKioskLocked(false);
    router.push('/');
  };

  return (
    <>
      <header className="fixed top-0 inset-x-0 z-40 border-b border-zinc-800 bg-surface/90 backdrop-blur-md px-6 py-3 shadow-lg">
        {/* Inactivity Warning Banner (If active) */}
        {isIdleWarning && (
          <div className="mb-2 flex items-center justify-center gap-2 rounded-xl bg-amber-950/80 border border-amber-600/50 py-1.5 px-4 text-xs font-bold text-amber-300 animate-pulse">
            <AlertTriangle className="h-4 w-4" />
            <span>
              {t('idleWarning')} ({idleSeconds}s)
            </span>
          </div>
        )}

        <div className="flex items-center justify-between gap-4">
          {/* Left: Brand Identity */}
          <div className="flex items-center gap-2.5">
            <div className="flex h-9 w-9 items-center justify-center rounded-full border border-gold/40 bg-zinc-900">
              <Compass className="h-4 w-4 text-gold" />
            </div>
            <span className="hidden sm:inline text-xs font-bold tracking-widest text-zinc-300 uppercase">
              {locale === 'ar' ? 'بوتيك العطور • شاشة الزائر' : 'Boutique Kiosk Mode'}
            </span>
          </div>

          {/* Center: Dominant Persistent Reset Button (PRD Section 4.2 & Design Section 5) */}
          <button
            type="button"
            onClick={handleStartOver}
            className="group flex items-center gap-2 rounded-full border-2 border-gold/60 bg-gold/15 px-6 py-2.5 text-xs sm:text-sm font-extrabold text-gold shadow-[0_0_15px_rgba(212,175,55,0.2)] transition-transform duration-150 active:scale-95 hover:bg-gold hover:text-zinc-950 cursor-pointer"
          >
            <RotateCcw className="h-4 w-4 transition-transform group-hover:-rotate-90 duration-200" />
            <span>{t('startOver')}</span>
          </button>

          {/* Right: Language Switcher & Exit Lock */}
          <div className="flex items-center gap-3">
            <LanguageSwitcher />

            <button
              type="button"
              onClick={() => setIsPinOpen(true)}
              className="rounded-full p-2 text-zinc-500 transition-colors hover:bg-zinc-800 hover:text-zinc-300"
              aria-label="Unlock Kiosk"
              title="Unlock Kiosk"
            >
              <Lock className="h-4 w-4" />
            </button>
          </div>
        </div>
      </header>

      {/* 4-digit PIN Modal for exiting Kiosk */}
      <PinModal
        isOpen={isPinOpen}
        onClose={() => setIsPinOpen(false)}
        onSuccess={handleUnlockSuccess}
        locale={locale}
      />
    </>
  );
}
