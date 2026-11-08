'use client';

import { useState } from 'react';
import { useTranslations } from 'next-intl';
import { Lock, Unlock, X, AlertCircle } from 'lucide-react';

interface PinModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  correctPin?: string;
  locale: string;
}

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

  if (!isOpen) return null;

  const handleDigit = (digit: string) => {
    if (pin.length < 4) {
      const next = pin + digit;
      setPin(next);
      setError(false);

      if (next.length === 4) {
        if (next === correctPin) {
          onSuccess();
          setPin('');
          onClose();
        } else {
          setError(true);
          setTimeout(() => {
            setPin('');
            setError(false);
          }, 800);
        }
      }
    }
  };

  const handleClear = () => {
    setPin('');
    setError(false);
  };

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
          <Lock className="h-5 w-5" />
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
                  error
                    ? 'border-red-500 bg-red-500 animate-bounce'
                    : isFilled
                    ? 'border-gold bg-gold scale-110 shadow-[0_0_10px_rgba(212,175,55,0.5)]'
                    : 'border-zinc-700 bg-zinc-900'
                }`}
              />
            );
          })}
        </div>

        {error && (
          <p className="mb-4 text-xs font-semibold text-red-400 flex items-center justify-center gap-1.5">
            <AlertCircle className="h-3.5 w-3.5" />
            <span>{locale === 'ar' ? 'رمز غير صحيح' : locale === 'fr' ? 'Code PIN incorrect' : 'Incorrect PIN'}</span>
          </p>
        )}

        {/* Numpad */}
        <div className="grid grid-cols-3 gap-3">
          {['1', '2', '3', '4', '5', '6', '7', '8', '9'].map((digit) => (
            <button
              key={digit}
              type="button"
              onClick={() => handleDigit(digit)}
              className="h-14 rounded-2xl border border-zinc-800 bg-zinc-900 text-lg font-bold text-zinc-100 transition-transform active:scale-95 hover:border-gold/40 hover:bg-zinc-800"
            >
              {digit}
            </button>
          ))}
          <button
            type="button"
            onClick={handleClear}
            className="h-14 rounded-2xl border border-zinc-800 bg-zinc-900/50 text-xs font-semibold text-zinc-400 transition-transform active:scale-95 hover:bg-zinc-800"
          >
            {locale === 'ar' ? 'مسح' : locale === 'fr' ? 'Effacer' : 'Clear'}
          </button>
          <button
            type="button"
            onClick={() => handleDigit('0')}
            className="h-14 rounded-2xl border border-zinc-800 bg-zinc-900 text-lg font-bold text-zinc-100 transition-transform active:scale-95 hover:border-gold/40 hover:bg-zinc-800"
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
