'use client';

import { useLocale } from 'next-intl';
import { usePathname, useRouter } from '@/i18n/routing';
import { useTransition } from 'react';
import clsx from 'clsx';

interface LanguageSwitcherProps {
  className?: string;
}

export function LanguageSwitcher({ className }: LanguageSwitcherProps) {
  const currentLocale = useLocale();
  const pathname = usePathname();
  const router = useRouter();
  const [isPending, startTransition] = useTransition();

  const locales = [
    { code: 'ar', label: 'العربية' },
    { code: 'fr', label: 'FR' },
    { code: 'en', label: 'EN' },
  ] as const;

  const handleLocaleChange = (newLocale: 'ar' | 'fr' | 'en') => {
    if (newLocale === currentLocale) return;

    startTransition(() => {
      router.replace(pathname, { locale: newLocale });
    });
  };

  return (
    <div
      role="group"
      aria-label="Language selector"
      className={clsx(
        'inline-flex items-center gap-1.5 rounded-full border border-zinc-800 bg-surface/80 p-1 backdrop-blur-md transition-opacity duration-200',
        isPending && 'opacity-60 cursor-wait',
        className
      )}
    >
      {locales.map((loc) => {
        const isActive = loc.code === currentLocale;
        return (
          <button
            key={loc.code}
            type="button"
            onClick={() => handleLocaleChange(loc.code)}
            disabled={isPending}
            className={clsx(
              'rounded-full px-3.5 py-1 text-xs font-semibold tracking-wide transition-all duration-150 active:scale-95 cursor-pointer',
              isActive
                ? 'bg-[#FF5500]/20 text-[#FF5500] border border-[#FF5500]/60 shadow-[0_0_12px_rgba(255,85,0,0.35)]'
                : 'text-zinc-400 hover:text-white hover:bg-zinc-800/80 border border-transparent'
            )}
            aria-pressed={isActive}
          >
            {loc.label}
          </button>
        );
      })}
    </div>
  );
}
