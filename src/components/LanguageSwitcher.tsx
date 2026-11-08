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
              'rounded-full px-3 py-1 text-xs font-medium tracking-wide transition-transform active:scale-95 duration-150',
              isActive
                ? 'bg-gold/15 text-gold border border-gold/30 shadow-sm'
                : 'text-zinc-400 hover:text-zinc-200 hover:bg-zinc-800/60'
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
