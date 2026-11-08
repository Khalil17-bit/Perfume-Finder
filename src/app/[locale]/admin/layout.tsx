'use client';

import { ReactNode } from 'react';
import { usePathname, Link, useRouter } from '@/i18n/routing';
import { useLocale, useTranslations } from 'next-intl';
import {
  LayoutDashboard,
  Sparkles,
  Tag as TagIcon,
  HelpCircle,
  Settings,
  LogOut,
  ExternalLink,
  Compass,
  Monitor,
} from 'lucide-react';
import clsx from 'clsx';
import { LanguageSwitcher } from '@/components/LanguageSwitcher';
import { createClient } from '@/lib/supabase/client';

export default function AdminLayout({ children }: { children: ReactNode }) {
  const pathname = usePathname();
  const locale = useLocale();
  const router = useRouter();
  const t = useTranslations('admin');

  // If on login page, do not render dashboard chrome
  if (pathname === '/admin/login') {
    return <>{children}</>;
  }

  const handleLogout = async () => {
    try {
      document.cookie = 'pf_admin_demo=; path=/; max-age=0; SameSite=Lax';
      const supabase = createClient();
      await supabase.auth.signOut();
    } catch {
      // Ignore
    }
    router.push('/admin/login');
  };

  const navItems = [
    {
      href: '/admin',
      label: locale === 'ar' ? 'التحليلات والنظرة العامة' : locale === 'fr' ? 'Vue d’ensemble' : 'Analytics & Overview',
      icon: LayoutDashboard,
      exact: true,
    },
    {
      href: '/admin/perfumes',
      label: locale === 'ar' ? 'كتالوج العطور' : locale === 'fr' ? 'Catalogue Parfums' : 'Perfumes Inventory',
      icon: Sparkles,
      exact: false,
    },
    {
      href: '/admin/tags',
      label: locale === 'ar' ? 'السمات والخصائص' : locale === 'fr' ? 'Attributs & Tags' : 'Dynamic Tags',
      icon: TagIcon,
      exact: false,
    },
    {
      href: '/admin/quiz-builder',
      label: locale === 'ar' ? 'منشئ الأسئلة والأوزان' : locale === 'fr' ? 'Éditeur de Quiz' : 'Quiz & Tag Weights',
      icon: HelpCircle,
      exact: false,
    },
    {
      href: '/admin/settings',
      label: locale === 'ar' ? 'إعدادات المتجر والشاشة' : locale === 'fr' ? 'Paramètres Boutique' : 'Store Settings',
      icon: Settings,
      exact: false,
    },
  ];

  return (
    <div className="flex min-h-screen bg-background text-textPrimary">
      {/* Sidebar Navigation */}
      <aside className="w-64 shrink-0 border-e border-zinc-800 bg-surface/95 backdrop-blur-md hidden md:flex flex-col justify-between p-6">
        <div>
          {/* Brand Header */}
          <div className="flex items-center gap-3 pb-6 border-b border-zinc-800/80">
            <div className="flex h-10 w-10 items-center justify-center rounded-xl border border-gold/40 bg-gold/10 text-gold shadow-md">
              <Compass className="h-5 w-5" />
            </div>
            <div>
              <h2 className="text-sm font-bold tracking-tight text-zinc-100">
                {locale === 'ar' ? 'إدارة البوتيك' : 'Boutique Admin'}
              </h2>
              <span className="text-[10px] text-zinc-500 font-mono">v1.0 • Enterprise</span>
            </div>
          </div>

          {/* Navigation Links */}
          <nav className="mt-6 space-y-1.5" aria-label="Admin Navigation">
            {navItems.map((item) => {
              const Icon = item.icon;
              const isActive = item.exact
                ? pathname === item.href
                : pathname.startsWith(item.href);

              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={clsx(
                    'flex items-center gap-3 rounded-xl px-4 py-3 text-xs font-semibold transition-all duration-150',
                    isActive
                      ? 'bg-gold/15 text-gold border border-gold/30 shadow-sm'
                      : 'text-zinc-400 hover:bg-zinc-800/70 hover:text-zinc-100'
                  )}
                >
                  <Icon className={clsx('h-4 w-4', isActive ? 'text-gold' : 'text-zinc-400')} />
                  <span>{item.label}</span>
                </Link>
              );
            })}
          </nav>
        </div>

        {/* Live Storefront & Kiosk Quick Links */}
        <div className="space-y-3 pt-6 border-t border-zinc-800/80">
          <div className="text-[11px] font-semibold text-zinc-500 uppercase tracking-wider px-2">
            {locale === 'ar' ? 'معاينة الواجهات الحية' : 'Live Preview'}
          </div>

          <Link
            href="/"
            target="_blank"
            className="flex items-center justify-between rounded-xl border border-zinc-800 bg-zinc-900/60 px-3.5 py-2.5 text-xs text-zinc-300 hover:border-zinc-700 hover:text-zinc-100 transition-colors"
          >
            <span className="flex items-center gap-2">
              <Compass className="h-3.5 w-3.5 text-gold" />
              <span>{locale === 'ar' ? 'واجهة المتجر' : 'Web Storefront'}</span>
            </span>
            <ExternalLink className="h-3 w-3 text-zinc-500" />
          </Link>

          <Link
            href="/kiosk"
            target="_blank"
            className="flex items-center justify-between rounded-xl border border-zinc-800 bg-zinc-900/60 px-3.5 py-2.5 text-xs text-zinc-300 hover:border-zinc-700 hover:text-zinc-100 transition-colors"
          >
            <span className="flex items-center gap-2">
              <Monitor className="h-3.5 w-3.5 text-gold" />
              <span>{locale === 'ar' ? 'شاشة التابلت (Kiosk)' : 'In-Store Kiosk'}</span>
            </span>
            <ExternalLink className="h-3 w-3 text-zinc-500" />
          </Link>

          <button
            type="button"
            onClick={handleLogout}
            className="flex w-full items-center gap-2.5 rounded-xl px-3.5 py-2.5 text-xs font-semibold text-red-400 hover:bg-red-950/30 transition-colors cursor-pointer"
          >
            <LogOut className="h-4 w-4" />
            <span>{t('logout')}</span>
          </button>
        </div>
      </aside>

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col min-w-0">
        {/* Top Header */}
        <header className="flex h-16 items-center justify-between border-b border-zinc-800 bg-surface/50 backdrop-blur-md px-6 sm:px-10">
          <div className="flex items-center gap-2">
            <span className="text-xs font-bold text-zinc-400 uppercase tracking-widest">
              {locale === 'ar' ? 'لوحة القيادة' : 'Control Panel'}
            </span>
          </div>

          <LanguageSwitcher />
        </header>

        {/* Content Body */}
        <main className="flex-1 p-6 sm:p-10 overflow-y-auto">
          {children}
        </main>
      </div>
    </div>
  );
}
