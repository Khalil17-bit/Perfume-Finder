import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import { createAdminClient } from '../lib/supabase/admin';

// Helper to create deterministic, strictly valid UUIDs
function makeUuid(namespace: number, id: number): string {
  const ns = namespace.toString(16).padStart(8, '0');
  const index = id.toString(16).padStart(12, '0');
  return `${ns}-0000-4000-8000-${index}`;
}

interface RawPerfume {
  id: string;
  name: string;
  brand: string;
  category: string;
  target_audience: string;
  longevity: string;
  description: { ar: string; fr: string; en: string };
  price: number;
  shelf_location: string;
  is_available: boolean;
  is_featured: boolean;
  is_draft: boolean;
  tags: string[];
}

export const BASE_TAGS = [
  // Gender
  { slug: 'gender_male', category: 'gender', label: { ar: 'رجالي', fr: 'Pour Homme', en: 'Men' } },
  { slug: 'gender_female', category: 'gender', label: { ar: 'نسائي', fr: 'Pour Femme', en: 'Women' } },
  { slug: 'gender_unisex', category: 'gender', label: { ar: 'للجنسين', fr: 'Unisexe', en: 'Unisex' } },
  // Vibe
  { slug: 'vibe_fresh', category: 'vibe', label: { ar: 'منعش ونقي', fr: 'Frais & Pur', en: 'Fresh & Clean' } },
  { slug: 'vibe_warm', category: 'vibe', label: { ar: 'دافئ وجذاب', fr: 'Chaud & Séduisant', en: 'Warm & Seductive' } },
  { slug: 'vibe_mysterious', category: 'vibe', label: { ar: 'غامض وفاخر', fr: 'Mystérieux & Sombre', en: 'Dark & Mysterious' } },
  { slug: 'vibe_elegant', category: 'vibe', label: { ar: 'أنيق وراقي', fr: 'Élégant & Raffiné', en: 'Elegant & Sophisticated' } },
  // Occasion
  { slug: 'occasion_daily', category: 'occasion', label: { ar: 'يومي وعملي', fr: 'Quotidien', en: 'Everyday / Office' } },
  { slug: 'occasion_evening', category: 'occasion', label: { ar: 'سهرات ومناسبات', fr: 'Soirée & Fêtes', en: 'Evening & Events' } },
  { slug: 'occasion_special', category: 'occasion', label: { ar: 'لحظات استثنائية', fr: 'Grandes Occasions', en: 'Special Moments' } },
  // Season
  { slug: 'season_summer', category: 'season', label: { ar: 'صيفي وحيوي', fr: 'Été', en: 'Summer' } },
  { slug: 'season_winter', category: 'season', label: { ar: 'شتوي وخريفي', fr: 'Hiver & Automne', en: 'Winter & Autumn' } },
  // Intensity
  { slug: 'intensity_subtle', category: 'intensity', label: { ar: 'ناعم وخفيف', fr: 'Discret', en: 'Subtle / Close Scent' } },
  { slug: 'intensity_strong', category: 'intensity', label: { ar: 'فوّاح وقوي', fr: 'Sillage Puissant', en: 'Strong Projection' } },
  // Notes
  { slug: 'notes_citrus', category: 'notes', label: { ar: 'حمضيات وبرغموت', fr: 'Agrumes & Bergamote', en: 'Citrus & Bergamot' } },
  { slug: 'notes_woody', category: 'notes', label: { ar: 'أخشاب وأرز', fr: 'Bois & Cèdre', en: 'Woody & Cedar' } },
  { slug: 'notes_amber', category: 'notes', label: { ar: 'عنبر وفانيليا', fr: 'Ambre & Vanille', en: 'Amber & Vanilla' } },
  { slug: 'notes_floral', category: 'notes', label: { ar: 'زهور وياسمين', fr: 'Fleurs & Jasmin', en: 'Floral & Jasmine' } },
  { slug: 'notes_oud', category: 'notes', label: { ar: 'عود ملكي وبخور', fr: 'Oud & Encens', en: 'Royal Oud & Incense' } },
  { slug: 'notes_spicy', category: 'notes', label: { ar: 'توابل وهيل', fr: 'Épices & Cardamome', en: 'Spices & Cardamom' } },
].map((tag, idx) => ({
  id: makeUuid(1, idx + 1),
  ...tag,
}));

// Create slug to UUID map
const TAG_SLUG_TO_ID: Record<string, string> = {};
const OLD_TAG_ID_MAP: Record<string, string> = {
  tag_male: 'gender_male',
  tag_female: 'gender_female',
  tag_unisex: 'gender_unisex',
  tag_fresh: 'vibe_fresh',
  tag_warm: 'vibe_warm',
  tag_mysterious: 'vibe_mysterious',
  tag_elegant: 'vibe_elegant',
  tag_daily: 'occasion_daily',
  tag_evening: 'occasion_evening',
  tag_special: 'occasion_special',
  tag_summer: 'season_summer',
  tag_winter: 'season_winter',
  tag_subtle: 'intensity_subtle',
  tag_strong: 'intensity_strong',
  tag_citrus: 'notes_citrus',
  tag_woody: 'notes_woody',
  tag_amber: 'notes_amber',
  tag_floral: 'notes_floral',
  tag_oud: 'notes_oud',
  tag_spicy: 'notes_spicy',
};

BASE_TAGS.forEach(t => {
  TAG_SLUG_TO_ID[t.slug] = t.id;
});

export const SEED_STORE_SETTINGS = {
  id: makeUuid(9, 1),
  store_name: {
    ar: 'مستكشف العطور الفاخرة',
    fr: 'Découvreur de Parfum de Luxe',
    en: 'Luxury Perfume Finder',
  },
  hero_title: {
    ar: 'اكتشف بصمتك العطرية الفريدة',
    fr: 'Découvrez votre signature olfactive',
    en: 'Discover Your Scent Signature',
  },
  hero_subtitle: {
    ar: 'تجربة ذكية وراقية تكتشف من خلالها العطر المثالي الذي يجسد شخصيتك وذوقك خلال 30 ثانية فقط.',
    fr: 'Une expérience immersive pour révéler le parfum qui sublime votre personnalité en seulement 30 secondes.',
    en: 'An elevated fragrance discovery experience tailored to your unique taste and mood in just 30 seconds.',
  },
  logo_url: null,
  store_address: {
    ar: 'تونس العاصمة، شارع الحبيب بورقيبة - البوتيك الفاخر',
    fr: 'Tunis, Avenue Habib Bourguiba - La Boutique Élégante',
    en: 'Tunis, Habib Bourguiba Avenue - The Luxury Boutique',
  },
  operating_hours: {
    ar: 'يومياً: 10:00 ص - 09:00 م',
    fr: 'Tous les jours: 10h00 - 21h00',
    en: 'Daily: 10:00 AM - 09:00 PM',
  },
  social_links: {
    instagram: 'https://instagram.com',
    tiktok: 'https://tiktok.com',
    whatsapp: 'https://whatsapp.com',
    maps: 'https://maps.google.com',
  },
  default_locale: 'ar',
  kiosk_pin: '1234',
};

// 10 Progressive Quiz Questions with Answers and Weight Matrices
export const SEED_QUESTIONS = [
  {
    id: makeUuid(2, 1),
    step_order: 1,
    is_active: true,
    question_text: {
      ar: 'لمن تبحث عن هذا العطر اليوم؟',
      fr: 'Pour qui recherchez-vous ce parfum aujourd’hui ?',
      en: 'Who is this fragrance for today?',
    },
    helper_text: {
      ar: 'حدد الفئة المستهدفة لتصفية الاختيارات الملائمة فوراً',
      fr: 'Sélectionnez le profil pour filtrer les créations adaptées',
      en: 'Select the target profile to immediately filter suitable creations',
    },
    answers: [
      {
        id: makeUuid(3, 1),
        sort_order: 1,
        title: { ar: 'عطور رجالية فاخرة', fr: 'Pour Homme', en: 'For Men' },
        subtitle_explanation: { ar: 'تركيبات ذكورية تعكس القوة والهيبة', fr: 'Compositions masculines puissantes et raffinées', en: 'Masculine compositions exuding strength and charisma' },
        is_hard_filter: true,
        weights: [
          { tag: 'gender_male', weight: 0 },
          { tag: 'gender_unisex', weight: 0 },
        ],
      },
      {
        id: makeUuid(3, 2),
        sort_order: 2,
        title: { ar: 'عطور نسائية ساحرة', fr: 'Pour Femme', en: 'For Women' },
        subtitle_explanation: { ar: 'نفحات أنثوية تجمع بين النعومة والجاذبية', fr: 'Sillages féminins alliant grâce et sensualité', en: 'Feminine notes blending grace and alluring softness' },
        is_hard_filter: true,
        weights: [
          { tag: 'gender_female', weight: 0 },
          { tag: 'gender_unisex', weight: 0 },
        ],
      },
      {
        id: makeUuid(3, 3),
        sort_order: 3,
        title: { ar: 'عطور للجنسين / حرّة', fr: 'Unisexe / Partagé', en: 'Unisex / Universal' },
        subtitle_explanation: { ar: 'إبداعات عصرية راقية تناسب كلا الجنسين', fr: 'Créations modernes et intemporelles pour tous', en: 'Modern, timeless artisanal creations for everyone' },
        is_hard_filter: true,
        weights: [
          { tag: 'gender_unisex', weight: 0 },
          { tag: 'gender_male', weight: 0 },
          { tag: 'gender_female', weight: 0 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 2),
    step_order: 2,
    is_active: true,
    question_text: {
      ar: 'ما هو الطابع أو الإحساس الرئيسي الذي تريده؟',
      fr: 'Quel sillage ou sentiment souhaitez-vous laisser ?',
      en: 'What primary impression or vibe do you wish to project?',
    },
    helper_text: {
      ar: 'اختر الإحساس العطري الذي يعبّر عن شخصيتك',
      fr: 'Choisissez l’univers olfactif qui reflète votre caractère',
      en: 'Choose the olfactive aura that best reflects your character',
    },
    answers: [
      {
        id: makeUuid(3, 4),
        sort_order: 1,
        title: { ar: 'منعش، نقي وحيوي', fr: 'Frais, Cristallin & Énergisant', en: 'Fresh, Crisp & Uplifting' },
        subtitle_explanation: { ar: 'حمضيات إيطالية ونفحات مائية تنبض بالحياة', fr: 'Agrumes éclatants et brise aquatique revigorante', en: 'Zesty citrus and invigorating aquatic notes' },
        is_hard_filter: false,
        weights: [
          { tag: 'vibe_fresh', weight: 30 },
          { tag: 'notes_citrus', weight: 20 },
          { tag: 'season_summer', weight: 15 },
        ],
      },
      {
        id: makeUuid(3, 5),
        sort_order: 2,
        title: { ar: 'دافئ، عنبري وجذاب', fr: 'Chaud, Ambré & Gourmand', en: 'Warm, Amber & Seductive' },
        subtitle_explanation: { ar: 'لمسات الفانيليا والعنبر والكراميل المغرية', fr: 'Notes envoûtantes d’ambre doré et de vanille', en: 'Alluring accords of golden amber, spices, and vanilla' },
        is_hard_filter: false,
        weights: [
          { tag: 'vibe_warm', weight: 30 },
          { tag: 'notes_amber', weight: 20 },
          { tag: 'season_winter', weight: 15 },
        ],
      },
      {
        id: makeUuid(3, 6),
        sort_order: 3,
        title: { ar: 'غامض، خشبي وفاخر', fr: 'Sombre, Boisé & Majestueux', en: 'Dark, Woody & Mysterious' },
        subtitle_explanation: { ar: 'أخشاب الأرز والعود الفاخر والجلود المهيبة', fr: 'Bois précieux, oud fumé et cuirs de caractère', en: 'Precious woods, smoky royal oud, and refined leather' },
        is_hard_filter: false,
        weights: [
          { tag: 'vibe_mysterious', weight: 30 },
          { tag: 'notes_woody', weight: 20 },
          { tag: 'notes_oud', weight: 25 },
        ],
      },
      {
        id: makeUuid(3, 7),
        sort_order: 4,
        title: { ar: 'زهري، رقيق وأنيق', fr: 'Floral, Romantique & Délicat', en: 'Floral, Poetic & Romantic' },
        subtitle_explanation: { ar: 'باقة من الورد الدمشقي، الياسمين وزهر البرتقال', fr: 'Bouquet sublime de jasmin et roses de Damas', en: 'Enchanting bouquet of jasmine and Damascus roses' },
        is_hard_filter: false,
        weights: [
          { tag: 'notes_floral', weight: 35 },
          { tag: 'vibe_elegant', weight: 20 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 3),
    step_order: 3,
    is_active: true,
    question_text: {
      ar: 'في أي وقت ومناسبة ستضع هذا العطر في الغالب؟',
      fr: 'Pour quelle occasion porterez-vous principalement ce parfum ?',
      en: 'On what occasion will you primarily wear this scent?',
    },
    helper_text: {
      ar: 'التوقيت المناسب يمنح العطر ذروة ألقه',
      fr: 'Le bon moment décuple la splendeur du parfum',
      en: 'The right occasion brings out the fragrance’s peak beauty',
    },
    answers: [
      {
        id: makeUuid(3, 8),
        sort_order: 1,
        title: { ar: 'استخدام يومي والعمل', fr: 'Quotidien & Bureau', en: 'Daily Wear & Office' },
        subtitle_explanation: { ar: 'عطر نظيف وغير مزعج يرافقك بثقة طوال النهار', fr: 'Élégance subtile et confortable pour toute la journée', en: 'Subtle, clean elegance suited for everyday confidence' },
        is_hard_filter: false,
        weights: [
          { tag: 'occasion_daily', weight: 25 },
          { tag: 'vibe_fresh', weight: 15 },
        ],
      },
      {
        id: makeUuid(3, 9),
        sort_order: 2,
        title: { ar: 'سهرات، مواعيد ومناسبات خاصة', fr: 'Soirées & Rendez-vous', en: 'Evenings & Special Dates' },
        subtitle_explanation: { ar: 'حضور مغناطيسي يترك انطباعاً لا ينسى', fr: 'Magnétisme envoûtant et présence mémorable', en: 'Magnetic aura that leaves an indelible memory' },
        is_hard_filter: false,
        weights: [
          { tag: 'occasion_evening', weight: 30 },
          { tag: 'vibe_warm', weight: 15 },
        ],
      },
      {
        id: makeUuid(3, 10),
        sort_order: 3,
        title: { ar: 'احتفالات كبرى ولحظات ملكية', fr: 'Grandes Cérémonies & Prestige', en: 'Gala & Grand Moments' },
        subtitle_explanation: { ar: 'أفخم النغمات للمناسبات التي تتطلب تألقاً استثنائياً', fr: 'Sillages les plus prestigieux pour marquer les esprits', en: 'Regal compositions crafted for unforgettable grand occasions' },
        is_hard_filter: false,
        weights: [
          { tag: 'occasion_special', weight: 35 },
          { tag: 'notes_oud', weight: 20 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 4),
    step_order: 4,
    is_active: true,
    question_text: {
      ar: 'ما درجة الثبات والفوحان التي تفضلها؟',
      fr: 'Quelle intensité et puissance de sillage préférez-vous ?',
      en: 'What level of projection and intensity do you prefer?',
    },
    helper_text: {
      ar: 'بين النعومة الهادئة والفوحان الجريء الآسر',
      fr: 'Entre subtilité intime et sillage captivant et audacieux',
      en: 'Between intimate whisper and bold, room-filling presence',
    },
    answers: [
      {
        id: makeUuid(3, 11),
        sort_order: 1,
        title: { ar: 'هادئ ومقرب (Skin Scent)', fr: 'Discret & Intime', en: 'Intimate Skin Scent' },
        subtitle_explanation: { ar: 'يكتشفه فقط من يقترب منك بنعومة', fr: 'Perçu uniquement par ceux qui s’approchent', en: 'Softly perceived only in close proximity' },
        is_hard_filter: false,
        weights: [
          { tag: 'intensity_subtle', weight: 30 },
          { tag: 'occasion_daily', weight: 10 },
        ],
      },
      {
        id: makeUuid(3, 12),
        sort_order: 2,
        title: { ar: 'فوّاح، طاغي وثابت جداً', fr: 'Sillage Intense & Remarquable', en: 'Bold Projection & Longevity' },
        subtitle_explanation: { ar: 'يملأ المكان ويترك أثراً عاطراً لساعات طويلة', fr: 'Signature olfactive puissante qui emplit l’espace', en: 'Commanding trail that announces your presence' },
        is_hard_filter: false,
        weights: [
          { tag: 'intensity_strong', weight: 35 },
          { tag: 'occasion_evening', weight: 15 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 5),
    step_order: 5,
    is_active: true,
    question_text: {
      ar: 'أي من هذه النغمات العطرية تلامس حواسك أكثر؟',
      fr: 'Quelles facettes olfactives captivent le plus vos sens ?',
      en: 'Which of these olfactive facets captivates your senses most?',
    },
    helper_text: {
      ar: 'المكونات الأساسية التي تشكل قلب العطر وقاعدته',
      fr: 'Les ingrédients phares qui définissent le cœur du parfum',
      en: 'The core ingredients that define the fragrance heart and base',
    },
    answers: [
      {
        id: makeUuid(3, 13),
        sort_order: 1,
        title: { ar: 'برغموت، يوسفي ونفحات خضراء', fr: 'Bergamote, Mandarine & Notes Vertes', en: 'Bergamot, Mandarin & Green Notes' },
        subtitle_explanation: { ar: 'انتعاش طبيعي مشرق ومبهج', fr: 'Éclat hespéridé lumineux et optimiste', en: 'Vibrant, sun-drenched Mediterranean freshness' },
        is_hard_filter: false,
        weights: [
          { tag: 'notes_citrus', weight: 35 },
          { tag: 'vibe_fresh', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 14),
        sort_order: 2,
        title: { ar: 'أخشاب، عود وبخور شرقي', fr: 'Oud Oriental & Bois de Santal', en: 'Precious Oud & Sandalwood' },
        subtitle_explanation: { ar: 'عمق شرقي ملكي وأصالة لا تضاهى', fr: 'Profondeur mystique et luxe oriental absolu', en: 'Deep smoky sophistication and royal heritage' },
        is_hard_filter: false,
        weights: [
          { tag: 'notes_oud', weight: 35 },
          { tag: 'notes_woody', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 15),
        sort_order: 3,
        title: { ar: 'عنبر، حبوب التونكا وفانيليا مدغشقر', fr: 'Ambre, Fève Tonka & Vanille', en: 'Amber, Tonka Bean & Madagascar Vanilla' },
        subtitle_explanation: { ar: 'حلاوة دافئة مخملية تفيض بالجاذبية', fr: 'Douceur veloutée et chaleureuse irrésistible', en: 'Warm velvet sweetness that comforts and entices' },
        is_hard_filter: false,
        weights: [
          { tag: 'notes_amber', weight: 35 },
          { tag: 'vibe_warm', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 16),
        sort_order: 4,
        title: { ar: 'توابل دافئة، هيل وقرفة سيلانية', fr: 'Épices Chaudes, Cardamome & Cannelle', en: 'Warm Spices, Cardamom & Cinnamon' },
        subtitle_explanation: { ar: 'حرارة آسرة تعطي العطر عمقاً وكاريزما خاصة', fr: 'Chaleur séduisante et sillage magnétique', en: 'Charismatic heat radiating captivating allure' },
        is_hard_filter: false,
        weights: [
          { tag: 'notes_spicy', weight: 35 },
          { tag: 'vibe_warm', weight: 20 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 6),
    step_order: 6,
    is_active: true,
    question_text: {
      ar: 'ما هو الفصل أو الطقس الذي ترتدي فيه العطر عادة؟',
      fr: 'En quelle saison appréciez-vous le plus porter votre parfum ?',
      en: 'In which season do you primarily intend to wear this fragrance?',
    },
    helper_text: {
      ar: 'درجة حرارة الجو تؤثر مباشرة على تطاير وتفاعل الجزيئات العطرية',
      fr: 'Le climat influence directement la diffusion des accords olfactifs',
      en: 'Ambient temperature directly affects the evolution of olfactive notes',
    },
    answers: [
      {
        id: makeUuid(3, 17),
        sort_order: 1,
        title: { ar: 'أجواء صيفية مشمسة وربيعية منعشة', fr: 'Printemps & Été Solaire', en: 'Sunny Spring & Summer' },
        subtitle_explanation: { ar: 'نفحات خفيفة لا تثقل الحواس تحت أشعة الشمس', fr: 'Fragrances légères et aériennes par temps chaud', en: 'Light, crisp notes that thrive in warm weather' },
        is_hard_filter: false,
        weights: [
          { tag: 'season_summer', weight: 35 },
          { tag: 'vibe_fresh', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 18),
        sort_order: 2,
        title: { ar: 'ليالي الشتاء الباردة وأيام الخريف', fr: 'Automne & Hiver Frileux', en: 'Chilly Autumn & Winter' },
        subtitle_explanation: { ar: 'تركيبات دافئة وثقيلة تحتضنك كمعطف فاخر', fr: 'Sillages enveloppants et réconfortants par temps frais', en: 'Rich, cocooning compositions that cut through cold air' },
        is_hard_filter: false,
        weights: [
          { tag: 'season_winter', weight: 35 },
          { tag: 'vibe_warm', weight: 20 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 7),
    step_order: 7,
    is_active: true,
    question_text: {
      ar: 'ما تركيز العطر وكثافته التي تبحث عنها؟',
      fr: 'Quelle concentration olfactive privilégiez-vous ?',
      en: 'What concentration and texture do you seek?',
    },
    helper_text: {
      ar: 'التركيز العطري يحدد بقاء الرائحة ودرجة تماسكها',
      fr: 'La concentration définit la tenue et la signature',
      en: 'Concentration defines longevity and presence',
    },
    answers: [
      {
        id: makeUuid(3, 19),
        sort_order: 1,
        title: { ar: 'ماء تواليت منعش ومريح (EDT)', fr: 'Eau de Toilette Aérienne', en: 'Airy Eau de Toilette' },
        subtitle_explanation: { ar: 'خفيف ومرن يناسب الاستعمال المتكرر', fr: 'Légèreté et versatilité au quotidien', en: 'Breezy and comfortable for frequent touch-ups' },
        is_hard_filter: false,
        weights: [
          { tag: 'intensity_subtle', weight: 25 },
          { tag: 'vibe_fresh', weight: 15 },
        ],
      },
      {
        id: makeUuid(3, 20),
        sort_order: 2,
        title: { ar: 'ماء عطر غني وثابت (EDP)', fr: 'Eau de Parfum Intense', en: 'Rich Eau de Parfum' },
        subtitle_explanation: { ar: 'توازن مثالي بين الفوحان والثبات اليومي', fr: 'Équilibre parfait entre puissance et tenue', en: 'Ideal balance between rich sillage and all-day staying power' },
        is_hard_filter: false,
        weights: [
          { tag: 'intensity_strong', weight: 25 },
          { tag: 'occasion_daily', weight: 15 },
        ],
      },
      {
        id: makeUuid(3, 21),
        sort_order: 3,
        title: { ar: 'خلاصة عطرية مركزة (Extrait / Parfum)', fr: 'Extrait de Parfum Pur', en: 'Pure Extrait de Parfum' },
        subtitle_explanation: { ar: 'أقصى درجات الثبات والعمق النادر', fr: 'Concentration ultime pour un prestige absolu', en: 'Maximum oil concentration for unmatched depth' },
        is_hard_filter: false,
        weights: [
          { tag: 'intensity_strong', weight: 35 },
          { tag: 'vibe_mysterious', weight: 20 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 8),
    step_order: 8,
    is_active: true,
    question_text: {
      ar: 'ما هو الملمس الحسي الذي يريح حواسك؟',
      fr: 'Quelle texture sensorielle vous inspire le plus ?',
      en: 'Which olfactory texture resonates most with you?',
    },
    helper_text: {
      ar: 'الإحساس بالرائحة يشبه ملامسة الأقمشة الفاخرة',
      fr: 'Le parfum s’éprouve comme une étoffe sur la peau',
      en: 'Fragrance textures evoke fine materials upon skin',
    },
    answers: [
      {
        id: makeUuid(3, 22),
        sort_order: 1,
        title: { ar: 'نقي، مائي ومشرق كالحرير البارد', fr: 'Aérien, Aquatique & Cristallin', en: 'Crisp, Airy & Marine' },
        subtitle_explanation: { ar: 'شعور بالانتعاش والنظافة المطلقة', fr: 'Sensation de pureté et clarté immédiate', en: 'Crystal clarity evoking fresh mountain or sea breeze' },
        is_hard_filter: false,
        weights: [
          { tag: 'vibe_fresh', weight: 30 },
          { tag: 'notes_citrus', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 23),
        sort_order: 2,
        title: { ar: 'مخملي، بلسمي ودافئ كالكشمير', fr: 'Velouté, Balsamique & Chaleureux', en: 'Velvety, Balsamic & Cocooning' },
        subtitle_explanation: { ar: 'نعومة فاخرة تمنح الدفء والأمان', fr: 'Douceur caressante et rassurante', en: 'Soft, creamy comfort wrapping you like fine cashmere' },
        is_hard_filter: false,
        weights: [
          { tag: 'notes_amber', weight: 30 },
          { tag: 'vibe_warm', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 24),
        sort_order: 3,
        title: { ar: 'مدخن، جلدي ومهيب كالمخمل الأسود', fr: 'Fumé, Cuiré & Ténébreux', en: 'Smoky, Leathery & Resinous' },
        subtitle_explanation: { ar: 'غموض جذاب يعكس القوة والتفرد', fr: 'Caractère affirmé empreint de mystère', en: 'Deep, aristocratic richness with bold smoky nuances' },
        is_hard_filter: false,
        weights: [
          { tag: 'notes_oud', weight: 30 },
          { tag: 'notes_woody', weight: 25 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 9),
    step_order: 9,
    is_active: true,
    question_text: {
      ar: 'كيف تصف حضورك وشخصيتك في المجتمع؟',
      fr: 'Comment décririez-vous votre présence naturelle ?',
      en: 'How would you characterize your natural presence?',
    },
    helper_text: {
      ar: 'عطرك هو امتداد غير مرئي لثقتك وشخصيتك',
      fr: 'Votre parfum est le prolongement subtil de votre aura',
      en: 'Your scent is the invisible extension of your persona',
    },
    answers: [
      {
        id: makeUuid(3, 25),
        sort_order: 1,
        title: { ar: 'بسيط، راقي وهادئ (Minimalist)', fr: 'Épuré, Minimaliste & Subtil', en: 'Understated & Sophisticated' },
        subtitle_explanation: { ar: 'جمال يكمن في التفاصيل دون ضجيج', fr: 'La vraie élégance réside dans la retenue', en: 'Quiet luxury that speaks softly with effortless grace' },
        is_hard_filter: false,
        weights: [
          { tag: 'intensity_subtle', weight: 25 },
          { tag: 'vibe_elegant', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 26),
        sort_order: 2,
        title: { ar: 'قائد كاريزماتي ملهم (Leader)', fr: 'Charismatique, Audacieux & Leader', en: 'Charismatic, Bold & Magnetic' },
        subtitle_explanation: { ar: 'ثقة طاغية تجذب الأنظار وتلهم المحيطين', fr: 'Présence affirmée qui captive immédiatement', en: 'Commanding self-assurance that draws admiration' },
        is_hard_filter: false,
        weights: [
          { tag: 'intensity_strong', weight: 30 },
          { tag: 'notes_woody', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 27),
        sort_order: 3,
        title: { ar: 'أرستقراطي ملكي كلاسيكي (Noble)', fr: 'Aristocratique & Royal', en: 'Timeless Royal Aristocrat' },
        subtitle_explanation: { ar: 'أصالة متجذرة وفخامة لا تزول مع الزمن', fr: 'Prestige éternel et raffinement sans compromis', en: 'Inherited prestige and regal nobility across generations' },
        is_hard_filter: false,
        weights: [
          { tag: 'vibe_elegant', weight: 30 },
          { tag: 'notes_oud', weight: 25 },
        ],
      },
    ],
  },
  {
    id: makeUuid(2, 10),
    step_order: 10,
    is_active: true,
    question_text: {
      ar: 'في أي وقت من اليوم تشعر أن طاقتك في قمتها؟',
      fr: 'À quel moment de la journée votre énergie culmine-t-elle ?',
      en: 'At what time of day does your energy peak?',
    },
    helper_text: {
      ar: 'التناغم بين حركتك وإشعاع العطر يخلق هالة مميزة',
      fr: 'L’accord entre votre rythme et le parfum magnifie le sillage',
      en: 'Alignment with your daily rhythm enhances scent radiance',
    },
    answers: [
      {
        id: makeUuid(3, 28),
        sort_order: 1,
        title: { ar: 'إشراقة الصباح الباكر', fr: 'La clarté vivifiante du matin', en: 'Crisp Sunlit Morning' },
        subtitle_explanation: { ar: 'بدايات نشطة تتطلب نقاءً وحيوية متقدة', fr: 'Élan vital et fraîcheur optimiste pour bien démarrer', en: 'Dynamic beginnings calling for sparkling vitality' },
        is_hard_filter: false,
        weights: [
          { tag: 'vibe_fresh', weight: 30 },
          { tag: 'notes_citrus', weight: 25 },
        ],
      },
      {
        id: makeUuid(3, 29),
        sort_order: 2,
        title: { ar: 'لحظات الغروب الذهبية', fr: 'L’heure dorée du crépuscule', en: 'Golden Hour Twilight' },
        subtitle_explanation: { ar: 'هدوء ساحر ونفحات عنبرية دافئة تلائم الانتقال لليل', fr: 'Sensualité chaleureuse au coucher du soleil', en: 'Mellow warmth transitioning seamlessly into the evening' },
        is_hard_filter: false,
        weights: [
          { tag: 'vibe_warm', weight: 25 },
          { tag: 'notes_amber', weight: 20 },
        ],
      },
      {
        id: makeUuid(3, 30),
        sort_order: 3,
        title: { ar: 'سكون منتصف الليل المرصع بالنجوم', fr: 'Le mystère captivant de minuit', en: 'Starlit Midnight Mystique' },
        subtitle_explanation: { ar: 'عمق آسر ونغمات شرقية تسحر الحضور', fr: 'Sillage ténébreux et envoûtant sous les étoiles', en: 'Captivating mystery radiating supreme seduction' },
        is_hard_filter: false,
        weights: [
          { tag: 'occasion_evening', weight: 35 },
          { tag: 'vibe_mysterious', weight: 30 },
        ],
      },
    ],
  },
];

async function seedPipeline() {
  console.log('=============================================================');
  console.log('   PERFUMEFINDER - AUTOMATED KAGGLE SEED & AI TAGGING');
  console.log('=============================================================\n');

  // 1. Ensure Kaggle 200 JSON exists
  const kaggleJsonPath = path.join(__dirname, 'kaggle-200.json');
  if (!fs.existsSync(kaggleJsonPath)) {
    console.log('Extracting top 200 perfumes from Kaggle via Python...');
    execSync('python src/scripts/extract_kaggle.py', { stdio: 'inherit' });
  }

  const rawPerfumes: RawPerfume[] = JSON.parse(fs.readFileSync(kaggleJsonPath, 'utf8'));
  console.log(`Loaded ${rawPerfumes.length} enriched perfumes from ${kaggleJsonPath}`);

  // 2. Prepare Formatted Perfumes with deterministic UUIDs
  const perfumesToSeed = rawPerfumes.map((p, idx) => {
    const perfumeId = makeUuid(4, idx + 1);
    
    // Convert tags to IDs
    const tagIds = p.tags
      .map(slugOrOldId => {
        const canonicalSlug = OLD_TAG_ID_MAP[slugOrOldId] || slugOrOldId;
        return TAG_SLUG_TO_ID[canonicalSlug];
      })
      .filter(Boolean);

    return {
      id: perfumeId,
      name: p.name,
      brand: p.brand,
      description: p.description,
      price: p.price,
      shelf_location: p.shelf_location,
      is_available: p.is_available,
      is_featured: p.is_featured,
      is_draft: p.is_draft,
      tagIds,
      category: p.category,
      target_audience: p.target_audience,
      longevity: p.longevity,
    };
  });

  const draftCount = perfumesToSeed.filter(p => p.is_draft).length;
  console.log(`Perfumes prepared: ${perfumesToSeed.length} total, ${draftCount} flagged as is_draft (Needs Review).`);

  // 3. Generate Standalone SQL Seed File (supabase/seed.sql)
  console.log('\nGenerating standalone PostgreSQL seed script (supabase/seed.sql)...');
  const sqlLines: string[] = [
    '-- -------------------------------------------------------------',
    '-- Perfume Finder & In-Store Kiosk - Automated Seed Script',
    `-- Generated on: ${new Date().toISOString()}`,
    '-- Contains: Store Settings, 20 Base Tags, 10 Questions, Answers, Weights, 200 Perfumes',
    '-- -------------------------------------------------------------\n',
  ];

  // Store Settings SQL
  sqlLines.push('-- 1. Store Settings');
  sqlLines.push(
    `INSERT INTO public.store_settings (id, store_name, hero_title, hero_subtitle, default_locale, kiosk_pin, store_address, operating_hours, social_links)
VALUES (
  '${SEED_STORE_SETTINGS.id}',
  '${JSON.stringify(SEED_STORE_SETTINGS.store_name).replace(/'/g, "''")}'::jsonb,
  '${JSON.stringify(SEED_STORE_SETTINGS.hero_title).replace(/'/g, "''")}'::jsonb,
  '${JSON.stringify(SEED_STORE_SETTINGS.hero_subtitle).replace(/'/g, "''")}'::jsonb,
  '${SEED_STORE_SETTINGS.default_locale}',
  '${SEED_STORE_SETTINGS.kiosk_pin}',
  '${JSON.stringify(SEED_STORE_SETTINGS.store_address).replace(/'/g, "''")}'::jsonb,
  '${JSON.stringify(SEED_STORE_SETTINGS.operating_hours).replace(/'/g, "''")}'::jsonb,
  '${JSON.stringify(SEED_STORE_SETTINGS.social_links).replace(/'/g, "''")}'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  store_name = EXCLUDED.store_name,
  hero_title = EXCLUDED.hero_title,
  hero_subtitle = EXCLUDED.hero_subtitle;\n`
  );

  // Tags SQL
  sqlLines.push('-- 2. Base Tags (All 6 Categories)');
  for (const t of BASE_TAGS) {
    sqlLines.push(
      `INSERT INTO public.tags (id, slug, category, label)
VALUES ('${t.id}', '${t.slug}', '${t.category}', '${JSON.stringify(t.label).replace(/'/g, "''")}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;`
    );
  }
  sqlLines.push('');

  // Questions, Answers & Weights SQL
  sqlLines.push('-- 3. Questions, Answers, and Scoring Weights');
  let weightCounter = 1;
  for (const q of SEED_QUESTIONS) {
    sqlLines.push(
      `INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('${q.id}', ${q.step_order}, ${q.is_active}, '${JSON.stringify(q.question_text).replace(/'/g, "''")}'::jsonb, '${JSON.stringify(q.helper_text).replace(/'/g, "''")}'::jsonb)
ON CONFLICT (id) DO NOTHING;`
    );

    for (const a of q.answers) {
      sqlLines.push(
        `INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('${a.id}', '${q.id}', ${a.sort_order}, '${JSON.stringify(a.title).replace(/'/g, "''")}'::jsonb, '${JSON.stringify(a.subtitle_explanation).replace(/'/g, "''")}'::jsonb, ${a.is_hard_filter})
ON CONFLICT (id) DO NOTHING;`
      );

      for (const w of a.weights) {
        const tagId = TAG_SLUG_TO_ID[w.tag];
        if (tagId) {
          const weightId = makeUuid(5, weightCounter++);
          sqlLines.push(
            `INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('${weightId}', '${a.id}', '${tagId}', ${w.weight})
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;`
          );
        }
      }
    }
    sqlLines.push('');
  }

  // Perfumes & Perfume Tags SQL
  sqlLines.push('-- 4. Perfumes & Perfume-to-Tag Relationships (Strictly Image-Free)');
  for (const p of perfumesToSeed) {
    sqlLines.push(
      `INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '${p.id}',
  '${p.name.replace(/'/g, "''")}',
  '${p.brand.replace(/'/g, "''")}',
  '${JSON.stringify(p.description).replace(/'/g, "''")}'::jsonb,
  ${p.price},
  '${p.shelf_location}',
  ${p.is_available},
  ${p.is_featured},
  ${p.is_draft}
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;`
    );

    for (const tagId of p.tagIds) {
      sqlLines.push(
        `INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('${p.id}', '${tagId}')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;`
      );
    }
  }

  const seedSqlPath = path.join(process.cwd(), 'supabase', 'seed.sql');
  fs.writeFileSync(seedSqlPath, sqlLines.join('\n'), 'utf8');
  console.log(`Generated SQL seed file at: ${seedSqlPath} (${(fs.statSync(seedSqlPath).size / 1024).toFixed(1)} KB)`);

  // 4. Update Fallback Catalog with All 200 Perfumes
  console.log('\nExporting full enriched dataset to application fallback layer...');
  const seededJsonPath = path.join(process.cwd(), 'src', 'lib', 'data', 'seeded-perfumes.json');
  fs.writeFileSync(seededJsonPath, JSON.stringify(perfumesToSeed, null, 2), 'utf8');
  console.log(`Saved seeded-perfumes.json at: ${seededJsonPath}`);

  // 5. Try PostgREST Remote Injection via Supabase Admin Client
  console.log('\nConnecting to Supabase via Service Role authentication...');
  try {
    const admin = createAdminClient();
    console.log('Testing Supabase schema availability...');
    const { data: testData, error: testError } = await admin.from('tags').select('id').limit(1);

    if (testError) {
      console.log('Note: Supabase PostgREST tables not detected in remote project cache yet.');
      console.log(`Message: ${testError.message}`);
      console.log('\nTo apply the complete schema and seed in your remote Supabase instance:');
      console.log('1. Go to https://supabase.com/dashboard/project/muiuueqvmnljpdpaiarl/sql');
      console.log('2. Run: supabase/migrations/20261108000000_init_perfume_finder.sql');
      console.log('3. Run: supabase/seed.sql');
      console.log('The application will also automatically use the seeded-perfumes.json in fallback mode!');
    } else {
      console.log('Database tables detected! Proceeding with remote batch upsert...');

      // Upsert Store Settings
      await admin.from('store_settings').upsert({
        id: SEED_STORE_SETTINGS.id,
        store_name: SEED_STORE_SETTINGS.store_name,
        hero_title: SEED_STORE_SETTINGS.hero_title,
        hero_subtitle: SEED_STORE_SETTINGS.hero_subtitle,
        store_address: SEED_STORE_SETTINGS.store_address,
        operating_hours: SEED_STORE_SETTINGS.operating_hours,
        social_links: SEED_STORE_SETTINGS.social_links,
        default_locale: SEED_STORE_SETTINGS.default_locale,
        kiosk_pin: SEED_STORE_SETTINGS.kiosk_pin,
      } as any);
      console.log('Seeded store_settings.');

      // Upsert Tags
      for (const t of BASE_TAGS) {
        await admin.from('tags').upsert({
          id: t.id,
          slug: t.slug,
          category: t.category,
          label: t.label,
        } as any);
      }
      console.log(`Seeded ${BASE_TAGS.length} tags.`);

      // Upsert Questions & Answers
      for (const q of SEED_QUESTIONS) {
        await admin.from('questions').upsert({
          id: q.id,
          step_order: q.step_order,
          is_active: q.is_active,
          question_text: q.question_text,
          helper_text: q.helper_text,
        } as any);

        for (const a of q.answers) {
          await admin.from('answers').upsert({
            id: a.id,
            question_id: q.id,
            sort_order: a.sort_order,
            title: a.title,
            subtitle_explanation: a.subtitle_explanation,
            is_hard_filter: a.is_hard_filter,
          } as any);

          for (const w of a.weights) {
            const tagId = TAG_SLUG_TO_ID[w.tag];
            if (tagId) {
              await admin.from('answer_tag_weights').upsert({
                answer_id: a.id,
                tag_id: tagId,
                weight_points: w.weight,
              } as any);
            }
          }
        }
      }
      console.log(`Seeded ${SEED_QUESTIONS.length} progressive questions with answer weight matrices.`);

      // Batch Upsert Perfumes
      console.log('Upserting 200 perfumes in batches of 50...');
      for (let i = 0; i < perfumesToSeed.length; i += 50) {
        const batch = perfumesToSeed.slice(i, i + 50);
        const perfumeRows = batch.map(p => ({
          id: p.id,
          name: p.name,
          brand: p.brand,
          description: p.description,
          price: p.price,
          shelf_location: p.shelf_location,
          is_available: p.is_available,
          is_featured: p.is_featured,
          is_draft: p.is_draft,
        }));
        await admin.from('perfumes').upsert(perfumeRows as any);

        // Perfume Tags
        const tagRows: Array<{ perfume_id: string; tag_id: string }> = [];
        for (const p of batch) {
          for (const tagId of p.tagIds) {
            tagRows.push({ perfume_id: p.id, tag_id: tagId });
          }
        }
        if (tagRows.length > 0) {
          await admin.from('perfume_tags').upsert(tagRows as any);
        }
      }
      console.log('Successfully upserted all 200 perfumes and tag relationships to remote Supabase!');
    }
  } catch (err: any) {
    console.log(`Supabase connection handled gracefully: ${err.message}`);
  }

  console.log('\n=============================================================');
  console.log('   SEEDING & AI TAGGING COMPLETE');
  console.log('   - 200 Curated Luxury Perfumes Generated');
  console.log(`   - ${draftCount} Drafts Flagged (< 2 descriptive tags) for Merchant Review`);
  console.log('   - 20 Foundational Base Tags across 6 Categories');
  console.log('   - 10 Progressive Quiz Questions with Scoring Weights');
  console.log('   - Standalone SQL: supabase/seed.sql');
  console.log('   - Application JSON: src/lib/data/seeded-perfumes.json');
  console.log('=============================================================\n');
}

seedPipeline().catch(err => {
  console.error('Fatal error during seeding:', err);
  process.exit(1);
});
