-- -------------------------------------------------------------
-- Perfume Finder & In-Store Kiosk System
-- Migration: 20261108000000_init_perfume_finder.sql
-- -------------------------------------------------------------

-- 1. Store Settings (Single-Row Configuration)
CREATE TABLE IF NOT EXISTS public.store_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_name JSONB NOT NULL DEFAULT '{"ar":"مستكشف العطور الفاخرة","fr":"Découvreur de Parfum de Luxe","en":"Luxury Perfume Finder"}'::jsonb,
    hero_title JSONB NOT NULL DEFAULT '{"ar":"اكتشف بصمتك العطرية الفريدة","fr":"Découvrez votre signature olfactive","en":"Discover Your Scent Signature"}'::jsonb,
    hero_subtitle JSONB NOT NULL DEFAULT '{"ar":"تجربة ذكية وراقية تكتشف من خلالها العطر المثالي الذي يجسد شخصيتك وذوقك خلال 30 ثانية فقط.","fr":"Une expérience immersive pour révéler le parfum qui sublime votre personnalité en seulement 30 secondes.","en":"An elevated fragrance discovery experience tailored to your unique taste and mood in just 30 seconds."}'::jsonb,
    logo_url TEXT,
    store_address JSONB DEFAULT '{"ar":"تونس العاصمة، شارع الحبيب بورقيبة","fr":"Tunis, Avenue Habib Bourguiba","en":"Tunis, Habib Bourguiba Avenue"}'::jsonb,
    operating_hours JSONB DEFAULT '{"ar":"يومياً: 10:00 ص - 09:00 م","fr":"Tous les jours: 10h00 - 21h00","en":"Daily: 10:00 AM - 09:00 PM"}'::jsonb,
    social_links JSONB DEFAULT '{"instagram":"","tiktok":"","whatsapp":"","maps":""}'::jsonb,
    default_locale TEXT NOT NULL DEFAULT 'ar',
    kiosk_pin TEXT NOT NULL DEFAULT '1234',
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Tags (Fragrance Attributes & Categories)
CREATE TABLE IF NOT EXISTS public.tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT NOT NULL UNIQUE,
    category TEXT NOT NULL CHECK (category IN ('gender', 'vibe', 'occasion', 'season', 'intensity', 'notes')),
    label JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 3. Perfumes (Catalog - Strictly Image-Free)
CREATE TABLE IF NOT EXISTS public.perfumes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    brand TEXT,
    description JSONB NOT NULL DEFAULT '{}'::jsonb,
    price NUMERIC(10,2),
    shelf_location TEXT,
    is_available BOOLEAN NOT NULL DEFAULT true,
    is_featured BOOLEAN NOT NULL DEFAULT false,
    is_draft BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 4. Perfume-to-Tag Junction (Many-to-Many)
CREATE TABLE IF NOT EXISTS public.perfume_tags (
    perfume_id UUID NOT NULL REFERENCES public.perfumes(id) ON DELETE CASCADE,
    tag_id UUID NOT NULL REFERENCES public.tags(id) ON DELETE CASCADE,
    PRIMARY KEY (perfume_id, tag_id)
);

-- 5. Quiz Questions
CREATE TABLE IF NOT EXISTS public.questions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    step_order INTEGER NOT NULL DEFAULT 1,
    is_active BOOLEAN NOT NULL DEFAULT true,
    question_text JSONB NOT NULL DEFAULT '{}'::jsonb,
    helper_text JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 6. Quiz Answers
CREATE TABLE IF NOT EXISTS public.answers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    question_id UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
    sort_order INTEGER NOT NULL DEFAULT 1,
    title JSONB NOT NULL DEFAULT '{}'::jsonb,
    subtitle_explanation JSONB DEFAULT '{}'::jsonb,
    image_url TEXT,
    is_hard_filter BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 7. Answer-to-Tag Scoring Junction
CREATE TABLE IF NOT EXISTS public.answer_tag_weights (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    answer_id UUID NOT NULL REFERENCES public.answers(id) ON DELETE CASCADE,
    tag_id UUID NOT NULL REFERENCES public.tags(id) ON DELETE CASCADE,
    weight_points INTEGER NOT NULL DEFAULT 10,
    CONSTRAINT uq_answer_tag UNIQUE (answer_id, tag_id)
);

-- 8. Analytics & Session Logs
CREATE TABLE IF NOT EXISTS public.analytics_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mode TEXT NOT NULL CHECK (mode IN ('web', 'kiosk')),
    answered_count INTEGER NOT NULL DEFAULT 0,
    top_perfume_id UUID REFERENCES public.perfumes(id) ON DELETE SET NULL,
    selected_answer_ids UUID[] NOT NULL DEFAULT '{}'::uuid[],
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- -------------------------------------------------------------
-- Performance B-Tree Indexes
-- -------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_perfume_tags_tag_id ON public.perfume_tags(tag_id);
CREATE INDEX IF NOT EXISTS idx_perfumes_availability ON public.perfumes(is_available, is_draft);
CREATE INDEX IF NOT EXISTS idx_questions_active_order ON public.questions(is_active, step_order);
CREATE INDEX IF NOT EXISTS idx_answers_question_id ON public.answers(question_id, sort_order);
CREATE INDEX IF NOT EXISTS idx_answer_tag_weights_answer_id ON public.answer_tag_weights(answer_id);
CREATE INDEX IF NOT EXISTS idx_answer_tag_weights_tag_id ON public.answer_tag_weights(tag_id);
CREATE INDEX IF NOT EXISTS idx_tags_category ON public.tags(category);
CREATE INDEX IF NOT EXISTS idx_analytics_mode_created ON public.analytics_logs(mode, created_at);

-- -------------------------------------------------------------
-- Row Level Security (RLS) Configuration
-- -------------------------------------------------------------
ALTER TABLE public.store_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.perfumes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.perfume_tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.answer_tag_weights ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.analytics_logs ENABLE ROW LEVEL SECURITY;

-- Anonymous (Public Web & Kiosk) Policies
CREATE POLICY "anon_select_store_settings" ON public.store_settings
    FOR SELECT TO anon USING (true);

CREATE POLICY "anon_select_tags" ON public.tags
    FOR SELECT TO anon USING (true);

CREATE POLICY "anon_select_perfumes" ON public.perfumes
    FOR SELECT TO anon
    USING (is_available = true AND is_draft = false);

CREATE POLICY "anon_select_perfume_tags" ON public.perfume_tags
    FOR SELECT TO anon USING (true);

CREATE POLICY "anon_select_questions" ON public.questions
    FOR SELECT TO anon
    USING (is_active = true);

CREATE POLICY "anon_select_answers" ON public.answers
    FOR SELECT TO anon USING (true);

CREATE POLICY "anon_select_answer_tag_weights" ON public.answer_tag_weights
    FOR SELECT TO anon USING (true);

CREATE POLICY "anon_insert_analytics" ON public.analytics_logs
    FOR INSERT TO anon WITH CHECK (true);

-- Authenticated (Merchant Admin) Full Access Policies
CREATE POLICY "admin_all_store_settings" ON public.store_settings
    FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "admin_all_tags" ON public.tags
    FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "admin_all_perfumes" ON public.perfumes
    FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "admin_all_perfume_tags" ON public.perfume_tags
    FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "admin_all_questions" ON public.questions
    FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "admin_all_answers" ON public.answers
    FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "admin_all_answer_tag_weights" ON public.answer_tag_weights
    FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "admin_all_analytics" ON public.analytics_logs
    FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- -------------------------------------------------------------
-- Storage Bucket for Assets (Illustrative WebP Images & Store Logo)
-- -------------------------------------------------------------
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
    'perfume-finder-assets',
    'perfume-finder-assets',
    true,
    2097152, -- 2MB max
    ARRAY['image/webp', 'image/png', 'image/jpeg', 'image/svg+xml']
)
ON CONFLICT (id) DO UPDATE SET
    public = true,
    file_size_limit = 2097152,
    allowed_mime_types = ARRAY['image/webp', 'image/png', 'image/jpeg', 'image/svg+xml'];

-- Storage RLS
CREATE POLICY "public_view_assets" ON storage.objects
    FOR SELECT TO anon, authenticated
    USING (bucket_id = 'perfume-finder-assets');

CREATE POLICY "admin_upload_assets" ON storage.objects
    FOR INSERT TO authenticated
    WITH CHECK (bucket_id = 'perfume-finder-assets');

CREATE POLICY "admin_update_assets" ON storage.objects
    FOR UPDATE TO authenticated
    USING (bucket_id = 'perfume-finder-assets')
    WITH CHECK (bucket_id = 'perfume-finder-assets');

CREATE POLICY "admin_delete_assets" ON storage.objects
    FOR DELETE TO authenticated
    USING (bucket_id = 'perfume-finder-assets');

-- -------------------------------------------------------------
-- Initial Seed: Default Store Profile
-- -------------------------------------------------------------
INSERT INTO public.store_settings (
    store_name,
    hero_title,
    hero_subtitle,
    default_locale,
    kiosk_pin
)
SELECT
    '{"ar":"مستكشف العطور الفاخرة","fr":"Découvreur de Parfum de Luxe","en":"Luxury Perfume Finder"}'::jsonb,
    '{"ar":"اكتشف بصمتك العطرية الفريدة","fr":"Découvrez votre signature olfactive","en":"Discover Your Scent Signature"}'::jsonb,
    '{"ar":"تجربة ذكية وراقية تكتشف من خلالها العطر المثالي الذي يجسد شخصيتك وذوقك خلال 30 ثانية فقط.","fr":"Une expérience immersive pour révéler le parfum qui sublime votre personnalité en seulement 30 secondes.","en":"An elevated fragrance discovery experience tailored to your unique taste and mood in just 30 seconds."}'::jsonb,
    'ar',
    '1234'
WHERE NOT EXISTS (SELECT 1 FROM public.store_settings);
