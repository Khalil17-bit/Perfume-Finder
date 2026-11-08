'use client';

import { useLocale } from 'next-intl';
import { Link } from '@/i18n/routing';
import {
  Users,
  Smartphone,
  Sparkles,
  HelpCircle,
  TrendingUp,
  Award,
  ArrowUpRight,
  Plus,
} from 'lucide-react';

export default function AdminOverviewPage() {
  const locale = useLocale();

  const metrics = [
    {
      title: locale === 'ar' ? 'إجمالي جلسات الاستكشاف' : 'Total Quiz Sessions',
      value: '184',
      change: '+18% this week',
      icon: Users,
    },
    {
      title: locale === 'ar' ? 'جلسات التابلت داخل المحل' : 'In-Store Kiosk Sessions',
      value: '76',
      change: '41% of total traffic',
      icon: Smartphone,
    },
    {
      title: locale === 'ar' ? 'متوسط الأسئلة قبل النتائج' : 'Avg. Answered Questions',
      value: '4.6',
      change: 'High engagement',
      icon: HelpCircle,
    },
    {
      title: locale === 'ar' ? 'معدل دقة التوصية' : 'Avg. Match Confidence',
      value: '84%',
      change: 'Based on 5+ answers',
      icon: TrendingUp,
    },
  ];

  const topPerfumes = [
    { name: 'Bleu de Chanel Parfum', brand: 'Chanel', recommendations: 64, rate: '92%' },
    { name: 'Oud Wood Intense', brand: 'Tom Ford', recommendations: 51, rate: '88%' },
    { name: 'Baccarat Rouge 540', brand: 'MFK', recommendations: 43, rate: '85%' },
    { name: 'Sauvage Elixir', brand: 'Dior', recommendations: 38, rate: '79%' },
    { name: 'Delina Exclusif', brand: 'Parfums de Marly', recommendations: 29, rate: '74%' },
  ];

  const topTags = [
    { name: locale === 'ar' ? 'أخشاب وأرز (Woody)' : 'Woody & Cedar', count: 94, pct: 78 },
    { name: locale === 'ar' ? 'حمضيات وبرغموت (Citrus)' : 'Citrus & Bergamot', count: 82, pct: 68 },
    { name: locale === 'ar' ? 'عنبر وفانيليا (Amber)' : 'Amber & Vanilla', count: 67, pct: 56 },
    { name: locale === 'ar' ? 'سهرات ومناسبات (Evening)' : 'Evening & Events', count: 58, pct: 48 },
    { name: locale === 'ar' ? 'عود ملكي وبخور (Royal Oud)' : 'Royal Oud & Incense', count: 49, pct: 41 },
  ];

  return (
    <div className="space-y-8 max-w-6xl">
      {/* Header & Quick Action */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight text-zinc-50">
            {locale === 'ar' ? 'نظرة عامة والتحليلات الذكية' : 'Analytics & Store Overview'}
          </h1>
          <p className="mt-1 text-xs sm:text-sm text-textMuted">
            {locale === 'ar'
              ? 'متابعة تفاعل الزوار داخل المتجر وعلى الموقع وترشيحات العطور الأكثر طلباً'
              : 'Real-time telemetry tracking visitor fragrance discovery and top matched profiles'}
          </p>
        </div>

        <div className="flex items-center gap-3">
          <Link
            href="/admin/perfumes"
            className="inline-flex items-center gap-2 rounded-xl bg-gold px-4 py-2.5 text-xs font-bold text-zinc-950 shadow-md transition-transform active:scale-95 hover:bg-gold-light"
          >
            <Plus className="h-4 w-4" />
            <span>{locale === 'ar' ? 'إضافة عطر جديد' : 'Add Perfume'}</span>
          </Link>
        </div>
      </div>

      {/* Metrics Row */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {metrics.map((m) => {
          const Icon = m.icon;
          return (
            <div
              key={m.title}
              className="rounded-2xl border border-zinc-800 bg-surface/90 p-5 shadow-sm backdrop-blur-md"
            >
              <div className="flex items-center justify-between text-zinc-400">
                <span className="text-xs font-semibold">{m.title}</span>
                <div className="rounded-lg bg-zinc-800 p-2 text-gold">
                  <Icon className="h-4 w-4" />
                </div>
              </div>
              <div className="mt-4 text-3xl font-black text-zinc-50">{m.value}</div>
              <p className="mt-1 text-[11px] font-medium text-emerald-400">{m.change}</p>
            </div>
          );
        })}
      </div>

      {/* Two Column Section: Top Perfumes & Customer Preferences */}
      <div className="grid grid-cols-1 gap-8 lg:grid-cols-2">
        {/* Top 5 Recommended Fragrances */}
        <div className="rounded-3xl border border-zinc-800 bg-surface/80 p-6 backdrop-blur-md">
          <div className="flex items-center justify-between pb-4 border-b border-zinc-800">
            <div className="flex items-center gap-2">
              <Award className="h-5 w-5 text-gold" />
              <h2 className="text-base font-bold text-zinc-100">
                {locale === 'ar' ? 'العطور الأكثر ترشيحاً للعملاء' : 'Top Recommended Fragrances'}
              </h2>
            </div>
            <Link
              href="/admin/perfumes"
              className="text-xs font-semibold text-gold hover:underline flex items-center gap-1"
            >
              <span>{locale === 'ar' ? 'عرض الكتالوج' : 'View all'}</span>
              <ArrowUpRight className="h-3 w-3" />
            </Link>
          </div>

          <div className="mt-4 divide-y divide-zinc-800/60">
            {topPerfumes.map((p, idx) => (
              <div key={p.name} className="flex items-center justify-between py-3">
                <div className="flex items-center gap-3">
                  <span className="flex h-6 w-6 items-center justify-center rounded-full bg-zinc-800 text-xs font-bold text-gold">
                    {idx + 1}
                  </span>
                  <div>
                    <h3 className="font-latin text-sm font-bold text-zinc-200">{p.name}</h3>
                    <p className="font-latin text-[11px] text-zinc-500">{p.brand}</p>
                  </div>
                </div>

                <div className="text-end">
                  <span className="text-xs font-bold text-gold">{p.recommendations} matches</span>
                  <p className="text-[10px] text-zinc-500">{p.rate} satisfaction</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Most Frequent Customer Preference Tags */}
        <div className="rounded-3xl border border-zinc-800 bg-surface/80 p-6 backdrop-blur-md">
          <div className="flex items-center justify-between pb-4 border-b border-zinc-800">
            <div className="flex items-center gap-2">
              <Sparkles className="h-5 w-5 text-gold" />
              <h2 className="text-base font-bold text-zinc-100">
                {locale === 'ar' ? 'أكثر التفضيلات الحسية طلباً' : 'Top Olfactory Preferences'}
              </h2>
            </div>
            <Link
              href="/admin/tags"
              className="text-xs font-semibold text-gold hover:underline flex items-center gap-1"
            >
              <span>{locale === 'ar' ? 'إدارة السمات' : 'Manage tags'}</span>
              <ArrowUpRight className="h-3 w-3" />
            </Link>
          </div>

          <div className="mt-5 space-y-4">
            {topTags.map((tag) => (
              <div key={tag.name}>
                <div className="flex justify-between text-xs font-medium text-zinc-300 mb-1.5">
                  <span>{tag.name}</span>
                  <span className="text-gold font-bold">{tag.count} matches ({tag.pct}%)</span>
                </div>
                <div className="h-2 w-full rounded-full bg-zinc-800 overflow-hidden">
                  <div
                    className="h-full rounded-full bg-gradient-to-r from-amberAccent to-gold transition-all duration-500"
                    style={{ width: `${tag.pct}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
