# Design System & UI Specifications: Perfume Finder

## 1. Global Design Tokens (Luxury & Minimalist Theme)
The UI must evoke a premium, luxury fragrance brand feeling.
- **Color Palette:**
  - **Background (Primary):** `#09090B` (Zinc-950) - Deep, rich dark mode for luxury contrast.
  - **Surface/Cards:** `#18181B` (Zinc-900) - Slightly lighter for depth.
  - **Primary Accent:** `#D4AF37` (Metallic Gold) or `#B45309` (Amber-700) - Used strictly for the main CTA buttons and progress bars.
  - **Text (Primary):** `#FAFAFA` (Zinc-50) for high readability.
  - **Text (Muted):** `#A1A1AA` (Zinc-400) for descriptions and secondary info.
- **Typography:**
  - Use a highly legible sans-serif font (e.g., `Inter` for LTR, `Tajawal` or `Cairo` for Arabic RTL).
  - Headings must be tracking-tight (slightly compressed) for a modern look.

## 2. Animation Constraints (Strict Performance Rules)
Animations must feel expensive and fluid, but MUST NOT cause Layout Shifts.
- **Allowed CSS Properties:** Animate ONLY `transform` (scale, translate) and `opacity`. 
- **Prohibited:** NEVER animate `height`, `width`, `margin`, `padding`, or `box-shadow` to ensure strict 60 FPS performance and avoid CPU bottlenecking.
- **Micro-interactions:**
  - **Page Load:** Gentle fade-in (`opacity: 0 -> 1` over 500ms).
  - **Buttons:** Scale down slightly on press (`active:scale-95`).
  - **Card Hover:** Subtle translate Y (`hover:-translate-y-1` over 200ms).

## 3. Landing Page UI (Customer Intro)
A strict Single-Purpose Landing Page. No navigation bar, no search bar.
- **Hero Section (Full Viewport Height - 100vh):**
  - **Background:** Subtle, darkened background image of a perfume bottle or abstract smoke (opacity 20%).
  - **Center Content:** 
    - Store Logo (Top center).
    - Massive, elegant Headline (`text-4xl` or `text-5xl`).
    - Sub-headline (`text-zinc-400`, `text-lg`, max-width 60%).
    - **Main CTA:** Large pill-shaped button ("Discover Your Scent"), glowing accent color, pulsing gently (`animate-pulse` limited to opacity).
- **Store Footer Info (Bottom of the page):**
  - Minimalist grid showing:
    - Physical Store Location (Icon + Text).
    - Operating Hours.
    - Social Media Links (Minimal SVG icons: Instagram, TikTok, WhatsApp).

## 4. Quiz Interface UI (The Engine)
Zero distractions. No header, no footer. Focus entirely on the question.
- **Top Bar (Progress & Exit):**
  - A thin accent-colored progress bar at the absolute top (`h-1`).
  - Back Button (Top Left/Right depending on RTL/LTR) + Dynamic Accuracy Indicator (e.g., "Confidence: 45%").
- **Question Area:**
  - Large centered question text.
- **Answers Grid:**
  - 1-column layout on mobile, 2-column on tablet/kiosk.
  - **Answer Cards:** Massive tap targets (min-height: `120px`). 
  - Each card contains:
    - A subtle background image or icon representing the vibe (opacity 40%).
    - Bold Title.
    - Muted, smaller Subtitle Explanation.
  - **Selection Effect:** When tapped, the card border turns accent-gold, scales down (`scale-95`), and auto-advances to the next question after a 300ms delay.
- **Early Exit Button:**
  - Fixed at the bottom of the screen (Sticky). Transparent/Ghost button style: "Skip & Show Results".

## 5. Results & Kiosk UI
- **Results Layout:**
  - Top: "Here are your matches" + Confetti/Fade-in effect.
  - **Top Match Card:** Spans full width. Shows huge perfume image, English Name, Localized description, and a shiny badge "95% Match".
  - **Secondary Matches:** Horizontal scrollable row (Carousel) or 2-column grid.
- **Kiosk Specifics:**
  - **Persistent Reset:** A large, highly visible "Start Over" button fixed at the top center.
  - **QR Code Handoff:** A dominant "Save to Phone" button on the Results page. Opens a full-screen Modal with a massive, high-contrast QR code (White background for QR to ensure fast scanning).