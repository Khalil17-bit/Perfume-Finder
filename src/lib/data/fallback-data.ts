import { Answer, AnswerTagWeight, Perfume, PerfumeTag, Question, StoreSettings, Tag } from '../supabase/types';
import seededPerfumesRaw from './seeded-perfumes.json';

export const FALLBACK_STORE_SETTINGS: StoreSettings = {
  id: '00000009-0000-4000-8000-000000000001',
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
  updated_at: new Date().toISOString(),
};

// 20 Canonical Base Tags (All 6 Categories)
export const FALLBACK_TAGS: Tag[] = [
  // Gender
  { id: '00000001-0000-4000-8000-000000000001', slug: 'gender_male', category: 'gender', label: { ar: 'رجالي', fr: 'Pour Homme', en: 'Men' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000002', slug: 'gender_female', category: 'gender', label: { ar: 'نسائي', fr: 'Pour Femme', en: 'Women' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000003', slug: 'gender_unisex', category: 'gender', label: { ar: 'للجنسين', fr: 'Unisexe', en: 'Unisex' }, created_at: '' },
  // Vibe
  { id: '00000001-0000-4000-8000-000000000004', slug: 'vibe_fresh', category: 'vibe', label: { ar: 'منعش ونقي', fr: 'Frais & Pur', en: 'Fresh & Clean' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000005', slug: 'vibe_warm', category: 'vibe', label: { ar: 'دافئ وجذاب', fr: 'Chaud & Séduisant', en: 'Warm & Seductive' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000006', slug: 'vibe_mysterious', category: 'vibe', label: { ar: 'غامض وفاخر', fr: 'Mystérieux & Sombre', en: 'Dark & Mysterious' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000007', slug: 'vibe_elegant', category: 'vibe', label: { ar: 'أنيق وراقي', fr: 'Élégant & Raffiné', en: 'Elegant & Sophisticated' }, created_at: '' },
  // Occasion
  { id: '00000001-0000-4000-8000-000000000008', slug: 'occasion_daily', category: 'occasion', label: { ar: 'يومي وعملي', fr: 'Quotidien', en: 'Everyday / Office' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000009', slug: 'occasion_evening', category: 'occasion', label: { ar: 'سهرات ومناسبات', fr: 'Soirée & Fêtes', en: 'Evening & Events' }, created_at: '' },
  { id: '00000001-0000-4000-8000-00000000000a', slug: 'occasion_special', category: 'occasion', label: { ar: 'لحظات استثنائية', fr: 'Grandes Occasions', en: 'Special Moments' }, created_at: '' },
  // Season
  { id: '00000001-0000-4000-8000-00000000000b', slug: 'season_summer', category: 'season', label: { ar: 'صيفي وحيوي', fr: 'Été', en: 'Summer' }, created_at: '' },
  { id: '00000001-0000-4000-8000-00000000000c', slug: 'season_winter', category: 'season', label: { ar: 'شتوي وخريفي', fr: 'Hiver & Automne', en: 'Winter & Autumn' }, created_at: '' },
  // Intensity
  { id: '00000001-0000-4000-8000-00000000000d', slug: 'intensity_subtle', category: 'intensity', label: { ar: 'ناعم وخفيف', fr: 'Discret', en: 'Subtle / Close Scent' }, created_at: '' },
  { id: '00000001-0000-4000-8000-00000000000e', slug: 'intensity_strong', category: 'intensity', label: { ar: 'فوّاح وقوي', fr: 'Sillage Puissant', en: 'Strong Projection' }, created_at: '' },
  // Notes
  { id: '00000001-0000-4000-8000-00000000000f', slug: 'notes_citrus', category: 'notes', label: { ar: 'حمضيات وبرغموت', fr: 'Agrumes & Bergamote', en: 'Citrus & Bergamot' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000010', slug: 'notes_woody', category: 'notes', label: { ar: 'أخشاب وأرز', fr: 'Bois & Cèdre', en: 'Woody & Cedar' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000011', slug: 'notes_amber', category: 'notes', label: { ar: 'عنبر وفانيليا', fr: 'Ambre & Vanille', en: 'Amber & Vanilla' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000012', slug: 'notes_floral', category: 'notes', label: { ar: 'زهور وياسمين', fr: 'Fleurs & Jasmin', en: 'Floral & Jasmine' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000013', slug: 'notes_oud', category: 'notes', label: { ar: 'عود ملكي وبخور', fr: 'Oud & Encens', en: 'Royal Oud & Incense' }, created_at: '' },
  { id: '00000001-0000-4000-8000-000000000014', slug: 'notes_spicy', category: 'notes', label: { ar: 'توابل وهيل', fr: 'Épices & Cardamome', en: 'Spices & Cardamom' }, created_at: '' },
  // Backwards compatibility legacy aliases
  { id: 'tag_male', slug: 'gender_male_legacy', category: 'gender', label: { ar: 'رجالي', fr: 'Pour Homme', en: 'Men' }, created_at: '' },
  { id: 'tag_female', slug: 'gender_female_legacy', category: 'gender', label: { ar: 'نسائي', fr: 'Pour Femme', en: 'Women' }, created_at: '' },
  { id: 'tag_unisex', slug: 'gender_unisex_legacy', category: 'gender', label: { ar: 'للجنسين', fr: 'Unisexe', en: 'Unisex' }, created_at: '' },
  { id: 'tag_fresh', slug: 'vibe_fresh_legacy', category: 'vibe', label: { ar: 'منعش ونقي', fr: 'Frais & Pur', en: 'Fresh & Clean' }, created_at: '' },
  { id: 'tag_warm', slug: 'vibe_warm_legacy', category: 'vibe', label: { ar: 'دافئ وجذاب', fr: 'Chaud & Séduisant', en: 'Warm & Seductive' }, created_at: '' },
  { id: 'tag_mysterious', slug: 'vibe_mysterious_legacy', category: 'vibe', label: { ar: 'غامض وفاخر', fr: 'Mystérieux & Sombre', en: 'Dark & Mysterious' }, created_at: '' },
  { id: 'tag_elegant', slug: 'vibe_elegant_legacy', category: 'vibe', label: { ar: 'أنيق وراقي', fr: 'Élégant & Raffiné', en: 'Elegant & Sophisticated' }, created_at: '' },
  { id: 'tag_daily', slug: 'occasion_daily_legacy', category: 'occasion', label: { ar: 'يومي وعملي', fr: 'Quotidien', en: 'Everyday / Office' }, created_at: '' },
  { id: 'tag_evening', slug: 'occasion_evening_legacy', category: 'occasion', label: { ar: 'سهرات ومناسبات', fr: 'Soirée & Fêtes', en: 'Evening & Events' }, created_at: '' },
  { id: 'tag_special', slug: 'occasion_special_legacy', category: 'occasion', label: { ar: 'لحظات استثنائية', fr: 'Grandes Occasions', en: 'Special Moments' }, created_at: '' },
  { id: 'tag_summer', slug: 'season_summer_legacy', category: 'season', label: { ar: 'صيفي وحيوي', fr: 'Été', en: 'Summer' }, created_at: '' },
  { id: 'tag_winter', slug: 'season_winter_legacy', category: 'season', label: { ar: 'شتوي وخريفي', fr: 'Hiver & Automne', en: 'Winter & Autumn' }, created_at: '' },
  { id: 'tag_subtle', slug: 'intensity_subtle_legacy', category: 'intensity', label: { ar: 'ناعم وخفيف', fr: 'Discret', en: 'Subtle / Close Scent' }, created_at: '' },
  { id: 'tag_strong', slug: 'intensity_strong_legacy', category: 'intensity', label: { ar: 'فوّاح وقوي', fr: 'Sillage Puissant', en: 'Strong Projection' }, created_at: '' },
  { id: 'tag_citrus', slug: 'notes_citrus_legacy', category: 'notes', label: { ar: 'حمضيات وبرغموت', fr: 'Agrumes & Bergamote', en: 'Citrus & Bergamot' }, created_at: '' },
  { id: 'tag_woody', slug: 'notes_woody_legacy', category: 'notes', label: { ar: 'أخشاب وأرز', fr: 'Bois & Cèdre', en: 'Woody & Cedar' }, created_at: '' },
  { id: 'tag_amber', slug: 'notes_amber_legacy', category: 'notes', label: { ar: 'عنبر وفانيليا', fr: 'Ambre & Vanille', en: 'Amber & Vanilla' }, created_at: '' },
  { id: 'tag_floral', slug: 'notes_floral_legacy', category: 'notes', label: { ar: 'زهور وياسمين', fr: 'Fleurs & Jasmin', en: 'Floral & Jasmine' }, created_at: '' },
  { id: 'tag_oud', slug: 'notes_oud_legacy', category: 'notes', label: { ar: 'عود ملكي وبخور', fr: 'Oud & Encens', en: 'Royal Oud & Incense' }, created_at: '' },
  { id: 'tag_spicy', slug: 'notes_spicy_legacy', category: 'notes', label: { ar: 'توابل وهيل', fr: 'Épices & Cardamome', en: 'Spices & Cardamom' }, created_at: '' },
];

// 10 Progressive Quiz Questions
export const FALLBACK_QUESTIONS: Question[] = [
  {
    id: '00000002-0000-4000-8000-000000000001',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-000000000002',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-000000000003',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-000000000004',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-000000000005',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-000000000006',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-000000000007',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-000000000008',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-000000000009',
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
    created_at: '',
  },
  {
    id: '00000002-0000-4000-8000-00000000000a',
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
    created_at: '',
  },
];

// Answers across the 10 questions
export const FALLBACK_ANSWERS: Answer[] = [
  // Q1 Answers (Gender)
  {
    id: '00000003-0000-4000-8000-000000000001',
    question_id: '00000002-0000-4000-8000-000000000001',
    sort_order: 1,
    title: { ar: 'عطور رجالية فاخرة', fr: 'Pour Homme', en: 'For Men' },
    subtitle_explanation: { ar: 'تركيبات ذكورية تعكس القوة والهيبة', fr: 'Compositions masculines puissantes et raffinées', en: 'Masculine compositions exuding strength and charisma' },
    image_url: '/assets/quiz/q1_men.png',
    is_hard_filter: true,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000002',
    question_id: '00000002-0000-4000-8000-000000000001',
    sort_order: 2,
    title: { ar: 'عطور نسائية ساحرة', fr: 'Pour Femme', en: 'For Women' },
    subtitle_explanation: { ar: 'نفحات أنثوية تجمع بين النعومة والجاذبية', fr: 'Sillages féminins alliant grâce et sensualité', en: 'Feminine notes blending grace and alluring softness' },
    image_url: '/assets/quiz/q1_women.png',
    is_hard_filter: true,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000003',
    question_id: '00000002-0000-4000-8000-000000000001',
    sort_order: 3,
    title: { ar: 'عطور للجنسين / حرّة', fr: 'Unisexe / Partagé', en: 'Unisex / Universal' },
    subtitle_explanation: { ar: 'إبداعات عصرية راقية تناسب كلا الجنسين', fr: 'Créations modernes et intemporelles pour tous', en: 'Modern, timeless artisanal creations for everyone' },
    image_url: '/assets/quiz/q1_unisex.png',
    is_hard_filter: true,
    created_at: '',
  },

  // Q2 Answers (Vibe)
  {
    id: '00000003-0000-4000-8000-000000000004',
    question_id: '00000002-0000-4000-8000-000000000002',
    sort_order: 1,
    title: { ar: 'منعش، نقي وحيوي', fr: 'Frais, Cristallin & Énergisant', en: 'Fresh, Crisp & Uplifting' },
    subtitle_explanation: { ar: 'حمضيات إيطالية ونفحات مائية تنبض بالحياة', fr: 'Agrumes éclatants et brise aquatique revigorante', en: 'Zesty citrus and invigorating aquatic notes' },
    image_url: '/assets/quiz/q2_fresh.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000005',
    question_id: '00000002-0000-4000-8000-000000000002',
    sort_order: 2,
    title: { ar: 'دافئ، عنبري وجذاب', fr: 'Chaud, Ambré & Gourmand', en: 'Warm, Amber & Seductive' },
    subtitle_explanation: { ar: 'لمسات الفانيليا والعنبر والكراميل المغرية', fr: 'Notes envoûtantes d’ambre doré et de vanille', en: 'Alluring accords of golden amber, spices, and vanilla' },
    image_url: '/assets/quiz/q2_warm.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000006',
    question_id: '00000002-0000-4000-8000-000000000002',
    sort_order: 3,
    title: { ar: 'غامض، خشبي وفاخر', fr: 'Sombre, Boisé & Majestueux', en: 'Dark, Woody & Mysterious' },
    subtitle_explanation: { ar: 'أخشاب الأرز والعود الفاخر والجلود المهيبة', fr: 'Bois précieux, oud fumé et cuirs de caractère', en: 'Precious woods, smoky royal oud, and refined leather' },
    image_url: '/assets/quiz/q2_woody.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000007',
    question_id: '00000002-0000-4000-8000-000000000002',
    sort_order: 4,
    title: { ar: 'زهري، رقيق وأنيق', fr: 'Floral, Romantique & Délicat', en: 'Floral, Poetic & Romantic' },
    subtitle_explanation: { ar: 'باقة من الورد الدمشقي، الياسمين وزهر البرتقال', fr: 'Bouquet sublime de jasmin et roses de Damas', en: 'Enchanting bouquet of jasmine and Damascus roses' },
    image_url: '/assets/quiz/q2_floral.png',
    is_hard_filter: false,
    created_at: '',
  },

  // Q3 Answers (Occasion)
  {
    id: '00000003-0000-4000-8000-000000000008',
    question_id: '00000002-0000-4000-8000-000000000003',
    sort_order: 1,
    title: { ar: 'استخدام يومي والعمل', fr: 'Quotidien & Bureau', en: 'Daily Wear & Office' },
    subtitle_explanation: { ar: 'عطر نظيف وغير مزعج يرافقك بثقة طوال النهار', fr: 'Élégance subtile et confortable pour toute la journée', en: 'Subtle, clean elegance suited for everyday confidence' },
    image_url: '/assets/quiz/q3_daily.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000009',
    question_id: '00000002-0000-4000-8000-000000000003',
    sort_order: 2,
    title: { ar: 'سهرات، مواعيد ومناسبات خاصة', fr: 'Soirées & Rendez-vous', en: 'Evenings & Special Dates' },
    subtitle_explanation: { ar: 'حضور مغناطيسي يترك انطباعاً لا ينسى', fr: 'Magnétisme envoûtant et présence mémorable', en: 'Magnetic aura that leaves an indelible memory' },
    image_url: '/assets/quiz/q3_evening.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-00000000000a',
    question_id: '00000002-0000-4000-8000-000000000003',
    sort_order: 3,
    title: { ar: 'احتفالات كبرى ولحظات ملكية', fr: 'Grandes Cérémonies & Prestige', en: 'Gala & Grand Moments' },
    subtitle_explanation: { ar: 'أفخم النغمات للمناسبات التي تتطلب تألقاً استثنائياً', fr: 'Sillages les plus prestigieux pour marquer les esprits', en: 'Regal compositions crafted for unforgettable grand occasions' },
    image_url: '/assets/quiz/q3_gala.png',
    is_hard_filter: false,
    created_at: '',
  },

  // Q4 Answers (Intensity)
  {
    id: '00000003-0000-4000-8000-00000000000b',
    question_id: '00000002-0000-4000-8000-000000000004',
    sort_order: 1,
    title: { ar: 'هادئ ومقرب (Skin Scent)', fr: 'Discret & Intime', en: 'Intimate Skin Scent' },
    subtitle_explanation: { ar: 'يكتشفه فقط من يقترب منك بنعومة', fr: 'Perçu uniquement par ceux qui s’approchent', en: 'Softly perceived only in close proximity' },
    image_url: '/assets/quiz/q4_intimate.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-00000000000c',
    question_id: '00000002-0000-4000-8000-000000000004',
    sort_order: 2,
    title: { ar: 'فوّاح، طاغي وثابت جداً', fr: 'Sillage Intense & Remarquable', en: 'Bold Projection & Longevity' },
    subtitle_explanation: { ar: 'يملأ المكان ويترك أثراً عاطراً لساعات طويلة', fr: 'Signature olfactive puissante qui emplit l’espace', en: 'Commanding trail that announces your presence' },
    image_url: '/assets/quiz/q4_bold.png',
    is_hard_filter: false,
    created_at: '',
  },

  // Q5 Answers (Notes)
  {
    id: '00000003-0000-4000-8000-00000000000d',
    question_id: '00000002-0000-4000-8000-000000000005',
    sort_order: 1,
    title: { ar: 'برغموت، يوسفي ونفحات خضراء', fr: 'Bergamote, Mandarine & Notes Vertes', en: 'Bergamot, Mandarin & Green Notes' },
    subtitle_explanation: { ar: 'انتعاش طبيعي مشرق ومبهج', fr: 'Éclat hespéridé lumineux et optimiste', en: 'Vibrant, sun-drenched Mediterranean freshness' },
    image_url: '/assets/quiz/q5_citrus.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-00000000000e',
    question_id: '00000002-0000-4000-8000-000000000005',
    sort_order: 2,
    title: { ar: 'أخشاب، عود وبخور شرقي', fr: 'Oud Oriental & Bois de Santal', en: 'Precious Oud & Sandalwood' },
    subtitle_explanation: { ar: 'عمق شرقي ملكي وأصالة لا تضاهى', fr: 'Profondeur mystique et luxe oriental absolu', en: 'Deep smoky sophistication and royal heritage' },
    image_url: '/assets/quiz/q5_oud.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-00000000000f',
    question_id: '00000002-0000-4000-8000-000000000005',
    sort_order: 3,
    title: { ar: 'عنبر، حبوب التونكا وفانيليا مدغشقر', fr: 'Ambre, Fève Tonka & Vanille', en: 'Amber, Tonka Bean & Madagascar Vanilla' },
    subtitle_explanation: { ar: 'حلاوة دافئة مخملية تفيض بالجاذبية', fr: 'Douceur veloutée et chaleureuse irrésistible', en: 'Warm velvet sweetness that comforts and entices' },
    image_url: '/assets/quiz/q5_amber.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000010',
    question_id: '00000002-0000-4000-8000-000000000005',
    sort_order: 4,
    title: { ar: 'توابل دافئة، هيل وقرفة سيلانية', fr: 'Épices Chaudes, Cardamome & Cannelle', en: 'Warm Spices, Cardamom & Cinnamon' },
    subtitle_explanation: { ar: 'حرارة آسرة تعطي العطر عمقاً وكاريزما خاصة', fr: 'Chaleur séduisante et sillage magnétique', en: 'Charismatic heat radiating captivating allure' },
    image_url: '/assets/quiz/q5_spices.png',
    is_hard_filter: false,
    created_at: '',
  },

  // Q6 Answers (Season)
  {
    id: '00000003-0000-4000-8000-000000000011',
    question_id: '00000002-0000-4000-8000-000000000006',
    sort_order: 1,
    title: { ar: 'أجواء صيفية مشمسة وربيعية منعشة', fr: 'Printemps & Été Solaire', en: 'Sunny Spring & Summer' },
    subtitle_explanation: { ar: 'نفحات خفيفة لا تثقل الحواس تحت أشعة الشمس', fr: 'Fragrances légères et aériennes par temps chaud', en: 'Light, crisp notes that thrive in warm weather' },
    image_url: '/assets/quiz/q6_summer.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000012',
    question_id: '00000002-0000-4000-8000-000000000006',
    sort_order: 2,
    title: { ar: 'ليالي الشتاء الباردة وأيام الخريف', fr: 'Automne & Hiver Frileux', en: 'Chilly Autumn & Winter' },
    subtitle_explanation: { ar: 'تركيبات دافئة وثقيلة تحتضنك كمعطف فاخر', fr: 'Sillages enveloppants et réconfortants par temps frais', en: 'Rich, cocooning compositions that cut through cold air' },
    image_url: '/assets/quiz/q6_winter.png',
    is_hard_filter: false,
    created_at: '',
  },

  // Q7 Answers (Strength)
  {
    id: '00000003-0000-4000-8000-000000000013',
    question_id: '00000002-0000-4000-8000-000000000007',
    sort_order: 1,
    title: { ar: 'ماء تواليت منعش ومريح (EDT)', fr: 'Eau de Toilette Aérienne', en: 'Airy Eau de Toilette' },
    subtitle_explanation: { ar: 'خفيف ومرن يناسب الاستعمال المتكرر', fr: 'Légèreté et versatilité au quotidien', en: 'Breezy and comfortable for frequent touch-ups' },
    image_url: '/assets/quiz/q7_edt.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000014',
    question_id: '00000002-0000-4000-8000-000000000007',
    sort_order: 2,
    title: { ar: 'ماء عطر غني وثابت (EDP)', fr: 'Eau de Parfum Intense', en: 'Rich Eau de Parfum' },
    subtitle_explanation: { ar: 'توازن مثالي بين الفوحان والثبات اليومي', fr: 'Équilibre parfait entre puissance et tenue', en: 'Ideal balance between rich sillage and all-day staying power' },
    image_url: '/assets/quiz/q7_edp.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000015',
    question_id: '00000002-0000-4000-8000-000000000007',
    sort_order: 3,
    title: { ar: 'خلاصة عطرية مركزة (Extrait / Parfum)', fr: 'Extrait de Parfum Pur', en: 'Pure Extrait de Parfum' },
    subtitle_explanation: { ar: 'أقصى درجات الثبات والعمق النادر', fr: 'Concentration ultime pour un prestige absolu', en: 'Maximum oil concentration for unmatched depth' },
    image_url: '/assets/quiz/q7_extrait.png',
    is_hard_filter: false,
    created_at: '',
  },

  // Q8 Answers (Texture)
  {
    id: '00000003-0000-4000-8000-000000000016',
    question_id: '00000002-0000-4000-8000-000000000008',
    sort_order: 1,
    title: { ar: 'نقي، مائي ومشرق كالحرير البارد', fr: 'Aérien, Aquatique & Cristallin', en: 'Crisp, Airy & Marine' },
    subtitle_explanation: { ar: 'شعور بالانتعاش والنظافة المطلقة', fr: 'Sensation de pureté et clarté immédiate', en: 'Crystal clarity evoking fresh mountain or sea breeze' },
    image_url: '/assets/quiz/q8_marine.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000017',
    question_id: '00000002-0000-4000-8000-000000000008',
    sort_order: 2,
    title: { ar: 'مخملي، بلسمي ودافئ كالكشمير', fr: 'Velouté, Balsamique & Chaleureux', en: 'Velvety, Balsamic & Cocooning' },
    subtitle_explanation: { ar: 'نعومة فاخرة تمنح الدفء والأمان', fr: 'Douceur caressante et rassurante', en: 'Soft, creamy comfort wrapping you like fine cashmere' },
    image_url: '/assets/quiz/q8_velvet.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-000000000018',
    question_id: '00000002-0000-4000-8000-000000000008',
    sort_order: 3,
    title: { ar: 'مدخن، جلدي ومهيب كالمخمل الأسود', fr: 'Fumé, Cuiré & Ténébreux', en: 'Smoky, Leathery & Resinous' },
    subtitle_explanation: { ar: 'غموض جذاب يعكس القوة والتفرد', fr: 'Caractère affirmé empreint de mystère', en: 'Deep, aristocratic richness with bold smoky nuances' },
    image_url: '/assets/quiz/q8_leather.png',
    is_hard_filter: false,
    created_at: '',
  },

  // Q9 Answers (Persona)
  {
    id: '00000003-0000-4000-8000-000000000019',
    question_id: '00000002-0000-4000-8000-000000000009',
    sort_order: 1,
    title: { ar: 'بسيط، راقي وهادئ (Minimalist)', fr: 'Épuré, Minimaliste & Subtil', en: 'Understated & Sophisticated' },
    subtitle_explanation: { ar: 'جمال يكمن في التفاصيل دون ضجيج', fr: 'La vraie élégance réside dans la retenue', en: 'Quiet luxury that speaks softly with effortless grace' },
    image_url: '/assets/quiz/q9_minimal.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-00000000001a',
    question_id: '00000002-0000-4000-8000-000000000009',
    sort_order: 2,
    title: { ar: 'قائد كاريزماتي ملهم (Leader)', fr: 'Charismatique, Audacieux & Leader', en: 'Charismatic, Bold & Magnetic' },
    subtitle_explanation: { ar: 'ثقة طاغية تجذب الأنظار وتلهم المحيطين', fr: 'Présence affirmée qui captive immédiatement', en: 'Commanding self-assurance that draws admiration' },
    image_url: '/assets/quiz/q9_leader.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-00000000001b',
    question_id: '00000002-0000-4000-8000-000000000009',
    sort_order: 3,
    title: { ar: 'أرستقراطي ملكي كلاسيكي (Noble)', fr: 'Aristocratique & Royal', en: 'Timeless Royal Aristocrat' },
    subtitle_explanation: { ar: 'أصالة متجذرة وفخامة لا تزول مع الزمن', fr: 'Prestige éternel et raffinement sans compromis', en: 'Inherited prestige and regal nobility across generations' },
    image_url: '/assets/quiz/q9_royal.png',
    is_hard_filter: false,
    created_at: '',
  },

  // Q10 Answers (Day/Night)
  {
    id: '00000003-0000-4000-8000-00000000001c',
    question_id: '00000002-0000-4000-8000-00000000000a',
    sort_order: 1,
    title: { ar: 'إشراقة الصباح الباكر', fr: 'La clarté vivifiante du matin', en: 'Crisp Sunlit Morning' },
    subtitle_explanation: { ar: 'بدايات نشطة تتطلب نقاءً وحيوية متقدة', fr: 'Élan vital et fraîcheur optimiste pour bien démarrer', en: 'Dynamic beginnings calling for sparkling vitality' },
    image_url: '/assets/quiz/q10_morning.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-00000000001d',
    question_id: '00000002-0000-4000-8000-00000000000a',
    sort_order: 2,
    title: { ar: 'لحظات الغروب الذهبية', fr: 'L’heure dorée du crépuscule', en: 'Golden Hour Twilight' },
    subtitle_explanation: { ar: 'هدوء ساحر ونفحات عنبرية دافئة تلائم الانتقال لليل', fr: 'Sensualité chaleureuse au coucher du soleil', en: 'Mellow warmth transitioning seamlessly into the evening' },
    image_url: '/assets/quiz/q10_twilight.png',
    is_hard_filter: false,
    created_at: '',
  },
  {
    id: '00000003-0000-4000-8000-00000000001e',
    question_id: '00000002-0000-4000-8000-00000000000a',
    sort_order: 3,
    title: { ar: 'سكون منتصف الليل المرصع بالنجوم', fr: 'Le mystère captivant de minuit', en: 'Starlit Midnight Mystique' },
    subtitle_explanation: { ar: 'عمق آسر ونغمات شرقية تسحر الحضور', fr: 'Sillage ténébreux et envoûtant sous les étoiles', en: 'Captivating mystery radiating supreme seduction' },
    image_url: '/assets/quiz/q10_midnight.png',
    is_hard_filter: false,
    created_at: '',
  },
];

// Weights mapping answers to tags
export const FALLBACK_ANSWER_TAG_WEIGHTS: AnswerTagWeight[] = [
  // Q1 Weights (Hard filters)
  { id: 'w1', answer_id: '00000003-0000-4000-8000-000000000001', tag_id: '00000001-0000-4000-8000-000000000001', weight_points: 0 },
  { id: 'w2', answer_id: '00000003-0000-4000-8000-000000000001', tag_id: '00000001-0000-4000-8000-000000000003', weight_points: 0 },
  { id: 'w3', answer_id: '00000003-0000-4000-8000-000000000002', tag_id: '00000001-0000-4000-8000-000000000002', weight_points: 0 },
  { id: 'w4', answer_id: '00000003-0000-4000-8000-000000000002', tag_id: '00000001-0000-4000-8000-000000000003', weight_points: 0 },
  { id: 'w5', answer_id: '00000003-0000-4000-8000-000000000003', tag_id: '00000001-0000-4000-8000-000000000003', weight_points: 0 },
  { id: 'w6', answer_id: '00000003-0000-4000-8000-000000000003', tag_id: '00000001-0000-4000-8000-000000000001', weight_points: 0 },
  { id: 'w7', answer_id: '00000003-0000-4000-8000-000000000003', tag_id: '00000001-0000-4000-8000-000000000002', weight_points: 0 },

  // Q2 Weights (Vibe)
  { id: 'w8', answer_id: '00000003-0000-4000-8000-000000000004', tag_id: '00000001-0000-4000-8000-000000000004', weight_points: 30 },
  { id: 'w9', answer_id: '00000003-0000-4000-8000-000000000004', tag_id: '00000001-0000-4000-8000-00000000000f', weight_points: 20 },
  { id: 'w10', answer_id: '00000003-0000-4000-8000-000000000004', tag_id: '00000001-0000-4000-8000-00000000000b', weight_points: 15 },

  { id: 'w11', answer_id: '00000003-0000-4000-8000-000000000005', tag_id: '00000001-0000-4000-8000-000000000005', weight_points: 30 },
  { id: 'w12', answer_id: '00000003-0000-4000-8000-000000000005', tag_id: '00000001-0000-4000-8000-000000000011', weight_points: 20 },
  { id: 'w13', answer_id: '00000003-0000-4000-8000-000000000005', tag_id: '00000001-0000-4000-8000-00000000000c', weight_points: 15 },

  { id: 'w14', answer_id: '00000003-0000-4000-8000-000000000006', tag_id: '00000001-0000-4000-8000-000000000006', weight_points: 30 },
  { id: 'w15', answer_id: '00000003-0000-4000-8000-000000000006', tag_id: '00000001-0000-4000-8000-000000000010', weight_points: 20 },
  { id: 'w16', answer_id: '00000003-0000-4000-8000-000000000006', tag_id: '00000001-0000-4000-8000-000000000013', weight_points: 25 },

  { id: 'w17', answer_id: '00000003-0000-4000-8000-000000000007', tag_id: '00000001-0000-4000-8000-000000000012', weight_points: 35 },
  { id: 'w18', answer_id: '00000003-0000-4000-8000-000000000007', tag_id: '00000001-0000-4000-8000-000000000007', weight_points: 20 },

  // Q3 Weights (Occasion)
  { id: 'w19', answer_id: '00000003-0000-4000-8000-000000000008', tag_id: '00000001-0000-4000-8000-000000000008', weight_points: 25 },
  { id: 'w20', answer_id: '00000003-0000-4000-8000-000000000008', tag_id: '00000001-0000-4000-8000-000000000004', weight_points: 15 },
  { id: 'w21', answer_id: '00000003-0000-4000-8000-000000000009', tag_id: '00000001-0000-4000-8000-000000000009', weight_points: 30 },
  { id: 'w22', answer_id: '00000003-0000-4000-8000-000000000009', tag_id: '00000001-0000-4000-8000-000000000005', weight_points: 15 },
  { id: 'w23', answer_id: '00000003-0000-4000-8000-00000000000a', tag_id: '00000001-0000-4000-8000-00000000000a', weight_points: 35 },
  { id: 'w24', answer_id: '00000003-0000-4000-8000-00000000000a', tag_id: '00000001-0000-4000-8000-000000000013', weight_points: 20 },

  // Q4 Weights (Intensity)
  { id: 'w25', answer_id: '00000003-0000-4000-8000-00000000000b', tag_id: '00000001-0000-4000-8000-00000000000d', weight_points: 30 },
  { id: 'w26', answer_id: '00000003-0000-4000-8000-00000000000b', tag_id: '00000001-0000-4000-8000-000000000008', weight_points: 10 },
  { id: 'w27', answer_id: '00000003-0000-4000-8000-00000000000c', tag_id: '00000001-0000-4000-8000-00000000000e', weight_points: 35 },
  { id: 'w28', answer_id: '00000003-0000-4000-8000-00000000000c', tag_id: '00000001-0000-4000-8000-000000000009', weight_points: 15 },

  // Q5 Weights (Notes)
  { id: 'w29', answer_id: '00000003-0000-4000-8000-00000000000d', tag_id: '00000001-0000-4000-8000-00000000000f', weight_points: 35 },
  { id: 'w30', answer_id: '00000003-0000-4000-8000-00000000000d', tag_id: '00000001-0000-4000-8000-000000000004', weight_points: 20 },
  { id: 'w31', answer_id: '00000003-0000-4000-8000-00000000000e', tag_id: '00000001-0000-4000-8000-000000000013', weight_points: 35 },
  { id: 'w32', answer_id: '00000003-0000-4000-8000-00000000000e', tag_id: '00000001-0000-4000-8000-000000000010', weight_points: 20 },
  { id: 'w33', answer_id: '00000003-0000-4000-8000-00000000000f', tag_id: '00000001-0000-4000-8000-000000000011', weight_points: 35 },
  { id: 'w34', answer_id: '00000003-0000-4000-8000-00000000000f', tag_id: '00000001-0000-4000-8000-000000000005', weight_points: 20 },
  { id: 'w35', answer_id: '00000003-0000-4000-8000-000000000010', tag_id: '00000001-0000-4000-8000-000000000014', weight_points: 35 },
  { id: 'w36', answer_id: '00000003-0000-4000-8000-000000000010', tag_id: '00000001-0000-4000-8000-000000000005', weight_points: 20 },

  // Q6 Weights (Season)
  { id: 'w37', answer_id: '00000003-0000-4000-8000-000000000011', tag_id: '00000001-0000-4000-8000-00000000000b', weight_points: 35 },
  { id: 'w38', answer_id: '00000003-0000-4000-8000-000000000011', tag_id: '00000001-0000-4000-8000-000000000004', weight_points: 20 },
  { id: 'w39', answer_id: '00000003-0000-4000-8000-000000000012', tag_id: '00000001-0000-4000-8000-00000000000c', weight_points: 35 },
  { id: 'w40', answer_id: '00000003-0000-4000-8000-000000000012', tag_id: '00000001-0000-4000-8000-000000000005', weight_points: 20 },

  // Q7 Weights (Concentration / Strength)
  { id: 'w41', answer_id: '00000003-0000-4000-8000-000000000013', tag_id: '00000001-0000-4000-8000-00000000000d', weight_points: 25 },
  { id: 'w42', answer_id: '00000003-0000-4000-8000-000000000013', tag_id: '00000001-0000-4000-8000-000000000004', weight_points: 20 },
  { id: 'w43', answer_id: '00000003-0000-4000-8000-000000000014', tag_id: '00000001-0000-4000-8000-000000000007', weight_points: 25 },
  { id: 'w44', answer_id: '00000003-0000-4000-8000-000000000014', tag_id: '00000001-0000-4000-8000-000000000008', weight_points: 15 },
  { id: 'w45', answer_id: '00000003-0000-4000-8000-000000000015', tag_id: '00000001-0000-4000-8000-00000000000e', weight_points: 30 },
  { id: 'w46', answer_id: '00000003-0000-4000-8000-000000000015', tag_id: '00000001-0000-4000-8000-000000000013', weight_points: 20 },

  // Q8 Weights (Texture)
  { id: 'w47', answer_id: '00000003-0000-4000-8000-000000000016', tag_id: '00000001-0000-4000-8000-000000000004', weight_points: 25 },
  { id: 'w48', answer_id: '00000003-0000-4000-8000-000000000016', tag_id: '00000001-0000-4000-8000-00000000000f', weight_points: 20 },
  { id: 'w49', answer_id: '00000003-0000-4000-8000-000000000017', tag_id: '00000001-0000-4000-8000-000000000011', weight_points: 25 },
  { id: 'w50', answer_id: '00000003-0000-4000-8000-000000000017', tag_id: '00000001-0000-4000-8000-000000000005', weight_points: 20 },
  { id: 'w51', answer_id: '00000003-0000-4000-8000-000000000018', tag_id: '00000001-0000-4000-8000-000000000006', weight_points: 25 },
  { id: 'w52', answer_id: '00000003-0000-4000-8000-000000000018', tag_id: '00000001-0000-4000-8000-000000000010', weight_points: 20 },

  // Q9 Weights (Persona)
  { id: 'w53', answer_id: '00000003-0000-4000-8000-000000000019', tag_id: '00000001-0000-4000-8000-000000000007', weight_points: 25 },
  { id: 'w54', answer_id: '00000003-0000-4000-8000-000000000019', tag_id: '00000001-0000-4000-8000-00000000000d', weight_points: 15 },
  { id: 'w55', answer_id: '00000003-0000-4000-8000-00000000001a', tag_id: '00000001-0000-4000-8000-00000000000e', weight_points: 25 },
  { id: 'w56', answer_id: '00000003-0000-4000-8000-00000000001a', tag_id: '00000001-0000-4000-8000-000000000014', weight_points: 20 },
  { id: 'w57', answer_id: '00000003-0000-4000-8000-00000000001b', tag_id: '00000001-0000-4000-8000-00000000000a', weight_points: 25 },
  { id: 'w58', answer_id: '00000003-0000-4000-8000-00000000001b', tag_id: '00000001-0000-4000-8000-000000000013', weight_points: 25 },

  // Q10 Weights (Peak Energy Time)
  { id: 'w59', answer_id: '00000003-0000-4000-8000-00000000001c', tag_id: '00000001-0000-4000-8000-000000000008', weight_points: 25 },
  { id: 'w60', answer_id: '00000003-0000-4000-8000-00000000001c', tag_id: '00000001-0000-4000-8000-00000000000b', weight_points: 20 },
  { id: 'w61', answer_id: '00000003-0000-4000-8000-00000000001d', tag_id: '00000001-0000-4000-8000-000000000005', weight_points: 25 },
  { id: 'w62', answer_id: '00000003-0000-4000-8000-00000000001d', tag_id: '00000001-0000-4000-8000-000000000011', weight_points: 20 },
  { id: 'w63', answer_id: '00000003-0000-4000-8000-00000000001e', tag_id: '00000001-0000-4000-8000-000000000009', weight_points: 25 },
  { id: 'w64', answer_id: '00000003-0000-4000-8000-00000000001e', tag_id: '00000001-0000-4000-8000-000000000006', weight_points: 25 },
];

// Curated 200 Luxury Perfumes (Strictly Image-Free)
export const FALLBACK_PERFUMES: Perfume[] = (seededPerfumesRaw as any[]).map((p) => ({
  id: p.id,
  name: p.name,
  brand: p.brand,
  description: p.description,
  price: p.price,
  shelf_location: p.shelf_location,
  is_available: p.is_available,
  is_featured: p.is_featured,
  is_draft: p.is_draft,
  created_at: new Date().toISOString(),
}));

// Perfume-to-Tag Relationships
export const FALLBACK_PERFUME_TAGS: PerfumeTag[] = [];
(seededPerfumesRaw as any[]).forEach((p) => {
  if (Array.isArray(p.tagIds)) {
    p.tagIds.forEach((tId: string) => {
      FALLBACK_PERFUME_TAGS.push({
        perfume_id: p.id,
        tag_id: tId,
      });
    });
  }
});
