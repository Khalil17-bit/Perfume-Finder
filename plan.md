# Perfume Finder & In-Store Kiosk - Phased Implementation Plan

## Phase 1: Project Initialization, `next-intl` (RTL/LTR) Setup, & Supabase Schema/RLS Migration
- [x] Phase 1.1: Initialize Next.js 14+ App Router project with TypeScript strict mode, Tailwind CSS with logical properties (`ms-*`, `me-*`, `ps-*`, `pe-*`), and essential dependencies (`@supabase/supabase-js`, `@supabase/ssr`, `next-intl`, `zustand`, `lucide-react`, `clsx`, `tailwind-merge`, `browser-image-compression`, `qrcode.react`, `canvas-confetti`).
- [x] Phase 1.2: Configure `next-intl` for tri-lingual support (`ar` RTL, `fr` LTR, `en` LTR), middleware routing, locale detection, Cairo/Tajawal and Inter font setup, and base dictionary files (`messages/ar.json`, `messages/fr.json`, `messages/en.json`).
- [x] Phase 1.3: Author and execute Supabase PostgreSQL schema migration script defining all 8 core entities (`store_settings`, `tags`, `perfumes`, `perfume_tags`, `questions`, `answers`, `answer_tag_weights`, `analytics_logs`) with structured multi-language JSONB support (`{"ar": "...", "fr": "...", "en": "..."}`).
- [x] Phase 1.4: Implement composite primary keys, foreign key constraints with cascade deletes, and B-Tree indexes on foreign keys and active filter columns (`is_available`, `is_draft`, `is_active`, `step_order`).
- [x] Phase 1.5: Configure Row Level Security (RLS) policies for `anon` public role (filtered read-only on active perfumes/questions, insert-only on `analytics_logs`) and `authenticated` merchant admin role (unrestricted CRUD).
- [x] Phase 1.6: Setup Supabase Storage bucket (`perfume-finder-assets`) with public read access and authenticated upload/delete policies for quiz illustrative images and store logos.
- [x] Phase 1.7: Implement Supabase SSR client factories (`createBrowserClient`, `createServerClient`, middleware client) with environment variable validation.

## Phase 2: Core Utilities & State Management
- [x] Phase 2.1: Build `i18n-helper.ts` utility for runtime fallback resolution of localized JSONB fields (`resolveLocalized(field, locale, fallbackLocale)`), guaranteeing no empty strings if secondary translations are missing.
- [x] Phase 2.2: Implement the Two-Stage Client-Side Adaptive Scoring Engine (`scoring-engine.ts`) with Stage 1 Hard Filtering (eliminating unavailable/draft and non-matching hard-filter selections) and Stage 2 Partial-Completion Safe Weighted Scoring (< 50ms execution, 40% threshold with top-3 fallback, tie-breaking via `is_featured`).
- [x] Phase 2.3: Build `useQuizStore` Zustand store managing user answer selections, step progression, history stack for backward navigation, mode switching (`web` vs `kiosk`), and real-time recommendation accuracy percentage calculation.

## Phase 3: Public Customer Flow (Marketing Web Experience)
- [x] Phase 3.1: Configure global luxury minimalist theme in Tailwind CSS (Zinc-950 background, Zinc-900 surfaces, Metallic Gold / Amber-700 accents, Zinc-50/400 typography) and enforce GPU-only CSS transitions (`transform`, `opacity`).
- [x] Phase 3.2: Implement Single-Purpose Landing Page (`/[locale]/page.tsx`) with 100vh hero section, Store Logo, prominent Language Switcher (`AR | FR | EN`), localized headlines, pulsing "Discover Your Scent" CTA, and Store Footer (address, hours, social links) with zero distraction navigation.
- [x] Phase 3.3: Implement Progressive Quiz Engine UI (`/[locale]/quiz/page.tsx`) featuring distraction-free single-question view, thin top progress bar, RTL-aware Back button, Dynamic Accuracy Indicator, large touch answer cards with illustrative WebP images, and 300ms selection feedback.
- [x] Phase 3.4: Implement Sticky Early Exit CTA ("Show Results Now" / "عرض النتائج الآن") appearing dynamically after 2 answered questions.
- [x] Phase 3.5: Build Image-Free Typographic Results Screen (`/[locale]/results/page.tsx`) with confetti animation, Top 3 Luxury Hero Cards, secondary compatible matches grid, match percentage badges, localized sensory descriptions, localized tag chips, and session logging into `analytics_logs`.

## Phase 4: In-Store Kiosk Mode
- [x] Phase 4.1: Implement dedicated Kiosk routes (`/[locale]/kiosk`, `/[locale]/kiosk/quiz`, `/[locale]/kiosk/results`) with touch-optimized tablet layout, oversized touch targets, and admin isolation.
- [x] Phase 4.2: Build Persistent Reset Control ("Start Over / New Customer") fixed at top center of all Kiosk screens for instant session clearing.
- [x] Phase 4.3: Add Physical Shelf Location display badges (`shelf_location`) to Kiosk perfume result cards for fast tester bottle retrieval by customers and retail staff.
- [x] Phase 4.4: Implement Phone Handoff Modal (`qrcode.react`) on Kiosk results encoding dynamic URL with answered selections and locale, featuring high-contrast QR display and "Done Scanning - Start New Customer" reset button.
- [x] Phase 4.5: Implement 180-second inactivity watchdog hook (`useIdleReset`) auto-clearing session state and returning to Kiosk home screen upon timeout.
- [x] Phase 4.6: Implement merchant 4-digit PIN lock screen (`kiosk_pin`) preventing walk-in shoppers from exiting Kiosk mode into public marketing or admin routes.

## Phase 5: Merchant Admin Dashboard (`/[locale]/admin`)
- [x] Phase 5.1: Build Admin Authentication Flow (`/[locale]/admin/login`), Supabase Auth session management, and Next.js middleware route protection.
- [x] Phase 5.2: Create client-side WebP image compressor utility (`browser-image-compression`) enforcing max 800x800px resolution and < 150KB file size before uploading to Supabase Storage.
- [x] Phase 5.3: Build Dynamic Tags Manager (`/[locale]/admin/tags`) with full CRUD, category grouping (`gender`, `vibe`, `occasion`, `season`, `intensity`, `notes`), and tri-lingual label inputs (`ar`, `fr`, `en`).
- [x] Phase 5.4: Build Image-Free Perfumes Inventory Manager (`/[locale]/admin/perfumes`) featuring instant name/brand search, status filters (`Active`, `Out of Stock`, `Draft`), 1-click `is_available` toggle switch, and interactive multi-select tag chips (preventing free-text typos).
- [x] Phase 5.5: Build Dynamic Quiz Builder (`/[locale]/admin/quiz-builder`) with question reordering (`step_order`), active toggling, answer card editor with client-side WebP uploader, `is_hard_filter` flag, and numeric Tag Weight Assigner.
- [x] Phase 5.6: Build Store Settings & Analytics Overview (`/[locale]/admin/settings` & `/[locale]/admin`) managing store branding, headlines, social links, kiosk PIN, and displaying sessions breakdown (Web vs Kiosk), average questions answered before exit, and top recommended perfumes.

## Phase 6: Automated Kaggle CSV & AI Tagging Seed Script
- [x] Phase 6.1: Author automated seeding pipeline (`src/scripts/seed-kaggle.ts`) capable of reading top 200 global perfume dataset (English Name, Brand, Gender, Notes/Accords).
- [x] Phase 6.2: Implement foundational seed data insertion for base tags across all 6 categories, default 10–12 progressive quiz questions, and default store settings.
- [x] Phase 6.3: Implement LLM batch processing generating localized sensory descriptions (`ar`, `fr`, `en`) and auto-mapping perfume accords to existing tag IDs.
- [x] Phase 6.4: Implement automatic `is_draft = true` flagging for perfumes matching fewer than 2 descriptive tags for merchant review, and configure `npm run seed` CLI command with service role authentication.
