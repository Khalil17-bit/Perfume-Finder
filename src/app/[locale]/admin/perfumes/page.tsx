'use client';

import { useState, useMemo } from 'react';
import { useLocale } from 'next-intl';
import { FALLBACK_PERFUMES, FALLBACK_PERFUME_TAGS, FALLBACK_TAGS } from '@/lib/data/fallback-data';
import { Perfume, Tag, TagCategory } from '@/lib/supabase/types';
import { resolveLocalized } from '@/lib/i18n-helper';
import {
  Sparkles,
  Plus,
  Search,
  Edit2,
  Trash2,
  CheckCircle2,
  XCircle,
  AlertCircle,
  MapPin,
  X,
  Check,
  Tag as TagIcon,
} from 'lucide-react';
import clsx from 'clsx';

type StatusFilter = 'all' | 'active' | 'out_of_stock' | 'draft';

const CATEGORY_NAMES: Record<TagCategory, { ar: string; en: string }> = {
  gender: { ar: 'الفئة', en: 'Gender' },
  vibe: { ar: 'الإحساس والطابع', en: 'Vibe & Mood' },
  occasion: { ar: 'المناسبة', en: 'Occasion' },
  season: { ar: 'الموسم', en: 'Season' },
  intensity: { ar: 'الفوحان والتركيز', en: 'Intensity' },
  notes: { ar: 'النغمات العطرية', en: 'Notes' },
};

export default function AdminPerfumesPage() {
  const locale = useLocale();

  const [perfumes, setPerfumes] = useState<Perfume[]>(FALLBACK_PERFUMES);
  // Map of perfumeId -> Set of tagIds
  const [perfumeTagsMap, setPerfumeTagsMap] = useState<Record<string, string[]>>(() => {
    const map: Record<string, string[]> = {};
    FALLBACK_PERFUME_TAGS.forEach((pt) => {
      if (!map[pt.perfume_id]) map[pt.perfume_id] = [];
      map[pt.perfume_id].push(pt.tag_id);
    });
    return map;
  });

  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState<StatusFilter>('all');

  // Modal State
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingPerfume, setEditingPerfume] = useState<Perfume | null>(null);

  // Form Fields
  const [formName, setFormName] = useState('');
  const [formBrand, setFormBrand] = useState('');
  const [formPrice, setFormPrice] = useState<string>('');
  const [formShelf, setFormShelf] = useState('');
  const [formIsAvailable, setFormIsAvailable] = useState(true);
  const [formIsFeatured, setFormIsFeatured] = useState(false);
  const [formIsDraft, setFormIsDraft] = useState(false);
  const [activeLangTab, setActiveLangTab] = useState<'ar' | 'fr' | 'en'>('ar');
  const [formDescAr, setFormDescAr] = useState('');
  const [formDescFr, setFormDescFr] = useState('');
  const [formDescEn, setFormDescEn] = useState('');
  const [selectedTagIds, setSelectedTagIds] = useState<string[]>([]);

  // Filtered perfumes
  const filteredPerfumes = useMemo(() => {
    return perfumes.filter((p) => {
      const q = searchQuery.toLowerCase().trim();
      const matchesSearch =
        !q ||
        p.name.toLowerCase().includes(q) ||
        (p.brand && p.brand.toLowerCase().includes(q));

      let matchesStatus = true;
      if (statusFilter === 'active') matchesStatus = p.is_available && !p.is_draft;
      else if (statusFilter === 'out_of_stock') matchesStatus = !p.is_available;
      else if (statusFilter === 'draft') matchesStatus = p.is_draft;

      return matchesSearch && matchesStatus;
    });
  }, [perfumes, searchQuery, statusFilter]);

  // Toggle 1-Click Availability Switch directly in row
  const handleToggleAvailable = (perfumeId: string) => {
    setPerfumes((prev) =>
      prev.map((p) => (p.id === perfumeId ? { ...p, is_available: !p.is_available } : p))
    );
  };

  const handleOpenAdd = () => {
    setEditingPerfume(null);
    setFormName('');
    setFormBrand('');
    setFormPrice('');
    setFormShelf('');
    setFormIsAvailable(true);
    setFormIsFeatured(false);
    setFormIsDraft(false);
    setFormDescAr('');
    setFormDescFr('');
    setFormDescEn('');
    setSelectedTagIds([]);
    setIsModalOpen(true);
  };

  const handleOpenEdit = (perfume: Perfume) => {
    setEditingPerfume(perfume);
    setFormName(perfume.name);
    setFormBrand(perfume.brand || '');
    setFormPrice(perfume.price ? String(perfume.price) : '');
    setFormShelf(perfume.shelf_location || '');
    setFormIsAvailable(perfume.is_available);
    setFormIsFeatured(perfume.is_featured);
    setFormIsDraft(perfume.is_draft);
    setFormDescAr(perfume.description?.ar || '');
    setFormDescFr(perfume.description?.fr || '');
    setFormDescEn(perfume.description?.en || '');
    setSelectedTagIds(perfumeTagsMap[perfume.id] || []);
    setIsModalOpen(true);
  };

  const toggleTagChip = (tagId: string) => {
    setSelectedTagIds((prev) =>
      prev.includes(tagId) ? prev.filter((id) => id !== tagId) : [...prev, tagId]
    );
  };

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    if (!formName.trim()) return;

    const priceNum = formPrice ? parseFloat(formPrice) : null;
    const descObj = {
      ar: formDescAr.trim(),
      fr: formDescFr.trim() || formDescEn.trim(),
      en: formDescEn.trim() || formDescAr.trim(),
    };

    if (editingPerfume) {
      // Update
      setPerfumes((prev) =>
        prev.map((p) =>
          p.id === editingPerfume.id
            ? {
                ...p,
                name: formName.trim(),
                brand: formBrand.trim() || null,
                price: priceNum,
                shelf_location: formShelf.trim() || null,
                is_available: formIsAvailable,
                is_featured: formIsFeatured,
                is_draft: formIsDraft,
                description: descObj,
              }
            : p
        )
      );

      setPerfumeTagsMap((prev) => ({
        ...prev,
        [editingPerfume.id]: selectedTagIds,
      }));
    } else {
      // Create
      const newId = `p_${Date.now()}`;
      const newPerfume: Perfume = {
        id: newId,
        name: formName.trim(),
        brand: formBrand.trim() || null,
        price: priceNum,
        shelf_location: formShelf.trim() || null,
        is_available: formIsAvailable,
        is_featured: formIsFeatured,
        is_draft: formIsDraft,
        description: descObj,
        created_at: new Date().toISOString(),
      };

      setPerfumes((prev) => [newPerfume, ...prev]);
      setPerfumeTagsMap((prev) => ({
        ...prev,
        [newId]: selectedTagIds,
      }));
    }

    setIsModalOpen(false);
  };

  const handleDelete = (perfumeId: string) => {
    if (confirm(locale === 'ar' ? 'هل أنت متأكد من حذف هذا العطر؟' : 'Delete this perfume?')) {
      setPerfumes((prev) => prev.filter((p) => p.id !== perfumeId));
    }
  };

  // Group system tags by category for interactive chips
  const tagsByCategory = useMemo(() => {
    const groups: Record<TagCategory, Tag[]> = {
      gender: [],
      vibe: [],
      occasion: [],
      season: [],
      intensity: [],
      notes: [],
    };
    FALLBACK_TAGS.forEach((tag) => {
      if (groups[tag.category]) {
        groups[tag.category].push(tag);
      }
    });
    return groups;
  }, []);

  return (
    <div className="space-y-6 max-w-6xl">
      {/* Page Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight text-zinc-50">
            {locale === 'ar' ? 'كتالوج العطور الفاخرة' : 'Perfumes Inventory'}
          </h1>
          <p className="mt-1 text-xs sm:text-sm text-textMuted">
            {locale === 'ar'
              ? 'إدارة مخزون العطور، الأسماء الإنجليزية، الرف في المحل والتصنيفات (بدون صور)'
              : 'Image-free product inventory with stock toggle, shelf locations, and multi-select tags'}
          </p>
        </div>

        <button
          type="button"
          onClick={handleOpenAdd}
          className="inline-flex items-center gap-2 rounded-xl bg-gold px-4 py-2.5 text-xs font-bold text-zinc-950 shadow-md transition-transform active:scale-95 hover:bg-gold-light cursor-pointer"
        >
          <Plus className="h-4 w-4" />
          <span>{locale === 'ar' ? 'إضافة عطر جديد' : 'Add Perfume'}</span>
        </button>
      </div>

      {/* Filter Row: Status Tabs & Instant Search */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div className="flex items-center gap-1.5 rounded-xl border border-zinc-800 bg-surface p-1">
          {(['all', 'active', 'out_of_stock', 'draft'] as StatusFilter[]).map((st) => (
            <button
              key={st}
              type="button"
              onClick={() => setStatusFilter(st)}
              className={clsx(
                'rounded-lg px-3 py-1.5 text-xs font-semibold transition-colors',
                statusFilter === st
                  ? 'bg-zinc-800 text-gold shadow-sm'
                  : 'text-zinc-400 hover:text-zinc-200'
              )}
            >
              {st === 'all' && (locale === 'ar' ? 'الكل' : 'All')}
              {st === 'active' && (locale === 'ar' ? 'متوفر' : 'Active')}
              {st === 'out_of_stock' && (locale === 'ar' ? 'نفذ المخزون' : 'Out of Stock')}
              {st === 'draft' && (locale === 'ar' ? 'مسودة' : 'Draft / Review')}
            </button>
          ))}
        </div>

        <div className="relative max-w-sm w-full">
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder={locale === 'ar' ? 'بحث بالاسم الإنجليزي أو الماركة...' : 'Search by name or brand...'}
            className="w-full rounded-xl border border-zinc-800 bg-surface px-4 py-2 text-xs sm:text-sm text-zinc-100 placeholder:text-zinc-500 focus:border-gold focus:outline-none"
          />
          <Search className="absolute top-2.5 right-3 h-4 w-4 text-zinc-500 pointer-events-none" />
        </div>
      </div>

      {/* Perfumes Table */}
      <div className="rounded-2xl border border-zinc-800 bg-surface/90 overflow-hidden shadow-sm">
        <div className="overflow-x-auto">
          <table className="w-full text-start text-xs sm:text-sm">
            <thead className="border-b border-zinc-800 bg-zinc-900/60 text-zinc-400 font-semibold uppercase tracking-wider">
              <tr>
                <th className="p-4 text-start">{locale === 'ar' ? 'العطر والماركة (لاتيني)' : 'Perfume & Brand'}</th>
                <th className="p-4 text-start">{locale === 'ar' ? 'موقع الرف (Kiosk)' : 'Shelf Location'}</th>
                <th className="p-4 text-start">{locale === 'ar' ? 'السعر' : 'Price'}</th>
                <th className="p-4 text-start">{locale === 'ar' ? 'الحالة والمخزون' : 'Stock Toggle'}</th>
                <th className="p-4 text-end">{locale === 'ar' ? 'الإجراءات' : 'Actions'}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-zinc-800/60 text-zinc-200">
              {filteredPerfumes.map((perfume) => {
                const assignedTags = perfumeTagsMap[perfume.id] || [];

                return (
                  <tr key={perfume.id} className="hover:bg-zinc-800/30 transition-colors">
                    {/* Name & Brand */}
                    <td className="p-4">
                      <div>
                        <span className="font-latin font-bold text-zinc-100 sm:text-base">
                          {perfume.name}
                        </span>
                        {perfume.brand && (
                          <p className="font-latin text-xs font-semibold text-gold">
                            {perfume.brand}
                          </p>
                        )}
                        {/* Tags Preview */}
                        <div className="mt-1 flex flex-wrap gap-1">
                          {assignedTags.slice(0, 3).map((tid) => {
                            const tagObj = FALLBACK_TAGS.find((t) => t.id === tid);
                            return tagObj ? (
                              <span
                                key={tid}
                                className="rounded bg-zinc-900 px-1.5 py-0.5 text-[10px] text-zinc-400 border border-zinc-800"
                              >
                                {tagObj.label?.ar || tagObj.slug}
                              </span>
                            ) : null;
                          })}
                          {assignedTags.length > 3 && (
                            <span className="text-[10px] text-zinc-500">+{assignedTags.length - 3}</span>
                          )}
                        </div>
                      </div>
                    </td>

                    {/* Shelf */}
                    <td className="p-4 text-zinc-400">
                      {perfume.shelf_location ? (
                        <span className="inline-flex items-center gap-1.5 text-xs text-amber-300 font-medium bg-amber-950/40 px-2 py-1 rounded-md border border-amber-800/50">
                          <MapPin className="h-3 w-3" />
                          <span>{perfume.shelf_location}</span>
                        </span>
                      ) : (
                        <span className="text-zinc-600">-</span>
                      )}
                    </td>

                    {/* Price */}
                    <td className="p-4 font-semibold text-zinc-300">
                      {perfume.price ? `${perfume.price} د.ت` : '-'}
                    </td>

                    {/* 1-Click Availability Toggle Switch */}
                    <td className="p-4">
                      <div className="flex items-center gap-2">
                        <button
                          type="button"
                          onClick={() => handleToggleAvailable(perfume.id)}
                          className={clsx(
                            'relative inline-flex h-6 w-11 shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none',
                            perfume.is_available ? 'bg-emerald-600' : 'bg-zinc-700'
                          )}
                          title="Toggle stock availability"
                        >
                          <span
                            className={clsx(
                              'pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow-lg ring-0 transition duration-200 ease-in-out',
                              perfume.is_available ? 'translate-x-5' : 'translate-x-0'
                            )}
                          />
                        </button>
                        <span className="text-xs text-zinc-400">
                          {perfume.is_draft ? (
                            <span className="rounded bg-amber-900/60 text-amber-300 px-1.5 py-0.5 text-[10px] font-bold">
                              Draft
                            </span>
                          ) : perfume.is_available ? (
                            <span className="text-emerald-400 font-semibold">Available</span>
                          ) : (
                            <span className="text-zinc-500">Out of Stock</span>
                          )}
                        </span>
                      </div>
                    </td>

                    {/* Actions */}
                    <td className="p-4 text-end">
                      <div className="inline-flex items-center gap-2">
                        <button
                          type="button"
                          onClick={() => handleOpenEdit(perfume)}
                          className="rounded-lg p-1.5 text-zinc-400 hover:bg-zinc-800 hover:text-gold"
                          title="Edit"
                        >
                          <Edit2 className="h-4 w-4" />
                        </button>
                        <button
                          type="button"
                          onClick={() => handleDelete(perfume.id)}
                          className="rounded-lg p-1.5 text-zinc-400 hover:bg-red-950/40 hover:text-red-400"
                          title="Delete"
                        >
                          <Trash2 className="h-4 w-4" />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      {/* Add / Edit Perfume Modal (Strictly Image-Free) */}
      {isModalOpen && (
        <div
          role="dialog"
          aria-modal="true"
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-zinc-950/80 backdrop-blur-md animate-fade-in overflow-y-auto"
        >
          <div className="relative w-full max-w-2xl rounded-3xl border border-zinc-800 bg-surface p-6 sm:p-8 shadow-2xl my-8 max-h-[90vh] overflow-y-auto">
            <button
              type="button"
              onClick={() => setIsModalOpen(false)}
              className="absolute top-5 right-5 rounded-full p-2 text-zinc-400 hover:text-zinc-200"
            >
              <X className="h-5 w-5" />
            </button>

            <h3 className="text-xl font-bold text-zinc-50 mb-1">
              {editingPerfume
                ? (locale === 'ar' ? 'تعديل بيانات العطر' : 'Edit Perfume')
                : (locale === 'ar' ? 'إضافة عطر جديد للكتالوج' : 'Add Perfume to Catalog')}
            </h3>
            <p className="text-xs text-zinc-400 mb-6">
              {locale === 'ar'
                ? 'العطور تعتمد كلياً على الطباعة الفاخرة والوصف الحسي بدون صور'
                : 'Perfumes are strictly image-free, rendered via luxury Latin typography and sensory descriptions'}
            </p>

            <form onSubmit={handleSave} className="space-y-6">
              {/* Basic Fields */}
              <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'اسم العطر (إلزامي باللاتيني)' : 'Perfume Name (Mandatory Latin)'}
                  </label>
                  <input
                    type="text"
                    required
                    value={formName}
                    onChange={(e) => setFormName(e.target.value)}
                    placeholder="Bleu de Chanel Parfum"
                    className="font-latin w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 font-bold focus:border-gold focus:outline-none"
                  />
                </div>

                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'الماركة / الدار (باللاتيني)' : 'Brand / House (Latin)'}
                  </label>
                  <input
                    type="text"
                    value={formBrand}
                    onChange={(e) => setFormBrand(e.target.value)}
                    placeholder="Chanel"
                    className="font-latin w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>

                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'السعر (د.ت)' : 'Price (TND)'}
                  </label>
                  <input
                    type="number"
                    step="0.01"
                    value={formPrice}
                    onChange={(e) => setFormPrice(e.target.value)}
                    placeholder="450"
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>

                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'موقع الرف في المتجر (Kiosk)' : 'In-Store Shelf Location'}
                  </label>
                  <input
                    type="text"
                    value={formShelf}
                    onChange={(e) => setFormShelf(e.target.value)}
                    placeholder="Section A - Top Shelf (A1)"
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>
              </div>

              {/* Status Toggles */}
              <div className="flex flex-wrap items-center gap-6 p-4 rounded-2xl bg-zinc-900/60 border border-zinc-800">
                <label className="flex items-center gap-2 cursor-pointer text-xs font-semibold text-zinc-300">
                  <input
                    type="checkbox"
                    checked={formIsAvailable}
                    onChange={(e) => setFormIsAvailable(e.target.checked)}
                    className="rounded border-zinc-700 bg-zinc-800 text-gold focus:ring-gold"
                  />
                  <span>{locale === 'ar' ? 'متوفر بالمخزون' : 'Available in stock'}</span>
                </label>

                <label className="flex items-center gap-2 cursor-pointer text-xs font-semibold text-zinc-300">
                  <input
                    type="checkbox"
                    checked={formIsFeatured}
                    onChange={(e) => setFormIsFeatured(e.target.checked)}
                    className="rounded border-zinc-700 bg-zinc-800 text-gold focus:ring-gold"
                  />
                  <span>{locale === 'ar' ? 'عطر مميز (Featured)' : 'Featured fragrance'}</span>
                </label>

                <label className="flex items-center gap-2 cursor-pointer text-xs font-semibold text-zinc-300">
                  <input
                    type="checkbox"
                    checked={formIsDraft}
                    onChange={(e) => setFormIsDraft(e.target.checked)}
                    className="rounded border-zinc-700 bg-zinc-800 text-gold focus:ring-gold"
                  />
                  <span>{locale === 'ar' ? 'مسودة بحاجة لمراجعة' : 'Draft / Needs review'}</span>
                </label>
              </div>

              {/* Multi-Language Sensory Description Tabs */}
              <div>
                <div className="flex items-center justify-between mb-2">
                  <span className="text-xs font-bold text-zinc-300">
                    {locale === 'ar' ? 'الوصف الحسي للعطر (3 لغات)' : 'Sensory Fragrance Description'}
                  </span>
                  <div className="flex gap-1">
                    {(['ar', 'fr', 'en'] as const).map((lang) => (
                      <button
                        key={lang}
                        type="button"
                        onClick={() => setActiveLangTab(lang)}
                        className={clsx(
                          'rounded px-2.5 py-1 text-[11px] font-bold uppercase transition-colors',
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

                {activeLangTab === 'ar' && (
                  <textarea
                    rows={3}
                    value={formDescAr}
                    onChange={(e) => setFormDescAr(e.target.value)}
                    placeholder="تركيبة خشبية أروماتيكية آسرة تجمع بين نضارة خشب الصندل وعمق الأرز..."
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 p-3 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                )}
                {activeLangTab === 'fr' && (
                  <textarea
                    rows={3}
                    value={formDescFr}
                    onChange={(e) => setFormDescFr(e.target.value)}
                    placeholder="Un parfum aromatique boisé intense aux notes nobles de santal..."
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 p-3 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                )}
                {activeLangTab === 'en' && (
                  <textarea
                    rows={3}
                    value={formDescEn}
                    onChange={(e) => setFormDescEn(e.target.value)}
                    placeholder="A captivating woody aromatic fragrance blending noble sandalwood..."
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 p-3 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                )}
              </div>

              {/* Interactive Multi-Select Tag Chips Grouped by Category (PRD Section 9.2) */}
              <div>
                <div className="flex items-center justify-between mb-2">
                  <span className="text-xs font-bold text-zinc-300">
                    {locale === 'ar'
                      ? 'السمات العطرية المخصصة (انقر على الشارات لتحديدها)'
                      : 'Characteristic Fragrance Tags (Click chips to assign)'}
                  </span>
                  <span className="text-xs text-gold font-bold">
                    {selectedTagIds.length} {locale === 'ar' ? 'محددة' : 'assigned'}
                  </span>
                </div>

                <div className="space-y-4 max-h-56 overflow-y-auto rounded-2xl border border-zinc-800 bg-zinc-900/40 p-4">
                  {(Object.keys(tagsByCategory) as TagCategory[]).map((cat) => {
                    const catTags = tagsByCategory[cat];
                    const catTitle = locale === 'ar' ? CATEGORY_NAMES[cat].ar : CATEGORY_NAMES[cat].en;

                    return (
                      <div key={cat} className="space-y-1.5">
                        <span className="text-[11px] font-bold text-zinc-400 uppercase tracking-wider">
                          {catTitle}
                        </span>
                        <div className="flex flex-wrap gap-1.5">
                          {catTags.map((tag) => {
                            const isSelected = selectedTagIds.includes(tag.id);
                            const label = resolveLocalized(tag.label, locale);

                            return (
                              <button
                                key={tag.id}
                                type="button"
                                onClick={() => toggleTagChip(tag.id)}
                                className={clsx(
                                  'inline-flex items-center gap-1.5 rounded-full px-3 py-1 text-xs font-semibold transition-all duration-150 cursor-pointer',
                                  isSelected
                                    ? 'bg-gold text-zinc-950 font-bold shadow-sm'
                                    : 'bg-zinc-800/80 border border-zinc-700/60 text-zinc-300 hover:border-zinc-500 hover:text-zinc-100'
                                )}
                              >
                                {isSelected ? (
                                  <Check className="h-3 w-3 stroke-[3]" />
                                ) : (
                                  <TagIcon className="h-3 w-3 text-zinc-500" />
                                )}
                                <span>{label || tag.slug}</span>
                              </button>
                            );
                          })}
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>

              {/* Form Actions */}
              <div className="flex justify-end gap-3 pt-4 border-t border-zinc-800">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="rounded-xl px-5 py-2.5 text-xs font-semibold text-zinc-400 hover:text-zinc-200"
                >
                  {locale === 'ar' ? 'إلغاء' : 'Cancel'}
                </button>
                <button
                  type="submit"
                  className="rounded-xl bg-gold px-6 py-2.5 text-xs font-bold text-zinc-950 hover:bg-gold-light cursor-pointer shadow-md"
                >
                  {locale === 'ar' ? 'حفظ العطر' : 'Save Perfume'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
