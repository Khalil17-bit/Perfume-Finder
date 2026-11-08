'use client';

import { useEffect, useRef, useState, useCallback } from 'react';

interface UseIdleResetOptions {
  timeoutMs?: number; // Default 180,000ms (180s)
  warningMs?: number; // Time before timeout to trigger warning (e.g. 30,000ms)
  onTimeout: () => void;
  enabled?: boolean;
}

export function useIdleReset({
  timeoutMs = 180000,
  warningMs = 30000,
  onTimeout,
  enabled = true,
}: UseIdleResetOptions) {
  const [isWarning, setIsWarning] = useState(false);
  const [secondsRemaining, setSecondsRemaining] = useState(Math.round(warningMs / 1000));

  const lastActivityRef = useRef(Date.now());
  const timerRef = useRef<NodeJS.Timeout | null>(null);
  const intervalRef = useRef<NodeJS.Timeout | null>(null);

  const resetTimer = useCallback(() => {
    lastActivityRef.current = Date.now();
    if (isWarning) {
      setIsWarning(false);
      setSecondsRemaining(Math.round(warningMs / 1000));
    }
  }, [isWarning, warningMs]);

  useEffect(() => {
    if (!enabled) return;

    const events = ['touchstart', 'touchmove', 'mousedown', 'mousemove', 'keydown', 'scroll'];
    const handleActivity = () => {
      resetTimer();
    };

    events.forEach((event) => {
      window.addEventListener(event, handleActivity, { passive: true });
    });

    // Check inactivity every second
    intervalRef.current = setInterval(() => {
      const elapsed = Date.now() - lastActivityRef.current;
      const remaining = timeoutMs - elapsed;

      if (remaining <= 0) {
        onTimeout();
      } else if (remaining <= warningMs) {
        setIsWarning(true);
        setSecondsRemaining(Math.ceil(remaining / 1000));
      } else {
        if (isWarning) setIsWarning(false);
      }
    }, 1000);

    return () => {
      events.forEach((event) => {
        window.removeEventListener(event, handleActivity);
      });
      if (intervalRef.current) clearInterval(intervalRef.current);
      if (timerRef.current) clearTimeout(timerRef.current);
    };
  }, [enabled, timeoutMs, warningMs, onTimeout, resetTimer, isWarning]);

  return {
    isWarning,
    secondsRemaining,
    resetTimer,
  };
}
