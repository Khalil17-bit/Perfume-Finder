'use client';

import { useState } from 'react';
import { useLocale } from 'next-intl';
import {
  FALLBACK_QUESTIONS,
  FALLBACK_ANSWERS,
  FALLBACK_ANSWER_TAG_WEIGHTS,
  FALLBACK_TAGS,
} from '@/lib/data/fallback-data';
import { Question, Answer, AnswerTagWeight, Tag } from '@/lib/supabase/types';
import { resolveLocalized } from '@/lib/i18n-helper';
import { compressToWebP } from '@/lib/image-compressor';
import {
  HelpCircle,
  Plus,
  ArrowUp,
  ArrowDown,
  Edit2,
  Trash2,
  Image as ImageIcon,
  Check,
  X,
  Sparkles,
  ChevronRight,
  ChevronDown,
  Scale,
} from 'lucide-react';
import clsx from 'clsx';

export default function AdminQuizBuilderPage() {
  const locale = useLocale();

  const [questions, setQuestions] = useState<Question[]>(FALLBACK_QUESTIONS);
  const [answers, setAnswers] = useState<Answer[]>(FALLBACK_ANSWERS);
  const [weights, setWeights] = useState<AnswerTagWeight[]>(FALLBACK_ANSWER_TAG_WEIGHTS);

  const [expandedQuestionId, setExpandedQuestionId] = useState<string | null>(FALLBACK_QUESTIONS[0]?.id || null);

  // Question Modal
  const [isQuestionModalOpen, setIsQuestionModalOpen] = useState(false);
  const [editingQuestion, setEditingQuestion] = useState<Question | null>(null);
  const [qTextAr, setQTextAr] = useState('');
  const [qTextFr, setQTextFr] = useState('');
  const [qTextEn, setQTextEn] = useState('');
  const [qHelperAr, setQHelperAr] = useState('');

  // Answer Modal
  const [isAnswerModalOpen, setIsAnswerModalOpen] = useState(false);
  const [activeQuestionForAnswer, setActiveQuestionForAnswer] = useState<string | null>(null);
  const [editingAnswer, setEditingAnswer] = useState<Answer | null>(null);
  const [aTitleAr, setATitleAr] = useState('');
  const [aTitleFr, setATitleFr] = useState('');
  const [aTitleEn, setATitleEn] = useState('');
  const [aSubAr, setASubAr] = useState('');
  const [aIsHardFilter, setAIsHardFilter] = useState(false);
  const [aImagePreview, setAImagePreview] = useState<string | null>(null);
  const [compressionInfo, setCompressionInfo] = useState<string | null>(null);

  // Tag weights mapping inside Answer Modal: tagId -> weight_points
  const [currentAnswerWeights, setCurrentAnswerWeights] = useState<Record<string, number>>({});

  // Question Reordering (Up/Down)
  const handleMoveQuestion = (index: number, direction: 'up' | 'down') => {
    const targetIndex = direction === 'up' ? index - 1 : index + 1;
    if (targetIndex < 0 || targetIndex >= questions.length) return;

    const newQuestions = [...questions];
    const temp = newQuestions[index];
    newQuestions[index] = newQuestions[targetIndex];
    newQuestions[targetIndex] = temp;

    // Recalculate step_order
    newQuestions.forEach((q, idx) => {
      q.step_order = idx + 1;
    });

    setQuestions(newQuestions);
  };

  const handleToggleQuestionActive = (qId: string) => {
    setQuestions((prev) =>
      prev.map((q) => (q.id === qId ? { ...q, is_active: !q.is_active } : q))
    );
  };

  const handleOpenAddQuestion = () => {
    setEditingQuestion(null);
    setQTextAr('');
    setQTextFr('');
    setQTextEn('');
    setQHelperAr('');
    setIsQuestionModalOpen(true);
  };

  const handleOpenEditQuestion = (q: Question) => {
    setEditingQuestion(q);
    setQTextAr(q.question_text?.ar || '');
    setQTextFr(q.question_text?.fr || '');
    setQTextEn(q.question_text?.en || '');
    setQHelperAr(q.helper_text?.ar || '');
    setIsQuestionModalOpen(true);
  };

  const handleSaveQuestion = (e: React.FormEvent) => {
    e.preventDefault();
    if (!qTextAr.trim()) return;

    const qTextObj = {
      ar: qTextAr.trim(),
      fr: qTextFr.trim() || qTextEn.trim(),
      en: qTextEn.trim() || qTextAr.trim(),
    };
    const helperObj = qHelperAr.trim() ? { ar: qHelperAr.trim(), fr: '', en: '' } : null;

    if (editingQuestion) {
      setQuestions((prev) =>
        prev.map((q) =>
          q.id === editingQuestion.id
            ? { ...q, question_text: qTextObj, helper_text: helperObj }
            : q
        )
      );
    } else {
      const newQ: Question = {
        id: `q_${Date.now()}`,
        step_order: questions.length + 1,
        is_active: true,
        question_text: qTextObj,
        helper_text: helperObj,
        created_at: new Date().toISOString(),
      };
      setQuestions((prev) => [...prev, newQ]);
      setExpandedQuestionId(newQ.id);
    }

    setIsQuestionModalOpen(false);
  };

  const handleDeleteQuestion = (qId: string) => {
    if (confirm(locale === 'ar' ? 'هل أنت متأكد من حذف هذا السؤال؟' : 'Delete this question?')) {
      setQuestions((prev) => prev.filter((q) => q.id !== qId));
      setAnswers((prev) => prev.filter((a) => a.question_id !== qId));
    }
  };

  // Answer CRUD & Tag Weights
  const handleOpenAddAnswer = (qId: string) => {
    setActiveQuestionForAnswer(qId);
    setEditingAnswer(null);
    setATitleAr('');
    setATitleFr('');
    setATitleEn('');
    setASubAr('');
    setAIsHardFilter(false);
    setAImagePreview(null);
    setCompressionInfo(null);
    setCurrentAnswerWeights({});
    setIsAnswerModalOpen(true);
  };

  const handleOpenEditAnswer = (ans: Answer) => {
    setActiveQuestionForAnswer(ans.question_id);
    setEditingAnswer(ans);
    setATitleAr(ans.title?.ar || '');
    setATitleFr(ans.title?.fr || '');
    setATitleEn(ans.title?.en || '');
    setASubAr(ans.subtitle_explanation?.ar || '');
    setAIsHardFilter(ans.is_hard_filter);
    setAImagePreview(ans.image_url || null);
    setCompressionInfo(null);

    // Load existing weights for this answer
    const existingWeights: Record<string, number> = {};
    weights
      .filter((w) => w.answer_id === ans.id)
      .forEach((w) => {
        existingWeights[w.tag_id] = w.weight_points;
      });
    setCurrentAnswerWeights(existingWeights);
    setIsAnswerModalOpen(true);
  };

  // Client-Side WebP Compression Image Handler (PRD Section 9.3)
  const handleImageFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    try {
      const result = await compressToWebP(file);
      const previewUrl = URL.createObjectURL(result.file);
      setAImagePreview(previewUrl);
      setCompressionInfo(
        `WebP compressed: ${result.compressedSizeKb} KB (${result.dimensions.width}x${result.dimensions.height}px) - Original: ${result.originalSizeKb} KB`
      );
    } catch {
      alert('Error compressing image to WebP');
    }
  };

  const handleSaveAnswer = (e: React.FormEvent) => {
    e.preventDefault();
    if (!aTitleAr.trim() || !activeQuestionForAnswer) return;

    const titleObj = {
      ar: aTitleAr.trim(),
      fr: aTitleFr.trim() || aTitleEn.trim(),
      en: aTitleEn.trim() || aTitleAr.trim(),
    };
    const subObj = aSubAr.trim() ? { ar: aSubAr.trim(), fr: '', en: '' } : null;

    let ansId = editingAnswer?.id;

    if (editingAnswer) {
      setAnswers((prev) =>
        prev.map((a) =>
          a.id === editingAnswer.id
            ? {
                ...a,
                title: titleObj,
                subtitle_explanation: subObj,
                is_hard_filter: aIsHardFilter,
                image_url: aImagePreview,
              }
            : a
        )
      );
    } else {
      ansId = `ans_${Date.now()}`;
      const newAns: Answer = {
        id: ansId,
        question_id: activeQuestionForAnswer,
        sort_order: answers.filter((a) => a.question_id === activeQuestionForAnswer).length + 1,
        title: titleObj,
        subtitle_explanation: subObj,
        image_url: aImagePreview,
        is_hard_filter: aIsHardFilter,
        created_at: new Date().toISOString(),
      };
      setAnswers((prev) => [...prev, newAns]);
    }

    // Save Tag Weights
    if (ansId) {
      const updatedWeights = weights.filter((w) => w.answer_id !== ansId);
      Object.entries(currentAnswerWeights).forEach(([tagId, pts]) => {
        if (pts > 0) {
          updatedWeights.push({
            id: `w_${ansId}_${tagId}`,
            answer_id: ansId!,
            tag_id: tagId,
            weight_points: pts,
          });
        }
      });
      setWeights(updatedWeights);
    }

    setIsAnswerModalOpen(false);
  };

  const handleDeleteAnswer = (ansId: string) => {
    if (confirm(locale === 'ar' ? 'هل أنت متأكد من حذف هذا الخيار؟' : 'Delete this answer choice?')) {
      setAnswers((prev) => prev.filter((a) => a.id !== ansId));
      setWeights((prev) => prev.filter((w) => w.answer_id !== ansId));
    }
  };

  return (
    <div className="space-y-6 max-w-6xl">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl sm:text-3xl font-extrabold tracking-tight text-zinc-50">
            {locale === 'ar' ? 'منشئ الأسئلة ومحدد الأوزان' : 'Dynamic Quiz Builder & Scoring'}
          </h1>
          <p className="mt-1 text-xs sm:text-sm text-textMuted">
            {locale === 'ar'
              ? 'تعديل ترتيب الأسئلة، الخيارات، الأوزان الحسابية ورفع صور WebP المضغوطة'
              : 'Reorder questions, edit answer vibe cards with client-side WebP compression, and assign tag weights'}
          </p>
        </div>

        <button
          type="button"
          onClick={handleOpenAddQuestion}
          className="inline-flex items-center gap-2 rounded-xl bg-gold px-4 py-2.5 text-xs font-bold text-zinc-950 shadow-md transition-transform active:scale-95 hover:bg-gold-light cursor-pointer"
        >
          <Plus className="h-4 w-4" />
          <span>{locale === 'ar' ? 'إضافة سؤال جديد' : 'Add Question'}</span>
        </button>
      </div>

      {/* Questions Sequence Accordion */}
      <div className="space-y-4">
        {questions.map((question, idx) => {
          const isExpanded = expandedQuestionId === question.id;
          const questionAnswers = answers.filter((a) => a.question_id === question.id);
          const qText = resolveLocalized(question.question_text, locale);

          return (
            <div
              key={question.id}
              className="rounded-2xl border border-zinc-800 bg-surface/90 overflow-hidden shadow-sm"
            >
              {/* Question Header Bar */}
              <div className="flex items-center justify-between p-4 sm:p-5 bg-zinc-900/40">
                <div
                  className="flex items-center gap-3 cursor-pointer flex-1"
                  onClick={() => setExpandedQuestionId(isExpanded ? null : question.id)}
                >
                  <button
                    type="button"
                    className="flex h-7 w-7 items-center justify-center rounded-lg bg-zinc-800 text-xs font-bold text-gold"
                  >
                    #{question.step_order}
                  </button>

                  <div>
                    <h3 className="text-sm sm:text-base font-bold text-zinc-100 flex items-center gap-2">
                      <span>{qText}</span>
                      {!question.is_active && (
                        <span className="rounded bg-red-950 text-red-400 text-[10px] px-1.5 py-0.5 border border-red-800">
                          Hidden
                        </span>
                      )}
                    </h3>
                    <p className="text-xs text-zinc-500">
                      {questionAnswers.length} {locale === 'ar' ? 'خيارات إجابة' : 'answer choices'}
                    </p>
                  </div>
                </div>

                {/* Question Actions (Up, Down, Active Toggle, Edit, Delete) */}
                <div className="flex items-center gap-1 sm:gap-2">
                  <button
                    type="button"
                    disabled={idx === 0}
                    onClick={() => handleMoveQuestion(idx, 'up')}
                    className="rounded-lg p-1.5 text-zinc-400 hover:bg-zinc-800 hover:text-zinc-200 disabled:opacity-30"
                    title="Move Up"
                  >
                    <ArrowUp className="h-4 w-4" />
                  </button>
                  <button
                    type="button"
                    disabled={idx === questions.length - 1}
                    onClick={() => handleMoveQuestion(idx, 'down')}
                    className="rounded-lg p-1.5 text-zinc-400 hover:bg-zinc-800 hover:text-zinc-200 disabled:opacity-30"
                    title="Move Down"
                  >
                    <ArrowDown className="h-4 w-4" />
                  </button>

                  <button
                    type="button"
                    onClick={() => handleToggleQuestionActive(question.id)}
                    className={clsx(
                      'rounded-lg px-2.5 py-1 text-xs font-semibold transition-colors',
                      question.is_active
                        ? 'bg-emerald-950/60 text-emerald-400 border border-emerald-800'
                        : 'bg-zinc-800 text-zinc-500'
                    )}
                  >
                    {question.is_active ? 'Active' : 'Draft'}
                  </button>

                  <button
                    type="button"
                    onClick={() => handleOpenEditQuestion(question)}
                    className="rounded-lg p-1.5 text-zinc-400 hover:bg-zinc-800 hover:text-gold"
                    title="Edit Question"
                  >
                    <Edit2 className="h-4 w-4" />
                  </button>

                  <button
                    type="button"
                    onClick={() => handleDeleteQuestion(question.id)}
                    className="rounded-lg p-1.5 text-zinc-400 hover:bg-red-950/40 hover:text-red-400"
                    title="Delete Question"
                  >
                    <Trash2 className="h-4 w-4" />
                  </button>

                  <button
                    type="button"
                    onClick={() => setExpandedQuestionId(isExpanded ? null : question.id)}
                    className="rounded-lg p-1.5 text-zinc-400 hover:bg-zinc-800"
                  >
                    {isExpanded ? <ChevronDown className="h-4 w-4" /> : <ChevronRight className="h-4 w-4" />}
                  </button>
                </div>
              </div>

              {/* Answers List Accordion Body */}
              {isExpanded && (
                <div className="p-4 sm:p-6 border-t border-zinc-800 space-y-4">
                  <div className="flex items-center justify-between">
                    <span className="text-xs font-bold text-zinc-400 uppercase tracking-wider">
                      {locale === 'ar' ? 'خيارات الإجابة والأوزان' : 'Answer Choices & Tag Weights'}
                    </span>
                    <button
                      type="button"
                      onClick={() => handleOpenAddAnswer(question.id)}
                      className="inline-flex items-center gap-1.5 rounded-lg border border-gold/40 bg-gold/10 px-3 py-1.5 text-xs font-bold text-gold hover:bg-gold hover:text-zinc-950 transition-colors"
                    >
                      <Plus className="h-3.5 w-3.5" />
                      <span>{locale === 'ar' ? 'إضافة خيار إجابة' : 'Add Choice'}</span>
                    </button>
                  </div>

                  {/* Answers Grid */}
                  <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
                    {questionAnswers.map((ans) => {
                      const ansTitle = resolveLocalized(ans.title, locale);
                      const ansSub = resolveLocalized(ans.subtitle_explanation, locale);
                      const ansWeights = weights.filter((w) => w.answer_id === ans.id);

                      return (
                        <div
                          key={ans.id}
                          className="flex flex-col justify-between rounded-xl border border-zinc-800 bg-zinc-900/60 p-4 hover:border-zinc-700 transition-colors"
                        >
                          <div>
                            <div className="flex items-start justify-between gap-2">
                              <h4 className="text-sm font-bold text-zinc-100 flex items-center gap-2">
                                <span>{ansTitle}</span>
                                {ans.is_hard_filter && (
                                  <span className="rounded bg-amber-950 border border-amber-800 px-1.5 py-0.5 text-[10px] font-bold text-amber-300">
                                    Hard Filter
                                  </span>
                                )}
                              </h4>

                              <div className="flex items-center gap-1">
                                <button
                                  type="button"
                                  onClick={() => handleOpenEditAnswer(ans)}
                                  className="rounded p-1 text-zinc-400 hover:text-gold"
                                >
                                  <Edit2 className="h-3.5 w-3.5" />
                                </button>
                                <button
                                  type="button"
                                  onClick={() => handleDeleteAnswer(ans.id)}
                                  className="rounded p-1 text-zinc-400 hover:text-red-400"
                                >
                                  <Trash2 className="h-3.5 w-3.5" />
                                </button>
                              </div>
                            </div>

                            {ansSub && <p className="mt-1 text-xs text-zinc-400">{ansSub}</p>}

                            {/* Tag Weights Chips */}
                            <div className="mt-3 flex flex-wrap gap-1">
                              {ansWeights.map((w) => {
                                const tagObj = FALLBACK_TAGS.find((t) => t.id === w.tag_id);
                                return tagObj ? (
                                  <span
                                    key={w.id}
                                    className="rounded bg-zinc-800 border border-zinc-700/60 px-2 py-0.5 text-[10px] font-bold text-gold"
                                  >
                                    {tagObj.label?.ar || tagObj.slug} (+{w.weight_points} pts)
                                  </span>
                                ) : null;
                              })}
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              )}
            </div>
          );
        })}
      </div>

      {/* Modal: Add/Edit Question */}
      {isQuestionModalOpen && (
        <div
          role="dialog"
          aria-modal="true"
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-zinc-950/80 backdrop-blur-md animate-fade-in"
        >
          <div className="relative w-full max-w-lg rounded-3xl border border-zinc-800 bg-surface p-6 shadow-2xl">
            <button
              type="button"
              onClick={() => setIsQuestionModalOpen(false)}
              className="absolute top-4 right-4 rounded-full p-2 text-zinc-400 hover:text-zinc-200"
            >
              <X className="h-5 w-5" />
            </button>

            <h3 className="text-lg font-bold text-zinc-50 mb-4">
              {editingQuestion
                ? (locale === 'ar' ? 'تعديل السؤال' : 'Edit Question')
                : (locale === 'ar' ? 'إضافة سؤال استكشاف جديد' : 'Add New Question')}
            </h3>

            <form onSubmit={handleSaveQuestion} className="space-y-4">
              <div>
                <label className="block text-xs font-semibold text-zinc-300 mb-1">
                  {locale === 'ar' ? 'نص السؤال بالعربية (إلزامي)' : 'Question Text (Arabic)'}
                </label>
                <input
                  type="text"
                  required
                  value={qTextAr}
                  onChange={(e) => setQTextAr(e.target.value)}
                  placeholder="ما هو الطابع العطري الذي تبحث عنه؟"
                  className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'بالفرنسية' : 'French'}
                  </label>
                  <input
                    type="text"
                    value={qTextFr}
                    onChange={(e) => setQTextFr(e.target.value)}
                    placeholder="Quel sillage recherchez-vous ?"
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'بالإنجليزية' : 'English'}
                  </label>
                  <input
                    type="text"
                    value={qTextEn}
                    onChange={(e) => setQTextEn(e.target.value)}
                    placeholder="What scent vibe are you seeking?"
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-zinc-300 mb-1">
                  {locale === 'ar' ? 'نص توضيحي مساعد (اختياري)' : 'Helper Subtext (Optional)'}
                </label>
                <input
                  type="text"
                  value={qHelperAr}
                  onChange={(e) => setQHelperAr(e.target.value)}
                  placeholder="اختر الإحساس الذي يعبر عن ذوقك الشخصي..."
                  className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                />
              </div>

              <div className="mt-6 flex justify-end gap-3 pt-4 border-t border-zinc-800">
                <button
                  type="button"
                  onClick={() => setIsQuestionModalOpen(false)}
                  className="rounded-xl px-4 py-2 text-xs font-semibold text-zinc-400 hover:text-zinc-200"
                >
                  {locale === 'ar' ? 'إلغاء' : 'Cancel'}
                </button>
                <button
                  type="submit"
                  className="rounded-xl bg-gold px-5 py-2 text-xs font-bold text-zinc-950 hover:bg-gold-light"
                >
                  {locale === 'ar' ? 'حفظ السؤال' : 'Save Question'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Modal: Add/Edit Answer & Tag Weight Assigner */}
      {isAnswerModalOpen && (
        <div
          role="dialog"
          aria-modal="true"
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-zinc-950/80 backdrop-blur-md animate-fade-in overflow-y-auto"
        >
          <div className="relative w-full max-w-xl rounded-3xl border border-zinc-800 bg-surface p-6 sm:p-8 shadow-2xl my-8 max-h-[90vh] overflow-y-auto">
            <button
              type="button"
              onClick={() => setIsAnswerModalOpen(false)}
              className="absolute top-5 right-5 rounded-full p-2 text-zinc-400 hover:text-zinc-200"
            >
              <X className="h-5 w-5" />
            </button>

            <h3 className="text-xl font-bold text-zinc-50 mb-1">
              {editingAnswer
                ? (locale === 'ar' ? 'تعديل خيار الإجابة والأوزان' : 'Edit Answer Choice & Weights')
                : (locale === 'ar' ? 'إضافة خيار إجابة جديد' : 'Add Answer Choice')}
            </h3>

            <form onSubmit={handleSaveAnswer} className="mt-5 space-y-5">
              {/* Answer Titles */}
              <div>
                <label className="block text-xs font-semibold text-zinc-300 mb-1">
                  {locale === 'ar' ? 'عنوان الخيار بالعربية (إلزامي)' : 'Choice Title (Arabic)'}
                </label>
                <input
                  type="text"
                  required
                  value={aTitleAr}
                  onChange={(e) => setATitleAr(e.target.value)}
                  placeholder="منعش وحمضي"
                  className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'بالفرنسية' : 'French'}
                  </label>
                  <input
                    type="text"
                    value={aTitleFr}
                    onChange={(e) => setATitleFr(e.target.value)}
                    placeholder="Frais & Hespéridé"
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-zinc-300 mb-1">
                    {locale === 'ar' ? 'بالإنجليزية' : 'English'}
                  </label>
                  <input
                    type="text"
                    value={aTitleEn}
                    onChange={(e) => setATitleEn(e.target.value)}
                    placeholder="Fresh & Citrus"
                    className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                  />
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-zinc-300 mb-1">
                  {locale === 'ar' ? 'شرح مساعد ومبسط' : 'Subtitle Explanation'}
                </label>
                <input
                  type="text"
                  value={aSubAr}
                  onChange={(e) => setASubAr(e.target.value)}
                  placeholder="حمضيات إيطالية ونفحات مائية تنبض بالحياة"
                  className="w-full rounded-xl border border-zinc-800 bg-zinc-900 px-3.5 py-2.5 text-xs text-zinc-100 focus:border-gold focus:outline-none"
                />
              </div>

              {/* Hard Filter Toggle */}
              <label className="flex items-center gap-2.5 p-3 rounded-xl bg-zinc-900 border border-zinc-800 cursor-pointer">
                <input
                  type="checkbox"
                  checked={aIsHardFilter}
                  onChange={(e) => setAIsHardFilter(e.target.checked)}
                  className="rounded border-zinc-700 bg-zinc-800 text-gold focus:ring-gold"
                />
                <div>
                  <span className="text-xs font-bold text-zinc-200">
                    {locale === 'ar' ? 'فلتر إقصائي صارم (Stage 1 Hard Filter)' : 'Strict Eliminator (Stage 1 Hard Filter)'}
                  </span>
                  <p className="text-[11px] text-zinc-400">
                    {locale === 'ar'
                      ? 'أي عطر لا يمتلك السمات المرتبطة بهذا الخيار يُستبعد تماماً (مثل تحديد الجنس)'
                      : 'Any perfume lacking linked tags is strictly eliminated from matches'}
                  </p>
                </div>
              </label>

              {/* Client-Side WebP Image Compression Uploader (PRD Section 9.3) */}
              <div className="p-4 rounded-2xl border border-dashed border-zinc-700 bg-zinc-900/50">
                <label className="block text-xs font-bold text-zinc-300 mb-1 flex items-center gap-2">
                  <ImageIcon className="h-4 w-4 text-gold" />
                  <span>
                    {locale === 'ar'
                      ? 'صورة تعبيرية للخيار (ضغط WebP تلقائي < 150KB)'
                      : 'Illustrative Vibe Image (Auto WebP < 150KB)'}
                  </span>
                </label>
                <input
                  type="file"
                  accept="image/*"
                  onChange={handleImageFileChange}
                  className="text-xs text-zinc-400 file:mr-3 file:rounded-xl file:border-0 file:bg-zinc-800 file:px-3 file:py-1.5 file:text-xs file:font-semibold file:text-gold hover:file:bg-zinc-700 cursor-pointer"
                />
                {compressionInfo && (
                  <p className="mt-2 text-[11px] font-mono text-emerald-400">
                    {compressionInfo}
                  </p>
                )}
              </div>

              {/* Tag Weight Assigner (PRD Section 9.3) */}
              <div className="space-y-3 pt-3 border-t border-zinc-800">
                <div className="flex items-center justify-between">
                  <span className="text-xs font-bold text-zinc-200 flex items-center gap-1.5">
                    <Scale className="h-4 w-4 text-gold" />
                    <span>{locale === 'ar' ? 'محدد أوزان السمات (Tag Weight Assigner)' : 'Tag Weight Assigner'}</span>
                  </span>
                  <span className="text-[11px] text-zinc-500">
                    {locale === 'ar' ? 'النقاط الممنوحة لكل سمة (+10 إلى +50)' : 'Points awarded to matching perfumes'}
                  </span>
                </div>

                <div className="max-h-52 overflow-y-auto space-y-2 rounded-xl border border-zinc-800 bg-zinc-900/40 p-3">
                  {FALLBACK_TAGS.map((tag) => {
                    const currentPoints = currentAnswerWeights[tag.id] || 0;
                    const label = resolveLocalized(tag.label, locale);

                    return (
                      <div
                        key={tag.id}
                        className="flex items-center justify-between gap-3 py-1 px-2 rounded-lg hover:bg-zinc-800/40"
                      >
                        <span className="text-xs font-medium text-zinc-300">
                          {label || tag.slug}
                        </span>

                        <div className="flex items-center gap-2">
                          <input
                            type="number"
                            min="0"
                            max="100"
                            step="5"
                            value={currentPoints}
                            onChange={(e) => {
                              const val = parseInt(e.target.value) || 0;
                              setCurrentAnswerWeights((prev) => ({
                                ...prev,
                                [tag.id]: val,
                              }));
                            }}
                            className="w-16 rounded-lg border border-zinc-800 bg-zinc-900 px-2 py-1 text-center font-bold text-xs text-gold focus:border-gold focus:outline-none"
                          />
                          <span className="text-[11px] text-zinc-500 font-mono">pts</span>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>

              <div className="flex justify-end gap-3 pt-4 border-t border-zinc-800">
                <button
                  type="button"
                  onClick={() => setIsAnswerModalOpen(false)}
                  className="rounded-xl px-4 py-2 text-xs font-semibold text-zinc-400 hover:text-zinc-200"
                >
                  {locale === 'ar' ? 'إلغاء' : 'Cancel'}
                </button>
                <button
                  type="submit"
                  className="rounded-xl bg-gold px-5 py-2 text-xs font-bold text-zinc-950 hover:bg-gold-light"
                >
                  {locale === 'ar' ? 'حفظ الخيار والأوزان' : 'Save Choice & Weights'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
