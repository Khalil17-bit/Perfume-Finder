'use client';

import { useState } from 'react';
import { useLocale } from 'next-intl';
import { FALLBACK_STORE_SETTINGS } from '@/lib/data/fallback-data';
import { StoreSettings } from '@/lib/supabase/types';
import { compressToWebP } from '@/lib/image-compressor';
import {
  Settings,
  Save,
  CheckCircle2,
  Lock,
  Globe,
  MapPin,
  Clock,
  MessageCircle,
  Share2,
  Image as ImageIcon,
} from 'lucide-react';
import clsx from 'clsx';

export default function AdminSettingsPage() {
  const locale = useLocale();

  const [settings, setSettings] = useState<StoreSettings>(FALLBACK_STORE_SETTINGS);
  const [activeLangTab, setActiveLangTab] = useState<'ar' | 'fr' | 'en'>('ar');
  const [isSaved, setIsSaved] = useState(false);
  const [logoPreview, setLogoPreview] = useState<string | null>(null);
  const [compressionStatus, setCompressionStatus] = useState<string | null>(null);

  const handleLogoUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    try {
      const result = await compressToWebP(file);
      const preview = URL.createObjectURL(result.file);
      setLogoPreview(preview);
      setCompressionStatus(
        `WebP logo: ${result.compressedSizeKb} KB (${result.dimensions.width}x${result.dimensions.height}px)`
      );
    } catch {
      alert('Error compressing logo');
    }
  };

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    setIsSaved(true);
    setTimeout(() => setIsSaved(false), 3000);
  };

  return (
    <div className="space-y-6 max-w-4xl">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight text-zinc-50">
            {locale === 'ar' ? 'إعدادات المتجر وشاشة التابلت' : 'Store & Kiosk Settings'}
          </h1>
          <p className="mt-1 text-xs sm:text-sm text-textMuted">
            {locale === 'ar'
              ? 'تخصيص الهوية، النصوص الترويجية، مواعيد العمل ورمز قفل الكيوسك PIN'
              : 'Configure boutique profile, hero copywriting, hours, and 4-digit Kiosk PIN'}
          </p>
        </div>

        {isSaved && (
          <div className="inline-flex items-center gap-2 rounded-xl bg-emerald-950/80 border border-emerald-800 px-4 py-2 text-xs font-bold text-emerald-300 animate-fade-in">
            <CheckCircle2 className="h-4 w-4" />
            <span>{locale === 'ar' ? 'تم حفظ التعديلات بنجاح!' : 'Changes saved successfully!'}</span>
          </div>
        )}
      </div>

      <form onSubmit={handleSave} className="space-y-8">
        {/* 1. Branding & Hero Copywriting */}
        <div className="rounded-3xl border border-zinc-800 bg-surface/90 p-6 sm:p-8 space-y-6">
          <div className="flex items-center justify-between pb-4 border-b border-zinc-800">
            <div className="flex items-center gap-2">
              <Globe className="h-5 w-5 text-gold" />
              <h2 className="text-base font-bold text-zinc-100">
                {locale === 'ar' ? 'النصوص الترويجية واسم المتجر' : 'Store Branding & Hero Text'}
              </h2>
            </div>

            {/* Language Tabs */}
            <div className="flex gap-1">
              {(['ar', 'fr', 'en'] as const).map((lang) => (
                <button
                  key={lang}
                  type="button"
                  onClick={() => setActiveLangTab(lang)}
                  className={clsx(
                    'rounded px-3 py-1 text-xs font-bold uppercase transition-colors',
                    activeLangTab === lang
                      ? 'bg-gold text-zinc-950'
                      : 'bg-zinc-800 text-zinc-400 hover:text-zinc-200'
                  )}
                >
                  {lang}
                </button>
              ))}
            </div>
          </div>

          <div className="space-y-4">
            <div>
              <label className="block text-xs font-semibold text-zinc-300 mb-1">
                {locale === 'ar' ? 'اسم المتجر' : 'Store Name'} ({activeLangTab.toUpperCase()})
              </label>
              <input
                type="text"
                value={settings.store_name?.[activeLangTab] || ''}
                onChange={(e) =>
                  setSettings({
                    ...settings,
                    store_name: { ...settings.store_name, [activeLangTab]: e.target.value },
                  })
                }
                className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-4 py-2.5 text-xs sm:text-sm text-zinc-100 focus:border-gold focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-zinc-300 mb-1">
                {locale === 'ar' ? 'العنوان الرئيسي لصفحة البداية' : 'Hero Main Headline'} ({activeLangTab.toUpperCase()})
              </label>
              <input
                type="text"
                value={settings.hero_title?.[activeLangTab] || ''}
                onChange={(e) =>
                  setSettings({
                    ...settings,
                    hero_title: { ...settings.hero_title, [activeLangTab]: e.target.value },
                  })
                }
                className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-4 py-2.5 text-xs sm:text-sm text-zinc-100 focus:border-gold focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-zinc-300 mb-1">
                {locale === 'ar' ? 'الوصف الفرعي لصفحة البداية' : 'Hero Sub-Headline'} ({activeLangTab.toUpperCase()})
              </label>
              <textarea
                rows={2}
                value={settings.hero_subtitle?.[activeLangTab] || ''}
                onChange={(e) =>
                  setSettings({
                    ...settings,
                    hero_subtitle: { ...settings.hero_subtitle, [activeLangTab]: e.target.value },
                  })
                }
                className="w-full rounded-xl border border-zinc-800 bg-zinc-900 p-3 text-xs sm:text-sm text-zinc-100 focus:border-gold focus:outline-none"
              />
            </div>
          </div>
        </div>

        {/* 2. Store Logo (WebP Compressed) */}
        <div className="rounded-3xl border border-zinc-800 bg-surface/90 p-6 sm:p-8 space-y-4">
          <div className="flex items-center gap-2 pb-4 border-b border-zinc-800">
            <ImageIcon className="h-5 w-5 text-gold" />
            <h2 className="text-base font-bold text-zinc-100">
              {locale === 'ar' ? 'شعار المتجر (WebP تلقائي < 150KB)' : 'Boutique Logo (Auto WebP)'}
            </h2>
          </div>

          <div className="flex items-center gap-6">
            <div className="flex h-20 w-20 shrink-0 items-center justify-center rounded-2xl border border-dashed border-zinc-700 bg-zinc-900 overflow-hidden">
              {logoPreview ? (
                <img src={logoPreview} alt="Logo Preview" className="h-full w-full object-contain p-2" />
              ) : (
                <ImageIcon className="h-8 w-8 text-zinc-600" />
              )}
            </div>

            <div>
              <input
                type="file"
                accept="image/*"
                onChange={handleLogoUpload}
                className="text-xs text-zinc-400 file:mr-3 file:rounded-xl file:border-0 file:bg-zinc-800 file:px-3 file:py-1.5 file:text-xs file:font-semibold file:text-gold hover:file:bg-zinc-700 cursor-pointer"
              />
              {compressionStatus ? (
                <p className="mt-1 text-[11px] font-mono text-emerald-400">{compressionStatus}</p>
              ) : (
                <p className="mt-1 text-[11px] text-zinc-500">
                  {locale === 'ar'
                    ? 'يتم ضغط الشعار تلقائياً إلى WebP بحجم أقل من 150KB'
                    : 'Automatically resized & compressed to WebP under 150KB'}
                </p>
              )}
            </div>
          </div>
        </div>

        {/* 3. Boutique Location & Contact */}
        <div className="rounded-3xl border border-zinc-800 bg-surface/90 p-6 sm:p-8 space-y-4">
          <div className="flex items-center gap-2 pb-4 border-b border-zinc-800">
            <MapPin className="h-5 w-5 text-gold" />
            <h2 className="text-base font-bold text-zinc-100">
              {locale === 'ar' ? 'موقع البوتيك ومواعيد العمل' : 'Boutique Location & Hours'}
            </h2>
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <label className="block text-xs font-semibold text-zinc-300 mb-1">
                {locale === 'ar' ? 'عنوان المحل' : 'Store Address'}
              </label>
              <input
                type="text"
                value={settings.store_address?.ar || ''}
                onChange={(e) =>
                  setSettings({
                    ...settings,
                    store_address: { ...settings.store_address, ar: e.target.value, fr: e.target.value, en: e.target.value },
                  })
                }
                className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-4 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-zinc-300 mb-1">
                {locale === 'ar' ? 'ساعات العمل' : 'Operating Hours'}
              </label>
              <input
                type="text"
                value={settings.operating_hours?.ar || ''}
                onChange={(e) =>
                  setSettings({
                    ...settings,
                    operating_hours: { ...settings.operating_hours, ar: e.target.value, fr: e.target.value, en: e.target.value },
                  })
                }
                className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-4 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
              />
            </div>
          </div>
        </div>

        {/* 4. In-Store Kiosk Security PIN (PRD Section 4.2) */}
        <div className="rounded-3xl border border-zinc-800 bg-surface/90 p-6 sm:p-8 space-y-4">
          <div className="flex items-center gap-2 pb-4 border-b border-zinc-800">
            <Lock className="h-5 w-5 text-gold" />
            <h2 className="text-base font-bold text-zinc-100">
              {locale === 'ar' ? 'رمز قفل شاشة الكيوسك (Kiosk 4-digit PIN)' : 'Kiosk PIN Security'}
            </h2>
          </div>

          <div className="max-w-xs">
            <label className="block text-xs font-semibold text-zinc-300 mb-1">
              {locale === 'ar' ? 'رمز الحماية المكوّن من 4 أرقام' : '4-Digit Exit PIN'}
            </label>
            <input
              type="text"
              maxLength={4}
              value={settings.kiosk_pin}
              onChange={(e) => setSettings({ ...settings, kiosk_pin: e.target.value })}
              className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-4 py-3 text-center text-lg font-mono font-bold tracking-widest text-gold focus:border-gold focus:outline-none"
            />
            <p className="mt-1.5 text-[11px] text-zinc-500">
              {locale === 'ar'
                ? 'يستخدم لمنع الزوار من الخروج من شاشة التابلت داخل المتجر'
                : 'Used by staff to unlock and exit tablet kiosk mode in-store'}
            </p>
          </div>
        </div>

        {/* Submit Button */}
        <div className="flex justify-end pt-4">
          <button
            type="submit"
            className="inline-flex items-center gap-2 rounded-xl bg-gold px-8 py-3 text-sm font-bold text-zinc-950 shadow-lg transition-transform active:scale-95 hover:bg-gold-light cursor-pointer"
          >
            <Save className="h-4 w-4" />
            <span>{locale === 'ar' ? 'حفظ كافة الإعدادات' : 'Save All Settings'}</span>
          </button>
        </div>
      </form>
    </div>
  );
}
