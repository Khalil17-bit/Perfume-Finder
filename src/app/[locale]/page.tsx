import { unstable_setRequestLocale } from 'next-intl/server';
import { Link } from '@/i18n/routing';
import { LanguageSwitcher } from '@/components/LanguageSwitcher';
import { FALLBACK_STORE_SETTINGS } from '@/lib/data/fallback-data';
import { resolveLocalized } from '@/lib/i18n-helper';
import { Compass, Sparkles, MapPin, Clock, MessageCircle, Share2, Globe } from 'lucide-react';

type Props = {
  params: { locale: string };
};

export default function LandingPage({ params: { locale } }: Props) {
  unstable_setRequestLocale(locale);

  const storeSettings = FALLBACK_STORE_SETTINGS;

  const storeName = resolveLocalized(storeSettings.store_name, locale);
  const heroTitle = resolveLocalized(storeSettings.hero_title, locale);
  const heroSubtitle = resolveLocalized(storeSettings.hero_subtitle, locale);
  const address = resolveLocalized(storeSettings.store_address, locale);
  const hours = resolveLocalized(storeSettings.operating_hours, locale);

  return (
    <div className="relative flex min-h-screen flex-col justify-between overflow-hidden bg-background text-textPrimary">
      {/* Ambient Luxury Dark Background with Subtle Radiance */}
      <div
        className="pointer-events-none absolute inset-0 z-0 bg-[radial-gradient(ellipse_80%_80%_at_50%_-20%,rgba(212,175,55,0.08),rgba(9,9,11,1))]"
        aria-hidden="true"
      />
      <div
        className="pointer-events-none absolute inset-0 z-0 bg-[radial-gradient(ellipse_60%_50%_at_50%_120%,rgba(180,83,9,0.06),transparent)]"
        aria-hidden="true"
      />

      {/* Top Header: Brand Mark & Language Switcher */}
      <header className="relative z-10 flex w-full items-center justify-between px-6 py-6 sm:px-12">
        <div className="flex items-center gap-2.5">
          <div className="flex h-10 w-10 items-center justify-center rounded-full border border-gold/40 bg-surface/90 shadow-[0_0_15px_rgba(212,175,55,0.15)]">
            <Compass className="h-5 w-5 text-gold" />
          </div>
          <span className="text-sm font-semibold tracking-wider text-zinc-200 uppercase">
            {storeName}
          </span>
        </div>

        <LanguageSwitcher />
      </header>

      {/* Hero Section (Focused 1-Goal Conversion Funnel) */}
      <main className="relative z-10 mx-auto flex w-full max-w-4xl flex-1 flex-col items-center justify-center px-6 py-12 text-center">
        {/* Subtle Luxury Badge */}
        <div className="mb-6 inline-flex items-center gap-2 rounded-full border border-gold/30 bg-gold/10 px-4 py-1.5 text-xs font-medium tracking-wide text-gold backdrop-blur-md">
          <Sparkles className="h-3.5 w-3.5" />
          <span>
            {locale === 'ar'
              ? 'مستشار العطور الذكي خلال 30 ثانية'
              : locale === 'fr'
              ? 'Diagnostic Olfactif Sur-Mesure en 30s'
              : 'AI Olfactory Consultation in 30 Seconds'}
          </span>
        </div>

        {/* Massive Luxury Headline */}
        <h1 className="max-w-3xl text-4xl font-extrabold tracking-tightest sm:text-5xl md:text-6xl lg:text-7xl">
          <span className="bg-gradient-to-b from-zinc-50 via-zinc-200 to-zinc-400 bg-clip-text text-transparent">
            {heroTitle}
          </span>
        </h1>

        {/* Sub-headline */}
        <p className="mt-6 max-w-2xl text-base leading-relaxed text-textMuted sm:text-lg md:text-xl">
          {heroSubtitle}
        </p>

        {/* Main CTA: Glowing Pill Button with GPU Pulse */}
        <div className="mt-10">
          <Link
            href="/quiz"
            className="group relative inline-flex items-center gap-3 rounded-full bg-gradient-to-r from-gold via-gold-light to-gold px-10 py-4 text-base font-bold text-zinc-950 shadow-[0_0_30px_rgba(212,175,55,0.35)] transition-transform duration-200 active:scale-95 hover:scale-105"
          >
            <span>
              {locale === 'ar'
                ? 'ابدأ اكتشاف عطرك الآن'
                : locale === 'fr'
                ? 'Découvrir Votre Parfum'
                : 'Discover Your Scent'}
            </span>
            <Sparkles className="h-5 w-5 text-zinc-950 transition-transform duration-200 group-hover:rotate-12" />
          </Link>

          <p className="mt-3 text-xs tracking-wider text-zinc-500 uppercase">
            {locale === 'ar'
              ? 'بدون تسجيل • دقيق ومجاني'
              : locale === 'fr'
              ? 'Sans inscription • Rapide & Gratuit'
              : 'No sign-up required • Free & Instant'}
          </p>
        </div>
      </main>

      {/* Store Footer Info: Minimalist Grid */}
      <footer className="relative z-10 border-t border-zinc-900 bg-surface/50 backdrop-blur-sm px-6 py-6 sm:px-12">
        <div className="mx-auto flex max-w-6xl flex-col items-center justify-between gap-6 md:flex-row">
          {/* Location & Hours */}
          <div className="flex flex-wrap items-center justify-center gap-6 text-xs text-zinc-400 md:justify-start">
            <div className="flex items-center gap-2">
              <MapPin className="h-4 w-4 text-gold/80" />
              <span>{address}</span>
            </div>
            <div className="flex items-center gap-2">
              <Clock className="h-4 w-4 text-gold/80" />
              <span>{hours}</span>
            </div>
          </div>

          {/* Social Links */}
          <div className="flex items-center gap-4 text-zinc-400">
            <a
              href="https://instagram.com"
              target="_blank"
              rel="noopener noreferrer"
              aria-label="Instagram"
              className="rounded-full p-2 text-zinc-400 transition-colors hover:bg-zinc-800 hover:text-gold"
            >
              <Globe className="h-4 w-4" />
            </a>
            <a
              href="https://tiktok.com"
              target="_blank"
              rel="noopener noreferrer"
              aria-label="TikTok"
              className="rounded-full p-2 text-zinc-400 transition-colors hover:bg-zinc-800 hover:text-gold"
            >
              <Share2 className="h-4 w-4" />
            </a>
            <a
              href="https://whatsapp.com"
              target="_blank"
              rel="noopener noreferrer"
              aria-label="WhatsApp"
              className="rounded-full p-2 text-zinc-400 transition-colors hover:bg-zinc-800 hover:text-gold"
            >
              <MessageCircle className="h-4 w-4" />
            </a>
          </div>
        </div>
      </footer>
    </div>
  );
}
