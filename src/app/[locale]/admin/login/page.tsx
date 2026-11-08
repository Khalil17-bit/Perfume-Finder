'use client';

import { useState } from 'react';
import { useRouter } from '@/i18n/routing';
import { useLocale } from 'next-intl';
import { createClient } from '@/lib/supabase/client';
import { Compass, Lock, Mail, ArrowRight, ArrowLeft, AlertCircle, ShieldCheck } from 'lucide-react';
import { LanguageSwitcher } from '@/components/LanguageSwitcher';

export default function AdminLoginPage() {
  const locale = useLocale();
  const router = useRouter();
  const isRTL = locale === 'ar';

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setErrorMsg(null);

    try {
      const supabase = createClient();
      const { error } = await supabase.auth.signInWithPassword({
        email: email.trim(),
        password,
      });

      if (error) {
        setErrorMsg(error.message);
      } else {
        router.push('/admin');
      }
    } catch (err: any) {
      setErrorMsg(err.message || 'Login failed');
    } finally {
      setIsLoading(false);
    }
  };

  const handleDemoBypass = () => {
    // Sets an explicit SameSite=Lax session cookie verified by middleware
    document.cookie = 'pf_admin_demo=authenticated; path=/; max-age=3600; SameSite=Lax';
    router.push('/admin');
  };

  return (
    <div className="relative flex min-h-screen items-center justify-center bg-background px-4 text-textPrimary">
      {/* Background Ambience */}
      <div
        className="pointer-events-none fixed inset-0 z-0 bg-[radial-gradient(ellipse_60%_60%_at_50%_30%,rgba(255,85,0,0.08),transparent)]"
        aria-hidden="true"
      />

      {/* Top Header */}
      <div className="fixed top-6 right-6 z-20">
        <LanguageSwitcher />
      </div>

      <div className="relative z-10 w-full max-w-md rounded-3xl border border-zinc-800 bg-surface/90 p-8 sm:p-10 shadow-2xl backdrop-blur-md">
        {/* Brand Icon */}
        <div className="mx-auto flex h-14 w-14 items-center justify-center rounded-2xl border border-gold/40 bg-gold/10 text-gold shadow-[0_0_20px_rgba(255,85,0,0.2)]">
          <Compass className="h-7 w-7" />
        </div>

        <div className="mt-5 text-center">
          <h1 className="text-2xl font-bold tracking-tight text-zinc-50 sm:text-3xl">
            {locale === 'ar' ? 'لوحة إدارة المتجر' : locale === 'fr' ? 'Portail Administrateur' : 'Merchant Admin Portal'}
          </h1>
          <p className="mt-2 text-xs text-textMuted sm:text-sm">
            {locale === 'ar'
              ? 'سجل دخولك لإدارة العطور، الأسئلة والأوزان والتحليلات'
              : 'Sign in to manage catalog, tags, dynamic quiz, and store analytics'}
          </p>
        </div>

        {errorMsg && (
          <div className="mt-6 flex items-center gap-2 rounded-xl bg-red-950/60 border border-red-800/80 p-3 text-xs text-red-300">
            <AlertCircle className="h-4 w-4 shrink-0" />
            <span>{errorMsg}</span>
          </div>
        )}

        <form onSubmit={handleLogin} className="mt-6 space-y-4">
          <div>
            <label className="block text-xs font-semibold text-zinc-300 mb-1.5">
              {locale === 'ar' ? 'البريد الإلكتروني' : 'Email Address'}
            </label>
            <div className="relative">
              <input
                type="email"
                required
                autoComplete="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="admin@perfumfinder.com"
                className="w-full rounded-xl border border-zinc-800 bg-zinc-900/90 px-4 py-3 text-sm text-zinc-100 placeholder:text-zinc-600 focus:border-gold focus:outline-none focus:ring-1 focus:ring-gold"
              />
              <Mail className="absolute top-3.5 right-3.5 h-4 w-4 text-zinc-500 pointer-events-none" />
            </div>
          </div>

          <div>
            <label className="block text-xs font-semibold text-zinc-300 mb-1.5">
              {locale === 'ar' ? 'كلمة المرور' : 'Password'}
            </label>
            <div className="relative">
              <input
                type="password"
                required
                autoComplete="current-password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="••••••••"
                className="w-full rounded-xl border border-zinc-800 bg-zinc-900/90 px-4 py-3 text-sm text-zinc-100 placeholder:text-zinc-600 focus:border-gold focus:outline-none focus:ring-1 focus:ring-gold"
              />
              <Lock className="absolute top-3.5 right-3.5 h-4 w-4 text-zinc-500 pointer-events-none" />
            </div>
          </div>

          <button
            type="submit"
            disabled={isLoading}
            className="group mt-2 flex w-full items-center justify-center gap-2 rounded-xl bg-gold py-3.5 text-sm font-bold text-zinc-950 shadow-lg transition-transform active:scale-95 hover:bg-gold-light disabled:opacity-50 cursor-pointer"
          >
            <span>
              {isLoading
                ? (locale === 'ar' ? 'جاري التحقق...' : 'Authenticating...')
                : (locale === 'ar' ? 'تسجيل الدخول' : 'Sign In to Dashboard')}
            </span>
            {isRTL ? (
              <ArrowLeft className="h-4 w-4 transition-transform group-hover:-translate-x-1" />
            ) : (
              <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
            )}
          </button>
        </form>

        {/* Demo Fast Access Option */}
        <div className="mt-6 pt-6 border-t border-zinc-800/80 text-center">
          <button
            type="button"
            onClick={handleDemoBypass}
            className="inline-flex items-center gap-2 text-xs font-semibold text-zinc-400 hover:text-gold transition-colors cursor-pointer"
          >
            <ShieldCheck className="h-4 w-4 text-gold" />
            <span>
              {locale === 'ar'
                ? 'الدخول المباشر إلى لوحة التحكم (الوضع التجريبي)'
                : 'Direct Access to Dashboard (Demo Sandbox)'}
            </span>
          </button>
        </div>
      </div>
    </div>
  );
}
