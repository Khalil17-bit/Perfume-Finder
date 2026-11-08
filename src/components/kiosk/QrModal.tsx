'use client';

import { QRCodeSVG } from 'qrcode.react';
import { useTranslations } from 'next-intl';
import { X, Smartphone, UserPlus, CheckCircle2 } from 'lucide-react';

interface QrModalProps {
  isOpen: boolean;
  onClose: () => void;
  onDoneNewCustomer: () => void;
  qrUrl: string;
  locale: string;
}

export function QrModal({
  isOpen,
  onClose,
  onDoneNewCustomer,
  qrUrl,
  locale,
}: QrModalProps) {
  const t = useTranslations('kiosk');

  if (!isOpen) return null;

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="qr-modal-title"
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-zinc-950/85 backdrop-blur-md animate-fade-in"
    >
      <div className="relative w-full max-w-lg rounded-3xl border border-zinc-800 bg-surface p-8 shadow-2xl text-center">
        {/* Close Button */}
        <button
          type="button"
          onClick={onClose}
          className="absolute top-5 right-5 rounded-full p-2 text-zinc-400 transition-colors hover:bg-zinc-800 hover:text-zinc-200"
          aria-label="Close"
        >
          <X className="h-5 w-5" />
        </button>

        {/* Modal Header */}
        <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full border border-gold/40 bg-gold/10 text-gold mb-4">
          <Smartphone className="h-6 w-6" />
        </div>

        <h3 id="qr-modal-title" className="text-xl font-bold tracking-tight text-zinc-50 sm:text-2xl">
          {t('saveToPhone')}
        </h3>

        <p className="mt-2 text-xs leading-relaxed text-textMuted sm:text-sm max-w-sm mx-auto">
          {t('scanPrompt')}
        </p>

        {/* High-Contrast Pure White QR Container */}
        <div className="mt-6 flex justify-center">
          <div className="rounded-2xl bg-white p-5 shadow-[0_0_25px_rgba(255,255,255,0.15)] ring-4 ring-gold/20">
            <QRCodeSVG
              value={qrUrl}
              size={220}
              level="M"
              includeMargin={false}
            />
          </div>
        </div>

        <p className="mt-4 text-[11px] font-mono text-zinc-500 break-all px-4 truncate">
          {qrUrl}
        </p>

        {/* Primary Action Button: Done Scanning - New Customer */}
        <div className="mt-8 flex flex-col gap-3">
          <button
            type="button"
            onClick={onDoneNewCustomer}
            className="group flex w-full items-center justify-center gap-2.5 rounded-full bg-gradient-to-r from-gold to-gold-light py-4 text-sm font-bold text-zinc-950 shadow-lg transition-transform duration-150 active:scale-95 hover:scale-[1.02]"
          >
            <CheckCircle2 className="h-4 w-4" />
            <span>{t('doneScanning')}</span>
          </button>

          <button
            type="button"
            onClick={onClose}
            className="py-2 text-xs font-medium text-zinc-400 hover:text-zinc-200 transition-colors"
          >
            {locale === 'ar' ? 'الرجوع إلى النتائج على الشاشة' : locale === 'fr' ? 'Retour aux résultats sur tablette' : 'Return to screen results'}
          </button>
        </div>
      </div>
    </div>
  );
}
