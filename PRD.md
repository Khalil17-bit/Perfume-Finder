# Product Requirements Document (PRD): Smart Perfume Finder & In-Store Kiosk System

## 1. Executive Summary & Core Product Vision
The Smart Perfume Finder is a dual-mode web application (Marketing Storefront & In-Store Kiosk) designed for perfume retailers. It solves two core retail problems: **Paradox of Choice** (online and walk-in customers overwhelmed by hundreds of bottles) and **Olfactory Fatigue** (walk-in customers losing their sense of smell after testing 4–5 perfumes). 

The system acts as a digital fragrance expert, guiding users through a progressive, visual quiz and matching their preferences against the store's inventory using a two-stage weighted scoring algorithm.

### Strict Scope Boundaries
- **No E-Commerce Checkout:** The system does NOT include a shopping cart, checkout flow, payment gateway, or order management.
- **No Search Bar or Public Catalog Grid:** The landing page is strictly a single-purpose conversion funnel leading into the Quiz. Customers who already know what they want do not need this tool.
- **No Perfume Images:** Perfumes are represented strictly by their original English/Latin brand and name, localized sensory descriptions, and characteristic tags. Visual images are used ONLY for Quiz Answer options and the Store Logo.

---

## 2. Technical Stack & Global Architecture Constraints
- **Framework:** Next.js (App Router, v14+) with TypeScript in strict mode.
- **Styling & UI:** Tailwind CSS using logical properties (`ms-*`, `me-*`, `ps-*`, `pe-*`, `text-start`, `text-end`) for seamless bidirectional (RTL/LTR) layouts.
- **Backend & Database:** Supabase (PostgreSQL Database, Supabase Auth for Admin, Supabase Storage for Answer/Logo images, Row Level Security).
- **Internationalization (i18n):** `next-intl` supporting Arabic (`ar` - RTL), French (`fr` - LTR), and English (`en` - LTR).
- **Client State Management:** `zustand` for managing active quiz answers, step history, and Kiosk mode state in memory without server round-trips per question.
- **Utilities:** 
  - `qrcode.react` for generating dynamic session-handoff QR codes in Kiosk mode.
  - `browser-image-compression` for mandatory client-side image compression before uploading Answer images or Store Logos to Supabase Storage.
- **Hosting & Deployment:** Vercel connected to Supabase.

---

## 3. Localization & Multi-Language Policy (i18n)
The application supports three languages across the entire user journey: **Arabic (`ar`), French (`fr`), and English (`en`)**.
1. **Perfume Names & Brands:** Must ALWAYS remain in their original English/Latin text across all locales. They are never translated or transliterated.
2. **Perfume Descriptions:** Fully localized into Arabic, French, and English. Displayed dynamically according to the active locale.
3. **Quiz Questions, Answer Titles, Answer Explanations, Tag Labels, and Store UI:** Fully localized into Arabic, French, and English.
4. **Fallback Mechanism:** Every localized field stored in the database uses a structured multi-language object (`ar`, `fr`, `en`). If a merchant leaves a secondary language field empty in the Admin Dashboard, the application automatically falls back to the store's default language so the UI never renders blank text.

---

## 4. Operating Modes & User Journeys

### 4.1. Web & Mobile Marketing Mode (Default Public Flow)
Targeted at customers clicking links from social media ads or bio links on their personal smartphones.
- **Single-Purpose Landing Page (`/[locale]`):**
  - Rendered via Static Site Generation (SSG) / Incremental Static Regeneration (ISR) for sub-second loading, while prefetching quiz data in the background.
  - **Header:** Store Logo and a prominent Language Switcher (`AR | FR | EN`).
  - **Hero Section:** Store Name, localized main headline, localized sub-headline explaining the 30-second discovery process, and a primary CTA button ("Discover Your Perfume").
  - **Store Info Footer:** Physical store address/map link, operating hours, and social media links (Instagram, TikTok, WhatsApp).
  - **Restrictions:** No navigation menus, no product grids, no search bars, and no Kiosk QR triggers.

### 4.2. In-Store Kiosk Mode (`/[locale]/kiosk`)
Targeted at walk-in customers using a dedicated tablet mounted inside the physical perfume shop.
- **Security & Isolation:** Kiosk mode is completely isolated from the Merchant Admin account. It is accessed via the `/[locale]/kiosk` route (and optionally locked into Kiosk state on the tablet browser via `localStorage` using a simple 4-digit PIN set by the merchant). Customers on the tablet have zero access to `/admin` routes.
- **Touch-First Fullscreen UI:** Designed for tablet screens with oversized tap targets.
- **Persistent Reset Control:** A high-visibility "Start Over / New Customer" button is permanently fixed at the top of every Kiosk screen (`/kiosk/quiz` and `/kiosk/results`), allowing instant session clearing at any moment.
- **Shelf Location Display:** Perfume result cards in Kiosk mode explicitly display the physical `shelf_location` (e.g., "Section B - Top Shelf") so the customer or salesperson can locate the tester bottle immediately.
- **QR Code Phone Handoff:**
  - On `/[locale]/kiosk/results`, a prominent button labeled **"Save Results to Your Phone (QR)"** is displayed.
  - Tapping this button opens a modal containing a high-contrast QR code encoding the public results URL with the user's selected answer IDs and active language (`https://{domain}/{locale}/results?ans=id1,id2,id3...`).
  - The customer scans the QR code with their personal phone camera, immediately opening their exact ranked perfume matches on their phone to show the salesperson.
  - Inside the QR modal, a primary button labeled **"Done Scanning - Start New Customer"** clears the tablet state and returns to the Kiosk start screen. As a fallback, if the Kiosk results screen or QR modal is left untouched for 180 seconds, it automatically resets to the Kiosk home screen.

---

## 5. Progressive Quiz Engine Specifications
Instead of forcing users through a rigid short quiz or overwhelming them with a mandatory long quiz, the engine uses **Progressive Profiling**:
- **Deep Question Bank:** Supports 10 to 12+ active questions ordered strategically by `step_order` from most critical (e.g., Gender/Hard Filters, Primary Vibe, Occasion) to nuanced preferences (e.g., Season, Projection, Specific Olfactive Notes).
- **Distraction-Free Single-Question View:** Displays one question per screen with smooth GPU-accelerated transitions (`opacity` and `transform` only). Include a "Back" button to modify the previous answer.
- **Visual Answer Cards:** Each answer option is rendered as a large selectable card containing:
  1. **Illustrative Image:** A visual representation of the vibe, occasion, or scent family (to help non-expert customers understand the choice visually).
  2. **Localized Title:** Clear, concise answer title.
  3. **Localized Subtitle Explanation:** A short helper sentence explaining what this choice means in simple terms.
- **Dynamic Accuracy Indicator:** A top progress header that calculates and displays recommendation confidence (e.g., *"Recommendation Accuracy: 45% — Answer more questions for higher precision"*), gamifying the experience.
- **Early Exit ("Show Results Now"):** As soon as the user answers at least **2 questions**, a persistent sticky secondary button appears at the bottom of the screen: **"Show Results Now"**. The user can click this at any point (e.g., after 3, 5, or 8 questions) to immediately compute and view their matches based on the answers provided so far.

---

## 6. Two-Stage Adaptive Scoring & Matching Algorithm
The matching algorithm executes **Client-Side** in under 50 milliseconds, using pre-fetched active perfumes and tag mappings. It natively handles both full quiz completions and partial completions (Early Exit).

### Stage 1: Hard Filtering (Strict Elimination)
Before calculating points, the engine filters the inventory list:
1. **Availability & Readiness Check:** Any perfume where `is_available` is `false` or `is_draft` is `true` is immediately excluded.
2. **Hard Filter Answers:** The engine checks all questions answered by the user where the selected answer has `is_hard_filter` set to `true` (for example, a Gender filter question).
   - It retrieves the list of target tags linked to that selected answer.
   - If the answer has linked tags, any perfume that does NOT possess at least one of those linked tags is completely eliminated from consideration (e.g., selecting "For Men" links to `gender_male` and `gender_unisex` tags; perfumes tagged only with `gender_female` are eliminated).
   - If an answer under a hard-filter question has no linked tags (e.g., "Gift / Any"), no perfumes are eliminated by that question.

### Stage 2: Adaptive Weighted Scoring (Partial-Completion Safe)
For all perfumes surviving Stage 1, the engine evaluates only the **non-hard-filter questions that the user actually answered** (unanswered questions skipped via Early Exit are ignored and do not penalize the score):
1. **Calculate Maximum Possible Score (`Max_Score`):**
   - For each answered non-hard-filter question, sum the `weight_points` of all tags associated with the user's selected answer.
   - *Edge Case:* If the user only answered Hard Filter questions and triggered Early Exit (`Max_Score == 0`), all Stage 1 surviving perfumes receive a default `100%` match and are ordered by `is_featured`.
2. **Calculate Individual Perfume Score (`Perfume_Score`):**
   - Initialize `Perfume_Score = 0` for each surviving perfume.
   - Loop through each selected non-hard-filter answer and inspect its linked tag weights (`tag_id` and `weight_points`).
   - Whenever the perfume's assigned tags include that `tag_id`, add the corresponding `weight_points` to `Perfume_Score`.
3. **Compute Match Percentage:**
   - `Match_Percentage = Math.round((Perfume_Score / Max_Score) * 100)`.
4. **Thresholding & Ranking:**
   - Filter out perfumes with `Match_Percentage < 40%` (Fallback: if fewer than 3 perfumes achieve 40%, display the top 3 highest-scoring perfumes regardless of percentage so the screen is never empty).
   - Sort all qualifying perfumes in descending order of `Match_Percentage`. In case of a tie, prioritize perfumes where `is_featured` is `true`.

---

## 7. Results Screen & Typographic Perfume Cards
- **Comprehensive Match Display:** The Results page displays **all** compatible perfumes that pass the scoring threshold, ordered from highest match percentage to lowest.
- **Visual Hierarchy:**
  - **Top 3 Matches (Hero Section):** Highlighted prominently at the top of the page in larger cards with distinct luxury borders.
  - **Other Compatible Perfumes:** Displayed below the Top 3 in a clean responsive grid, allowing the customer to browse all matching options with their exact match percentages.
- **Image-Free Typographic Card Design:** Because perfumes do not have images, each perfume card is styled as an upscale, typographic fragrance dossier containing:
  - **Match Percentage Badge:** Prominent pill badge (e.g., `96% Match`).
  - **Perfume Name & Brand:** Large, bold Latin typography.
  - **Localized Description:** Sensory description in the user's selected language (`ar`, `fr`, or `en`).
  - **Matched Tag Badges:** Visual chips displaying the localized labels of the perfume's tags (e.g., `Woody`, `Evening`, `Strong Projection`) to give immediate context.
  - **Price & Shelf Location:** Optional price display (if provided by the merchant) and physical shelf location badge (visible in Kiosk mode).

---

## 8. Data Architecture, Entities & Relationships
The database is hosted on Supabase (PostgreSQL) and consists of 8 core entities. All localized text fields are stored as structured JSON objects (`{"ar": "...", "fr": "...", "en": "..."}`).

### 8.1. `store_settings` (Single-Row Configuration Entity)
Stores global branding and store metadata.
- **Fields:**
  - `id` (Unique Identifier, Primary Key)
  - `store_name` (Localized JSON Object - AR, FR, EN)
  - `hero_title` (Localized JSON Object - AR, FR, EN)
  - `hero_subtitle` (Localized JSON Object - AR, FR, EN)
  - `logo_url` (Text String, optional URL to compressed WebP logo in storage)
  - `store_address` (Localized JSON Object - AR, FR, EN)
  - `operating_hours` (Localized JSON Object - AR, FR, EN)
  - `social_links` (JSON Object containing URLs for Instagram, TikTok, WhatsApp, Maps)
  - `default_locale` (Text String, default `'ar'`)
  - `kiosk_pin` (Text String, 4-digit PIN for Kiosk setup)
  - `updated_at` (Timestamp)

### 8.2. `tags` (Dynamic Characteristics Entity)
Stores all fragrance attributes created by the merchant or seeding script.
- **Fields:**
  - `id` (Unique Identifier, Primary Key)
  - `slug` (Unique Text String identifier, e.g., `gender_male`, `vibe_fresh`)
  - `category` (Text String grouping tags in the admin UI: `gender`, `vibe`, `occasion`, `season`, `intensity`, `notes`)
  - `label` (Localized JSON Object - AR, FR, EN, displayed on result cards and in the Admin Dashboard)
  - `created_at` (Timestamp)

### 8.3. `perfumes` (Product Inventory Entity — Strictly Image-Free)
Stores the perfume catalog. Contains NO image fields.
- **Fields:**
  - `id` (Unique Identifier, Primary Key)
  - `name` (Text String, mandatory — strictly English/Latin perfume name)
  - `brand` (Text String, optional — English/Latin brand name)
  - `description` (Localized JSON Object - AR, FR, EN sensory description)
  - `price` (Decimal Number, optional display price)
  - `shelf_location` (Text String, optional physical location inside the store for Kiosk mode)
  - `is_available` (Boolean, default `true` — controls instant stock visibility)
  - `is_featured` (Boolean, default `false` — used as tie-breaker in scoring)
  - `is_draft` (Boolean, default `false` — marks auto-imported perfumes that still require merchant tag/description review)
  - `created_at` (Timestamp)

### 8.4. `perfume_tags` (Perfume-to-Tag Junction Entity)
Establishes a **Many-to-Many relationship** between `perfumes` and `tags`.
- **Fields & Relationships:**
  - `perfume_id` (Foreign Key referencing `perfumes.id`, cascades on delete)
  - `tag_id` (Foreign Key referencing `tags.id`, cascades on delete)
  - Composite Primary Key on (`perfume_id`, `tag_id`) to prevent duplicate tag assignments to the same perfume.

### 8.5. `questions` (Dynamic Quiz Questions Entity)
Stores the customizable questions in the quiz bank.
- **Fields:**
  - `id` (Unique Identifier, Primary Key)
  - `step_order` (Integer — determines the exact sequence in which questions appear)
  - `is_active` (Boolean, default `true` — allows enabling/disabling questions without deleting them)
  - `question_text` (Localized JSON Object - AR, FR, EN)
  - `helper_text` (Localized JSON Object - AR, FR, EN, optional sub-prompt)
  - `created_at` (Timestamp)

### 8.6. `answers` (Dynamic Quiz Answers Entity)
Stores the selectable options belonging to a specific question.
- **Fields & Relationships:**
  - `id` (Unique Identifier, Primary Key)
  - `question_id` (Foreign Key referencing `questions.id`, cascades on delete — establishes a **One-to-Many relationship** from Question to Answers)
  - `sort_order` (Integer — controls the display order of cards within the question)
  - `title` (Localized JSON Object - AR, FR, EN main answer text)
  - `subtitle_explanation` (Localized JSON Object - AR, FR, EN short explanation helping the customer choose)
  - `image_url` (Text String — URL to the illustrative WebP image stored in Supabase Storage)
  - `is_hard_filter` (Boolean, default `false` — designates whether selecting this answer acts as a Stage 1 strict eliminator)
  - `created_at` (Timestamp)

### 8.7. `answer_tag_weights` (Answer-to-Tag Scoring Junction Entity)
Establishes a **Many-to-Many weighted relationship** between `answers` and `tags`. This is the core bridge connecting quiz answers to perfume attributes.
- **Fields & Relationships:**
  - `id` (Unique Identifier, Primary Key)
  - `answer_id` (Foreign Key referencing `answers.id`, cascades on delete)
  - `tag_id` (Foreign Key referencing `tags.id`, cascades on delete)
  - `weight_points` (Integer, default `10` — the exact points awarded to any perfume possessing `tag_id` when the user selects `answer_id`)
  - Unique constraint on (`answer_id`, `tag_id`) so an answer cannot assign two conflicting weights to the same tag.

### 8.8. `analytics_logs` (Usage Tracking Entity)
Records completed or early-exited quiz sessions for merchant insights.
- **Fields & Relationships:**
  - `id` (Unique Identifier, Primary Key)
  - `mode` (Text String: `'web'` or `'kiosk'`)
  - `answered_count` (Integer — number of questions answered before viewing results)
  - `top_perfume_id` (Foreign Key referencing `perfumes.id`, sets null on delete)
  - `selected_answer_ids` (Array of Answer UUIDs selected during the session)
  - `created_at` (Timestamp)

### 8.9. Database Security & Row Level Security (RLS) Rules
- **Anonymous Public Users (`anon` role - Web & Kiosk):**
  - Read-only (`SELECT`) access to `store_settings`, `tags`, `perfume_tags`, `answers`, and `answer_tag_weights`.
  - Filtered Read-only (`SELECT`) access to `perfumes` (restricted strictly to records where `is_available = true` AND `is_draft = false`).
  - Filtered Read-only (`SELECT`) access to `questions` (restricted strictly to records where `is_active = true`).
  - Write-only (`INSERT`) access exclusively on `analytics_logs`. Zero update or delete permissions anywhere.
- **Authenticated Merchant Admin (`authenticated` role):**
  - Full unrestricted CRUD (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) permissions across all 8 database entities and the Supabase Storage bucket for Answer/Logo images.

---

## 9. Custom Merchant Admin Dashboard Specifications (`/[locale]/admin`)
Built entirely from scratch in Next.js and protected via Supabase Auth middleware.

### 9.1. Dynamic Tags Manager (`/admin/tags`)
- Full CRUD interface allowing the merchant to create, edit, and delete tags.
- Merchant assigns each tag to a logical category (`gender`, `vibe`, `occasion`, `season`, `intensity`, `notes`) and provides its localized label in Arabic, French, and English.

### 9.2. Perfumes Inventory Manager (`/admin/perfumes`)
- **Inventory Table:** Displays all perfumes with instant search by English name/brand, filter by status (`Active`, `Out of Stock`, `Draft / Needs Review`), and a **1-Click Availability Toggle Switch (`is_available`)** directly in the table row.
- **Add / Edit Perfume Form (No Image Upload):**
  - Inputs for English Name (mandatory), Brand, Optional Price, and Kiosk Shelf Location.
  - Three language tabs (`AR`, `FR`, `EN`) for writing or editing the perfume's sensory description.
  - **Interactive Tag Selector:** Displays all existing system tags grouped by category as clickable **Multi-Select Chips/Badges**. The merchant simply clicks the badges that apply to the perfume (e.g., clicking `Men`, `Winter`, `Woody`, `Strong`), which updates the `perfume_tags` relationships. Free-text tag typing is disabled to prevent typos.

### 9.3. Dynamic Quiz Builder (`/admin/quiz-builder`)
- **Questions Management:**
  - Create, edit, and delete questions with 3-language text inputs.
  - Toggle `is_active` to hide or show questions in the live quiz.
  - Reorder questions (`step_order`) via drag-and-drop or up/down controls to prioritize high-impact questions first.
- **Answers & Weight Mapping Interface:**
  - Inside any question, the merchant can add, edit, reorder, or delete answer choices.
  - Each answer form includes: 3-language Title, 3-language Subtitle Explanation, an `is_hard_filter` toggle checkbox, and an **Illustrative Image Uploader**.
  - **Client-Side WebP Compression:** When the merchant selects an image for an answer (or store logo), the browser automatically compresses and converts the file to `.webp` (max `800x800px`, under `150KB`) before uploading it to Supabase Storage.
  - **Answer Impact (Tag Weight Assigner):** A dedicated section within each answer editor containing a multi-select dropdown of all system `tags`. For every tag selected, the merchant inputs the numeric `weight_points` (e.g., linking the answer *"Fresh & Citrusy"* to `tag: citrus` with `+30 points` and `tag: summer` with `+15 points`). Saving updates the `answer_tag_weights` entity directly.

### 9.4. Store Settings & Analytics Overview (`/admin/settings` & `/admin`)
- **Settings:** Update Store Name, Hero Headlines, Store Address, Operating Hours, Social Links, Kiosk PIN, and Store Logo.
- **Analytics Dashboard:** Displays total completed quiz sessions (broken down by Web vs. Kiosk), average number of questions answered before clicking "Show Results", Top 5 most recommended perfumes, and the most frequently matched customer preference tags.

---

## 10. Automated Data Seeding & AI Tagging Pipeline
To ensure the platform is never delivered empty to a merchant (solving the Cold Start problem), the repository includes an automated CLI ingestion script (`src/scripts/seed-kaggle.ts`):
1. **Source Extraction:** Reads a curated CSV dataset (from Kaggle) of the top 200 most popular global perfumes containing their English Name, Brand, target Gender, and Olfactive Notes/Accords.
2. **Predefined Base Tags & Questions:** Seeds an initial set of foundational tags (across gender, vibe, occasion, season, intensity, and notes) and a default set of 10–12 localized questions so the system works out of the box.
3. **AI Description & Tag Mapping:** Processes the 200 perfumes in batches via an LLM API:
   - Preserves the original English `name` and `brand`.
   - Generates persuasive, concise sensory descriptions in Arabic (`ar`), French (`fr`), and English (`en`).
   - Analyzes the perfume's accords/notes from the CSV and automatically maps each perfume to the appropriate existing `tag_id`s in the database.
4. **Database Injection & Draft Flagging:** Inserts the records into `perfumes` and `perfume_tags`. Any perfume that fails to map to at least 2 descriptive tags is automatically flagged with `is_draft = true`, displaying a visual `"Needs Review"` badge in the Admin Dashboard for the merchant to verify.