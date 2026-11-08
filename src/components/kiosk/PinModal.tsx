'use client';

import { useEffect, useState } from 'react';
import { useTranslations } from 'next-intl';
import { Lock, X, AlertCircle, ShieldAlert } from 'lucide-react';
import { createClient } from '@/lib/supabase/client';

interface PinModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  correctPin?: string;
  locale: string;
}

const MAX_ATTEMPTS = 5;
const LOCKOUT_SECONDS = 30;

export function PinModal({
  isOpen,
  onClose,
  onSuccess,
  correctPin = '1234',
  locale,
}: PinModalProps) {
  const t = useTranslations('kiosk');
  const [pin, setPin] = useState('');
  const [error, setError] = useState(false);
  const [failedAttempts, setFailedAttempts] = useState(0);
  const [lockoutRemaining, setLockoutRemaining] = useState(0);
  const [isVerifying, setIsVerifying] = useState(false);

  useEffect(() => {
    if (lockoutRemaining <= 0) return;
    const timer = setInterval(() => {
      setLockoutRemaining((prev) => {
        if (prev <= 1) {
          setFailedAttempts(0);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    return () => clearInterval(timer);
  }, [lockoutRemaining]);

  if (!isOpen) return null;

  const verifyPinAttempt = async (candidate: string): Promise<boolean> => {
    try {
      const supabase = createClient();
      const { data, error: rpcError } = await (supabase as any).rpc('verify_kiosk_pin', {
        pin_attempt: candidate,
      });
      if (!rpcError && typeof data === 'boolean') {
        return data;
      }
    } catch {
      // Fallback to local constant-length check if offline / unmigrated
    }
    if (candidate.length !== correctPin.length) return false;
    let diff = 0;
    for (let i = 0; i < candidate.length; i++) {
      diff |= candidate.charCodeAt(i) ^ correctPin.charCodeAt(i);
    }
    return diff === 0;
  };

  const handleDigit = async (digit: string) => {
    if (lockoutRemaining > 0 || isVerifying) return;

    if (pin.length < 4) {
      const next = pin + digit;
      setPin(next);
      setError(false);

      if (next.length === 4) {
        setIsVerifying(true);
        const isValid = await verifyPinAttempt(next);
        setIsVerifying(false);

        if (isValid) {
          setFailedAttempts(0);
          setPin('');
          onSuccess();
          onClose();
        } else {
          const nextAttempts = failedAttempts + 1;
          setFailedAttempts(nextAttempts);
          setError(true);

          if (nextAttempts >= MAX_ATTEMPTS) {
            setLockoutRemaining(LOCKOUT_SECONDS);
          }

          setTimeout(() => {
            setPin('');
            setError(false);
          }, 800);
        }
      }
    }
  };

  const handleClear = () => {
    if (lockoutRemaining > 0 || isVerifying) return;
    setPin('');
    setError(false);
  };

  const isLockedOut = lockoutRemaining > 0;

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="pin-modal-title"
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-zinc-950/90 backdrop-blur-md animate-fade-in"
    >
      <div className="relative w-full max-w-sm rounded-3xl border border-zinc-800 bg-surface p-8 shadow-2xl text-center">
        <button
          type="button"
          onClick={onClose}
          className="absolute top-4 right-4 rounded-full p-2 text-zinc-400 hover:text-zinc-200"
          aria-label="Close"
        >
          <X className="h-5 w-5" />
        </button>

        <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full border border-gold/40 bg-gold/10 text-gold mb-3">
          {isLockedOut ? <ShieldAlert className="h-5 w-5 text-red-400" /> : <Lock className="h-5 w-5" />}
        </div>

        <h3 id="pin-modal-title" className="text-lg font-bold text-zinc-50">
          {t('pinPrompt')}
        </h3>

        {/* PIN Indicators */}
        <div className="my-6 flex justify-center gap-4">
          {[0, 1, 2, 3].map((idx) => {
            const isFilled = pin.length > idx;
            return (
              <div
                key={idx}
                className={`h-4 w-4 rounded-full border transition-all ${
                  error || isLockedOut
                    ? 'border-red-500 bg-red-500 animate-bounce'
                    : isFilled
                    ? 'border-gold bg-gold scale-110 shadow-[0_0_10px_rgba(255,85,0,0.5)]'
                    : 'border-zinc-700 bg-zinc-900'
                }`}
              />
            );
          })}
        </div>

        {isLockedOut ? (
          <p className="mb-4 text-xs font-semibold text-red-400 flex items-center justify-center gap-1.5">
            <ShieldAlert className="h-3.5 w-3.5 shrink-0" />
            <span>
              {locale === 'ar'
                ? `تم القفل مؤقتاً للحماية (${lockoutRemaining} ثانية)`
                : locale === 'fr'
                ? `Verrouillage de sécurité (${lockoutRemaining}s)`
                : `Too many attempts. Locked for ${lockoutRemaining}s`}
            </span>
          </p>
        ) : (
          error && (
            <p className="mb-4 text-xs font-semibold text-red-400 flex items-center justify-center gap-1.5">
              <AlertCircle className="h-3.5 w-3.5" />
              <span>
                {locale === 'ar'
                  ? 'رمز غير صحيح'
                  : locale === 'fr'
                  ? 'Code PIN incorrect'
                  : 'Incorrect PIN'}
              </span>
            </p>
          )
        )}

        {/* Numpad */}
        <div className="grid grid-cols-3 gap-3">
          {['1', '2', '3', '4', '5', '6', '7', '8', '9'].map((digit) => (
            <button
              key={digit}
              type="button"
              disabled={isLockedOut || isVerifying}
              onClick={() => handleDigit(digit)}
              className="h-14 rounded-2xl border border-zinc-800 bg-zinc-900 text-lg font-bold text-zinc-100 transition-transform active:scale-95 hover:border-gold/40 hover:bg-zinc-800 disabled:opacity-40"
            >
              {digit}
            </button>
          ))}
          <button
            type="button"
            disabled={isLockedOut || isVerifying}
            onClick={handleClear}
            className="h-14 rounded-2xl border border-zinc-800 bg-zinc-900/50 text-xs font-semibold text-zinc-400 transition-transform active:scale-95 hover:bg-zinc-800 disabled:opacity-40"
          >
            {locale === 'ar' ? 'مسح' : locale === 'fr' ? 'Effacer' : 'Clear'}
          </button>
          <button
            type="button"
            disabled={isLockedOut || isVerifying}
            onClick={() => handleDigit('0')}
            className="h-14 rounded-2xl border border-zinc-800 bg-zinc-900 text-lg font-bold text-zinc-100 transition-transform active:scale-95 hover:border-gold/40 hover:bg-zinc-800 disabled:opacity-40"
          >
            0
          </button>
          <button
            type="button"
            onClick={onClose}
            className="h-14 rounded-2xl border border-zinc-800 bg-zinc-900/50 text-xs font-semibold text-zinc-400 transition-transform active:scale-95 hover:bg-zinc-800"
          >
            {locale === 'ar' ? 'إلغاء' : locale === 'fr' ? 'Annuler' : 'Cancel'}
          </button>
        </div>
      </div>
    </div>
  );
}
