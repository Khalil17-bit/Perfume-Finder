'use client';

import { ReactNode, useEffect, useCallback } from 'react';
import { useRouter } from '@/i18n/routing';
import { useQuizStore } from '@/lib/store/useQuizStore';
import { useIdleReset } from '@/lib/hooks/useIdleReset';
import { KioskTopBar } from '@/components/kiosk/KioskTopBar';

export default function KioskLayout({ children }: { children: ReactNode }) {
  const router = useRouter();
  const { setMode, resetQuiz } = useQuizStore();

  useEffect(() => {
    setMode('kiosk');
  }, [setMode]);

  const handleIdleTimeout = useCallback(() => {
    resetQuiz();
    router.push('/kiosk');
  }, [resetQuiz, router]);

  // 180s Inactivity Watchdog (PRD Section 4.2)
  const { isWarning, secondsRemaining } = useIdleReset({
    timeoutMs: 180000, // 180 seconds
    warningMs: 30000,  // Show warning at 30 seconds
    onTimeout: handleIdleTimeout,
    enabled: true,
  });

  return (
    <div className="relative min-h-screen bg-background text-textPrimary select-none touch-manipulation">
      {/* Persistent Reset Header */}
      <KioskTopBar isIdleWarning={isWarning} idleSeconds={secondsRemaining} />

      {/* Main Content with top padding offset */}
      <div className="pt-20">
        {children}
      </div>
    </div>
  );
}
