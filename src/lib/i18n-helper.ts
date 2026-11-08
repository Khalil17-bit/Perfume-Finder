import { LocalizedString } from './supabase/types';

export const SUPPORTED_LOCALES = ['ar', 'fr', 'en'] as const;
export type SupportedLocale = (typeof SUPPORTED_LOCALES)[number];

/**
 * Resolves a localized string from a database JSONB object with fallback hierarchy.
 * Resolution order:
 * 1. Specified locale
 * 2. Fallback locale (default 'ar')
 * 3. English ('en')
 * 4. First available non-empty string in the object
 * 5. Empty string fallback
 */
export function resolveLocalized(
  field: LocalizedString | null | undefined,
  locale: string,
  fallbackLocale: string = 'ar'
): string {
  if (!field || typeof field !== 'object') {
    return '';
  }

  // 1. Specified locale
  const directValue = field[locale];
  if (typeof directValue === 'string' && directValue.trim().length > 0) {
    return directValue.trim();
  }

  // 2. Fallback locale
  const fallbackValue = field[fallbackLocale];
  if (typeof fallbackValue === 'string' && fallbackValue.trim().length > 0) {
    return fallbackValue.trim();
  }

  // 3. English
  const englishValue = field['en'];
  if (typeof englishValue === 'string' && englishValue.trim().length > 0) {
    return englishValue.trim();
  }

  // 4. Any non-empty string in the object
  for (const key of Object.keys(field)) {
    const val = field[key];
    if (typeof val === 'string' && val.trim().length > 0) {
      return val.trim();
    }
  }

  return '';
}

/**
 * Resolves localized string with an explicit default string fallback.
 */
export function resolveLocalizedWithDefault(
  field: LocalizedString | null | undefined,
  locale: string,
  defaultValue: string,
  fallbackLocale: string = 'ar'
): string {
  const resolved = resolveLocalized(field, locale, fallbackLocale);
  return resolved.length > 0 ? resolved : defaultValue;
}

/**
 * Determines text direction ('rtl' | 'ltr') for a given locale.
 */
export function getDirection(locale: string): 'rtl' | 'ltr' {
  return locale === 'ar' ? 'rtl' : 'ltr';
}
