'use client';

import { useLocale } from 'next-intl';
import { useRouter } from '@/i18n/routing';
import { useQuizStore } from '@/lib/store/useQuizStore';
import { Sparkles, Compass, MapPin, Smartphone, ArrowRight, ArrowLeft } from 'lucide-react';

export default function KioskHomePage() {
  const locale = useLocale();
  const router = useRouter();
  const isRTL = locale === 'ar';
  const { resetQuiz } = useQuizStore();

  const handleStart = () => {
    resetQuiz();
    router.push('/kiosk/quiz');
  };

  return (
    <main className="relative mx-auto flex min-h-[calc(100vh-80px)] max-w-5xl flex-col items-center justify-center px-8 py-12 text-center">
      {/* Background Ambience */}
      <div
        className="pointer-events-none fixed inset-0 z-0 bg-[radial-gradient(ellipse_70%_70%_at_50%_40%,rgba(212,175,55,0.1),transparent)]"
        aria-hidden="true"
      />

      {/* Decorative Badge */}
      <div className="relative z-10 mb-6 inline-flex items-center gap-2 rounded-full border border-gold/40 bg-gold/15 px-5 py-2 text-xs sm:text-sm font-bold text-gold backdrop-blur-md shadow-lg">
        <Sparkles className="h-4 w-4" />
        <span>
          {locale === 'ar'
            ? 'المستشار الرقمي للعطور داخل المحل'
            : locale === 'fr'
            ? 'Conseiller Olfactif Digital en Boutique'
            : 'In-Store Digital Fragrance Expert'}
        </span>
      </div>

      {/* Main Touch Heading */}
      <h1 className="relative z-10 max-w-4xl text-4xl font-extrabold tracking-tight sm:text-5xl md:text-6xl lg:text-7xl">
        <span className="bg-gradient-to-b from-zinc-50 via-zinc-200 to-zinc-400 bg-clip-text text-transparent">
          {locale === 'ar'
            ? 'اكتشف عطرك المثالي في 30 ثانية'
            : locale === 'fr'
            ? 'Trouvez votre parfum idéal en 30 secondes'
            : 'Find Your Signature Fragrance in 30s'}
        </span>
      </h1>

      <p className="relative z-10 mt-6 max-w-2xl text-base sm:text-xl text-textMuted leading-relaxed">
        {locale === 'ar'
          ? 'أجب عن أسئلة بسيطة وسريعة لاكتشاف العطور التي تلائم ذوقك مع تحديد رقم الرف والزجاجة للتجربة الفورية.'
          : locale === 'fr'
          ? 'Répondez à quelques questions visuelles et repérez instantanément les flacons testeurs sur nos étagères.'
          : 'Answer a few intuitive questions to discover tailored matches with instant tester shelf locations in our boutique.'}
      </p>

      {/* Giant Pill Touch CTA (Kiosk Oversized Tap Target) */}
      <div className="relative z-10 mt-10">
        <button
          type="button"
          onClick={handleStart}
          className="group inline-flex items-center gap-4 rounded-full bg-gradient-to-r from-gold via-gold-light to-gold px-12 py-6 text-lg sm:text-xl font-black text-zinc-950 shadow-[0_0_40px_rgba(212,175,55,0.4)] transition-transform duration-200 active:scale-95 hover:scale-105 cursor-pointer"
        >
          <span>
            {locale === 'ar'
              ? 'المس الشاشة للبدء'
              : locale === 'fr'
              ? 'Toucher pour Commencer'
              : 'Tap to Discover'}
          </span>
          {isRTL ? (
            <ArrowLeft className="h-6 w-6 text-zinc-950 transition-transform group-hover:-translate-x-1" />
          ) : (
            <ArrowRight className="h-6 w-6 text-zinc-950 transition-transform group-hover:translate-x-1" />
          )}
        </button>
      </div>

      {/* 3 Touch-First Highlights */}
      <div className="relative z-10 mt-16 grid w-full max-w-3xl grid-cols-1 gap-4 sm:grid-cols-3">
        <div className="rounded-2xl border border-zinc-800 bg-surface/70 p-5 backdrop-blur-sm text-center">
          <div className="mx-auto flex h-10 w-10 items-center justify-center rounded-full bg-gold/10 text-gold mb-3">
            <Compass className="h-5 w-5" />
          </div>
          <h3 className="text-sm font-bold text-zinc-100">
            {locale === 'ar' ? 'تشخيص ذكي وسريع' : locale === 'fr' ? 'Diagnostic Visuel Rapide' : 'Quick 30s Visual Quiz'}
          </h3>
          <p className="mt-1 text-xs text-textMuted">
            {locale === 'ar' ? 'بدون إجهاد لحاسة الشم' : locale === 'fr' ? 'Évite la fatigue olfactive' : 'Avoids olfactory fatigue'}
          </p>
        </div>

        <div className="rounded-2xl border border-zinc-800 bg-surface/70 p-5 backdrop-blur-sm text-center">
          <div className="mx-auto flex h-10 w-10 items-center justify-center rounded-full bg-gold/10 text-gold mb-3">
            <MapPin className="h-5 w-5" />
          </div>
          <h3 className="text-sm font-bold text-zinc-100">
            {locale === 'ar' ? 'موقع الرف للتجربة' : locale === 'fr' ? 'Emplacement en Rayon' : 'Instant Shelf Location'}
          </h3>
          <p className="mt-1 text-xs text-textMuted">
            {locale === 'ar' ? 'حدد مكان زجاجة التستر مباشرة' : locale === 'fr' ? 'Localisez le testeur en boutique' : 'Locate tester bottles immediately'}
          </p>
        </div>

        <div className="rounded-2xl border border-zinc-800 bg-surface/70 p-5 backdrop-blur-sm text-center">
          <div className="mx-auto flex h-10 w-10 items-center justify-center rounded-full bg-gold/10 text-gold mb-3">
            <Smartphone className="h-5 w-5" />
          </div>
          <h3 className="text-sm font-bold text-zinc-100">
            {locale === 'ar' ? 'حفظ على هاتفك (QR)' : locale === 'fr' ? 'Export sur Téléphone' : 'Save to Phone via QR'}
          </h3>
          <p className="mt-1 text-xs text-textMuted">
            {locale === 'ar' ? 'امسح الرمز واصطحب اختياراتك' : locale === 'fr' ? 'Scannez et emportez vos choix' : 'Scan to show your consultant'}
          </p>
        </div>
      </div>
    </main>
  );
}
