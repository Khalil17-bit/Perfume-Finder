'use client';

import { useState, useMemo } from 'react';
import { useLocale } from 'next-intl';
import { FALLBACK_TAGS } from '@/lib/data/fallback-data';
import { Tag, TagCategory } from '@/lib/supabase/types';
import { resolveLocalized } from '@/lib/i18n-helper';
import {
  Tag as TagIcon,
  Plus,
  Search,
  Edit2,
  Trash2,
  X,
  Check,
} from 'lucide-react';
import clsx from 'clsx';

const CATEGORIES: { key: TagCategory | 'all'; labelAr: string; labelEn: string }[] = [
  { key: 'all', labelAr: 'الكل', labelEn: 'All Categories' },
  { key: 'gender', labelAr: 'الفئة المستهدفة', labelEn: 'Gender' },
  { key: 'vibe', labelAr: 'الإحساس والطابع', labelEn: 'Vibe & Mood' },
  { key: 'occasion', labelAr: 'المناسبة', labelEn: 'Occasion' },
  { key: 'season', labelAr: 'الموسم', labelEn: 'Season' },
  { key: 'intensity', labelAr: 'درجة الفوحان', labelEn: 'Intensity' },
  { key: 'notes', labelAr: 'النغمات العطرية', labelEn: 'Notes & Accords' },
];

export default function AdminTagsPage() {
  const locale = useLocale();

  const [tags, setTags] = useState<Tag[]>(FALLBACK_TAGS);
  const [selectedCategory, setSelectedCategory] = useState<TagCategory | 'all'>('all');
  const [searchQuery, setSearchQuery] = useState('');

  // Modal State
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingTag, setEditingTag] = useState<Tag | null>(null);
  const [formSlug, setFormSlug] = useState('');
  const [formCategory, setFormCategory] = useState<TagCategory>('vibe');
  const [formLabelAr, setFormLabelAr] = useState('');
  const [formLabelFr, setFormLabelFr] = useState('');
  const [formLabelEn, setFormLabelEn] = useState('');

  const filteredTags = useMemo(() => {
    return tags.filter((t) => {
      const matchesCategory = selectedCategory === 'all' || t.category === selectedCategory;
      const labelAr = t.label?.ar || '';
      const labelFr = t.label?.fr || '';
      const labelEn = t.label?.en || '';
      const query = searchQuery.toLowerCase().trim();

      const matchesSearch =
        !query ||
        t.slug.toLowerCase().includes(query) ||
        labelAr.toLowerCase().includes(query) ||
        labelFr.toLowerCase().includes(query) ||
        labelEn.toLowerCase().includes(query);

      return matchesCategory && matchesSearch;
    });
  }, [tags, selectedCategory, searchQuery]);

  const handleOpenAdd = () => {
    setEditingTag(null);
    setFormSlug('');
    setFormCategory('vibe');
    setFormLabelAr('');
    setFormLabelFr('');
    setFormLabelEn('');
    setIsModalOpen(true);
  };

  const handleOpenEdit = (tag: Tag) => {
    setEditingTag(tag);
    setFormSlug(tag.slug);
    setFormCategory(tag.category);
    setFormLabelAr(tag.label?.ar || '');
    setFormLabelFr(tag.label?.fr || '');
    setFormLabelEn(tag.label?.en || '');
    setIsModalOpen(true);
  };

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    if (!formSlug.trim() || !formLabelAr.trim()) return;

    if (editingTag) {
      // Update
      setTags((prev) =>
        prev.map((t) =>
          t.id === editingTag.id
            ? {
                ...t,
                slug: formSlug.trim(),
                category: formCategory,
                label: {
                  ar: formLabelAr.trim(),
                  fr: formLabelFr.trim() || formLabelEn.trim(),
                  en: formLabelEn.trim() || formLabelAr.trim(),
                },
              }
            : t
        )
      );
    } else {
      // Create
      const newTag: Tag = {
        id: `tag_${Date.now()}`,
        slug: formSlug.trim(),
        category: formCategory,
        label: {
          ar: formLabelAr.trim(),
          fr: formLabelFr.trim() || formLabelEn.trim(),
          en: formLabelEn.trim() || formLabelAr.trim(),
        },
        created_at: new Date().toISOString(),
      };
      setTags((prev) => [newTag, ...prev]);
    }

    setIsModalOpen(false);
  };

  const handleDelete = (tagId: string) => {
    if (confirm(locale === 'ar' ? 'هل أنت متأكد من حذف هذه السمة؟' : 'Are you sure you want to delete this tag?')) {
      setTags((prev) => prev.filter((t) => t.id !== tagId));
    }
  };

  return (
    <div className="space-y-6 max-w-6xl">
      {/* Page Title & Add Button */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight text-zinc-50">
            {locale === 'ar' ? 'إدارة السمات والخصائص' : 'Dynamic Fragrance Tags'}
          </h1>
          <p className="mt-1 text-xs sm:text-sm text-textMuted">
            {locale === 'ar'
              ? 'إنشاء وتعديل الخصائص العطرية المستخدمة في تصنيف العطور وحساب أوزان الأسئلة'
              : 'Create and manage attributes used across perfume categorization and scoring weights'}
          </p>
        </div>

        <button
          type="button"
          onClick={handleOpenAdd}
          className="inline-flex items-center gap-2 rounded-xl bg-gold px-4 py-2.5 text-xs font-bold text-zinc-950 shadow-md transition-transform active:scale-95 hover:bg-gold-light cursor-pointer"
        >
          <Plus className="h-4 w-4" />
          <span>{locale === 'ar' ? 'إضافة سمة جديدة' : 'Add New Tag'}</span>
        </button>
      </div>

      {/* Category Pills & Search Bar */}
      <div className="flex flex-col gap-4">
        <div className="flex items-center gap-2 overflow-x-auto pb-2">
          {CATEGORIES.map((cat) => (
            <button
              key={cat.key}
              type="button"
              onClick={() => setSelectedCategory(cat.key)}
              className={clsx(
                'rounded-full px-3.5 py-1.5 text-xs font-semibold whitespace-nowrap transition-all duration-150',
                selectedCategory === cat.key
                  ? 'bg-gold text-zinc-950 font-bold shadow-sm'
                  : 'bg-surface border border-zinc-800 text-zinc-400 hover:text-zinc-200'
              )}
            >
              {locale === 'ar' ? cat.labelAr : cat.labelEn}
            </button>
          ))}
        </div>

        <div className="relative max-w-md">
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder={locale === 'ar' ? 'بحث بالاسم أو المعرّف...' : 'Search tags by label or slug...'}
            className="w-full rounded-xl border border-zinc-800 bg-surface px-4 py-2.5 text-xs sm:text-sm text-zinc-100 placeholder:text-zinc-500 focus:border-gold focus:outline-none"
          />
          <Search className="absolute top-3 right-3.5 h-4 w-4 text-zinc-500 pointer-events-none" />
        </div>
      </div>

      {/* Tags Grid / Table */}
      <div className="rounded-2xl border border-zinc-800 bg-surface/90 overflow-hidden shadow-sm">
        <div className="overflow-x-auto">
          <table className="w-full text-start text-xs sm:text-sm">
            <thead className="border-b border-zinc-800 bg-zinc-900/60 text-zinc-400 font-semibold uppercase tracking-wider">
              <tr>
                <th className="p-4 text-start">{locale === 'ar' ? 'المعرّف (Slug)' : 'Slug'}</th>
                <th className="p-4 text-start">{locale === 'ar' ? 'الفئة' : 'Category'}</th>
                <th className="p-4 text-start">{locale === 'ar' ? 'الاسم (عربي)' : 'Arabic Label'}</th>
                <th className="p-4 text-start">{locale === 'ar' ? 'الاسم (فرنسي / إنجليزي)' : 'FR / EN Labels'}</th>
                <th className="p-4 text-end">{locale === 'ar' ? 'الإجراءات' : 'Actions'}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-zinc-800/60 text-zinc-200">
              {filteredTags.map((tag) => (
                <tr key={tag.id} className="hover:bg-zinc-800/30 transition-colors">
                  <td className="p-4 font-mono text-xs text-gold font-bold">{tag.slug}</td>
                  <td className="p-4">
                    <span className="rounded-full bg-zinc-800 px-2.5 py-0.5 text-[11px] font-semibold text-zinc-300">
                      {tag.category}
                    </span>
                  </td>
                  <td className="p-4 font-bold">{tag.label?.ar || '-'}</td>
                  <td className="p-4 text-zinc-400 text-xs">
                    {tag.label?.fr || '-'} • {tag.label?.en || '-'}
                  </td>
                  <td className="p-4 text-end">
                    <div className="inline-flex items-center gap-2">
                      <button
                        type="button"
                        onClick={() => handleOpenEdit(tag)}
                        className="rounded-lg p-1.5 text-zinc-400 hover:bg-zinc-800 hover:text-gold transition-colors"
                        title="Edit"
                      >
                        <Edit2 className="h-4 w-4" />
                      </button>
                      <button
                        type="button"
                        onClick={() => handleDelete(tag.id)}
                        className="rounded-lg p-1.5 text-zinc-400 hover:bg-red-950/40 hover:text-red-400 transition-colors"
                        title="Delete"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Add / Edit Modal */}
      {isModalOpen && (
        <div
          role="dialog"
          aria-modal="true"
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-zinc-950/80 backdrop-blur-md animate-fade-in"
        >
          <div className="relative w-full max-w-md rounded-3xl border border-zinc-800 bg-surface p-6 shadow-2xl">
            <button
              type="button"
              onClick={() => setIsModalOpen(false)}
              className="absolute top-4 right-4 rounded-full p-2 text-zinc-400 hover:text-zinc-200"
            >
              <X className="h-5 w-5" />
            </button>

            <h3 className="text-lg font-bold text-zinc-50 mb-4">
              {editingTag
                ? (locale === 'ar' ? 'تعديل السمة' : 'Edit Tag')
                : (locale === 'ar' ? 'إضافة سمة جديدة' : 'Add New Tag')}
            </h3>

            <form onSubmit={handleSave} className="space-y-4">
              <div>
                <label className="block text-xs font-semibold text-zinc-300 mb-1">
                  {locale === 'ar' ? 'معرّف السمة (Slug - فريد بالإنجليزي)' : 'Tag Slug (Unique Latin)'}
                </label>
                <input
                  type="text"
                  required
                  value={formSlug}
                  onChange={(e) => setFormSlug(e.target.value)}
                  placeholder="vibe_mysterious"
                  className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 font-mono focus:border-gold focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-zinc-300 mb-1">
                  {locale === 'ar' ? 'الفئة' : 'Category'}
                </label>
                <select
                  value={formCategory}
                  onChange={(e) => setFormCategory(e.target.value as TagCategory)}
                  className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                >
                  <option value="gender">Gender (الفئة المستهدفة)</option>
                  <option value="vibe">Vibe (الإحساس والطابع)</option>
                  <option value="occasion">Occasion (المناسبة)</option>
                  <option value="season">Season (الموسم)</option>
                  <option value="intensity">Intensity (درجة الفوحان)</option>
                  <option value="notes">Notes (النغمات العطرية)</option>
                </select>
              </div>

              <div>
                <label className="block text-xs font-semibold text-zinc-300 mb-1">
                  {locale === 'ar' ? 'الاسم بالعربية (إلزامي)' : 'Arabic Label (Mandatory)'}
                </label>
                <input
                  type="text"
                  required
                  value={formLabelAr}
                  onChange={(e) => setFormLabelAr(e.target.value)}
                  placeholder="غامض وفاخر"
                  className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'الاسم بالفرنسية' : 'French Label'}
                  </label>
                  <input
                    type="text"
                    value={formLabelFr}
                    onChange={(e) => setFormLabelFr(e.target.value)}
                    placeholder="Mystérieux"
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'الاسم بالإنجليزية' : 'English Label'}
                  </label>
                  <input
                    type="text"
                    value={formLabelEn}
                    onChange={(e) => setFormLabelEn(e.target.value)}
                    placeholder="Dark & Mysterious"
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>
              </div>

              <div className="mt-6 flex justify-end gap-3 pt-4 border-t border-zinc-800">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="rounded-xl px-4 py-2 text-xs font-semibold text-zinc-400 hover:text-zinc-200"
                >
                  {locale === 'ar' ? 'إلغاء' : 'Cancel'}
                </button>
                <button
                  type="submit"
                  className="rounded-xl bg-gold px-5 py-2 text-xs font-bold text-zinc-950 hover:bg-gold-light"
                >
                  {locale === 'ar' ? 'حفظ السمة' : 'Save Tag'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
