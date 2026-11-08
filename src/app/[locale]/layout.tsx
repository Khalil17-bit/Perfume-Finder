import { ReactNode } from 'react';
import { notFound } from 'next/navigation';
import { getMessages, unstable_setRequestLocale } from 'next-intl/server';
import { NextIntlClientProvider } from 'next-intl';
import { Inter, Cairo } from 'next/font/google';
import { routing, Locale } from '@/i18n/routing';

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-inter',
  display: 'swap',
});

const cairo = Cairo({
  subsets: ['arabic', 'latin'],
  variable: '--font-cairo',
  display: 'swap',
});

export function generateStaticParams() {
  return routing.locales.map((locale) => ({ locale }));
}

type Props = {
  children: ReactNode;
  params: { locale: string };
};

export default async function LocaleLayout({
  children,
  params: { locale },
}: Props) {
  if (!routing.locales.includes(locale as Locale)) {
    notFound();
  }

  unstable_setRequestLocale(locale);
  const messages = await getMessages();
  const isRTL = locale === 'ar';
  const fontClass = isRTL ? cairo.variable : inter.variable;

  return (
    <html lang={locale} dir={isRTL ? 'rtl' : 'ltr'} className={`dark ${fontClass}`}>
      <body className={`${isRTL ? 'font-arabic' : 'font-latin'} bg-background text-textPrimary antialiased`}>
        <NextIntlClientProvider locale={locale} messages={messages}>
          {children}
        </NextIntlClientProvider>
      </body>
    </html>
  );
}
