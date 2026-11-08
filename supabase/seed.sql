-- -------------------------------------------------------------
-- Perfume Finder & In-Store Kiosk - Automated Seed Script
-- Generated on: 2026-11-08T16:41:20.428Z
-- Contains: Store Settings, 20 Base Tags, 10 Questions, Answers, Weights, 200 Perfumes
-- -------------------------------------------------------------

-- 1. Store Settings
INSERT INTO public.store_settings (id, store_name, hero_title, hero_subtitle, default_locale, kiosk_pin, store_address, operating_hours, social_links)
VALUES (
  '00000009-0000-4000-8000-000000000001',
  '{"ar":"مستكشف العطور الفاخرة","fr":"Découvreur de Parfum de Luxe","en":"Luxury Perfume Finder"}'::jsonb,
  '{"ar":"اكتشف بصمتك العطرية الفريدة","fr":"Découvrez votre signature olfactive","en":"Discover Your Scent Signature"}'::jsonb,
  '{"ar":"تجربة ذكية وراقية تكتشف من خلالها العطر المثالي الذي يجسد شخصيتك وذوقك خلال 30 ثانية فقط.","fr":"Une expérience immersive pour révéler le parfum qui sublime votre personnalité en seulement 30 secondes.","en":"An elevated fragrance discovery experience tailored to your unique taste and mood in just 30 seconds."}'::jsonb,
  'ar',
  '1234',
  '{"ar":"تونس العاصمة، شارع الحبيب بورقيبة - البوتيك الفاخر","fr":"Tunis, Avenue Habib Bourguiba - La Boutique Élégante","en":"Tunis, Habib Bourguiba Avenue - The Luxury Boutique"}'::jsonb,
  '{"ar":"يومياً: 10:00 ص - 09:00 م","fr":"Tous les jours: 10h00 - 21h00","en":"Daily: 10:00 AM - 09:00 PM"}'::jsonb,
  '{"instagram":"https://instagram.com","tiktok":"https://tiktok.com","whatsapp":"https://whatsapp.com","maps":"https://maps.google.com"}'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  store_name = EXCLUDED.store_name,
  hero_title = EXCLUDED.hero_title,
  hero_subtitle = EXCLUDED.hero_subtitle;

-- 2. Base Tags (All 6 Categories)
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000001', 'gender_male', 'gender', '{"ar":"رجالي","fr":"Pour Homme","en":"Men"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000002', 'gender_female', 'gender', '{"ar":"نسائي","fr":"Pour Femme","en":"Women"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000003', 'gender_unisex', 'gender', '{"ar":"للجنسين","fr":"Unisexe","en":"Unisex"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000004', 'vibe_fresh', 'vibe', '{"ar":"منعش ونقي","fr":"Frais & Pur","en":"Fresh & Clean"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000005', 'vibe_warm', 'vibe', '{"ar":"دافئ وجذاب","fr":"Chaud & Séduisant","en":"Warm & Seductive"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000006', 'vibe_mysterious', 'vibe', '{"ar":"غامض وفاخر","fr":"Mystérieux & Sombre","en":"Dark & Mysterious"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000007', 'vibe_elegant', 'vibe', '{"ar":"أنيق وراقي","fr":"Élégant & Raffiné","en":"Elegant & Sophisticated"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000008', 'occasion_daily', 'occasion', '{"ar":"يومي وعملي","fr":"Quotidien","en":"Everyday / Office"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000009', 'occasion_evening', 'occasion', '{"ar":"سهرات ومناسبات","fr":"Soirée & Fêtes","en":"Evening & Events"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-00000000000a', 'occasion_special', 'occasion', '{"ar":"لحظات استثنائية","fr":"Grandes Occasions","en":"Special Moments"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-00000000000b', 'season_summer', 'season', '{"ar":"صيفي وحيوي","fr":"Été","en":"Summer"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-00000000000c', 'season_winter', 'season', '{"ar":"شتوي وخريفي","fr":"Hiver & Automne","en":"Winter & Autumn"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-00000000000d', 'intensity_subtle', 'intensity', '{"ar":"ناعم وخفيف","fr":"Discret","en":"Subtle / Close Scent"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-00000000000e', 'intensity_strong', 'intensity', '{"ar":"فوّاح وقوي","fr":"Sillage Puissant","en":"Strong Projection"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-00000000000f', 'notes_citrus', 'notes', '{"ar":"حمضيات وبرغموت","fr":"Agrumes & Bergamote","en":"Citrus & Bergamot"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000010', 'notes_woody', 'notes', '{"ar":"أخشاب وأرز","fr":"Bois & Cèdre","en":"Woody & Cedar"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000011', 'notes_amber', 'notes', '{"ar":"عنبر وفانيليا","fr":"Ambre & Vanille","en":"Amber & Vanilla"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000012', 'notes_floral', 'notes', '{"ar":"زهور وياسمين","fr":"Fleurs & Jasmin","en":"Floral & Jasmine"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000013', 'notes_oud', 'notes', '{"ar":"عود ملكي وبخور","fr":"Oud & Encens","en":"Royal Oud & Incense"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO public.tags (id, slug, category, label)
VALUES ('00000001-0000-4000-8000-000000000014', 'notes_spicy', 'notes', '{"ar":"توابل وهيل","fr":"Épices & Cardamome","en":"Spices & Cardamom"}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET label = EXCLUDED.label;

-- 3. Questions, Answers, and Scoring Weights
INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000001', 1, true, '{"ar":"لمن تبحث عن هذا العطر اليوم؟","fr":"Pour qui recherchez-vous ce parfum aujourd’hui ?","en":"Who is this fragrance for today?"}'::jsonb, '{"ar":"حدد الفئة المستهدفة لتصفية الاختيارات الملائمة فوراً","fr":"Sélectionnez le profil pour filtrer les créations adaptées","en":"Select the target profile to immediately filter suitable creations"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000001', '00000002-0000-4000-8000-000000000001', 1, '{"ar":"عطور رجالية فاخرة","fr":"Pour Homme","en":"For Men"}'::jsonb, '{"ar":"تركيبات ذكورية تعكس القوة والهيبة","fr":"Compositions masculines puissantes et raffinées","en":"Masculine compositions exuding strength and charisma"}'::jsonb, true)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000001', '00000003-0000-4000-8000-000000000001', '00000001-0000-4000-8000-000000000001', 0)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000002', '00000003-0000-4000-8000-000000000001', '00000001-0000-4000-8000-000000000003', 0)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000002', '00000002-0000-4000-8000-000000000001', 2, '{"ar":"عطور نسائية ساحرة","fr":"Pour Femme","en":"For Women"}'::jsonb, '{"ar":"نفحات أنثوية تجمع بين النعومة والجاذبية","fr":"Sillages féminins alliant grâce et sensualité","en":"Feminine notes blending grace and alluring softness"}'::jsonb, true)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000003', '00000003-0000-4000-8000-000000000002', '00000001-0000-4000-8000-000000000002', 0)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000004', '00000003-0000-4000-8000-000000000002', '00000001-0000-4000-8000-000000000003', 0)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000003', '00000002-0000-4000-8000-000000000001', 3, '{"ar":"عطور للجنسين / حرّة","fr":"Unisexe / Partagé","en":"Unisex / Universal"}'::jsonb, '{"ar":"إبداعات عصرية راقية تناسب كلا الجنسين","fr":"Créations modernes et intemporelles pour tous","en":"Modern, timeless artisanal creations for everyone"}'::jsonb, true)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000005', '00000003-0000-4000-8000-000000000003', '00000001-0000-4000-8000-000000000003', 0)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000006', '00000003-0000-4000-8000-000000000003', '00000001-0000-4000-8000-000000000001', 0)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000007', '00000003-0000-4000-8000-000000000003', '00000001-0000-4000-8000-000000000002', 0)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000002', 2, true, '{"ar":"ما هو الطابع أو الإحساس الرئيسي الذي تريده؟","fr":"Quel sillage ou sentiment souhaitez-vous laisser ?","en":"What primary impression or vibe do you wish to project?"}'::jsonb, '{"ar":"اختر الإحساس العطري الذي يعبّر عن شخصيتك","fr":"Choisissez l’univers olfactif qui reflète votre caractère","en":"Choose the olfactive aura that best reflects your character"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000004', '00000002-0000-4000-8000-000000000002', 1, '{"ar":"منعش، نقي وحيوي","fr":"Frais, Cristallin & Énergisant","en":"Fresh, Crisp & Uplifting"}'::jsonb, '{"ar":"حمضيات إيطالية ونفحات مائية تنبض بالحياة","fr":"Agrumes éclatants et brise aquatique revigorante","en":"Zesty citrus and invigorating aquatic notes"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000008', '00000003-0000-4000-8000-000000000004', '00000001-0000-4000-8000-000000000004', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000009', '00000003-0000-4000-8000-000000000004', '00000001-0000-4000-8000-00000000000f', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000000a', '00000003-0000-4000-8000-000000000004', '00000001-0000-4000-8000-00000000000b', 15)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000005', '00000002-0000-4000-8000-000000000002', 2, '{"ar":"دافئ، عنبري وجذاب","fr":"Chaud, Ambré & Gourmand","en":"Warm, Amber & Seductive"}'::jsonb, '{"ar":"لمسات الفانيليا والعنبر والكراميل المغرية","fr":"Notes envoûtantes d’ambre doré et de vanille","en":"Alluring accords of golden amber, spices, and vanilla"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000000b', '00000003-0000-4000-8000-000000000005', '00000001-0000-4000-8000-000000000005', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000000c', '00000003-0000-4000-8000-000000000005', '00000001-0000-4000-8000-000000000011', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000000d', '00000003-0000-4000-8000-000000000005', '00000001-0000-4000-8000-00000000000c', 15)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000006', '00000002-0000-4000-8000-000000000002', 3, '{"ar":"غامض، خشبي وفاخر","fr":"Sombre, Boisé & Majestueux","en":"Dark, Woody & Mysterious"}'::jsonb, '{"ar":"أخشاب الأرز والعود الفاخر والجلود المهيبة","fr":"Bois précieux, oud fumé et cuirs de caractère","en":"Precious woods, smoky royal oud, and refined leather"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000000e', '00000003-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000006', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000000f', '00000003-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000010', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000010', '00000003-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000013', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000007', '00000002-0000-4000-8000-000000000002', 4, '{"ar":"زهري، رقيق وأنيق","fr":"Floral, Romantique & Délicat","en":"Floral, Poetic & Romantic"}'::jsonb, '{"ar":"باقة من الورد الدمشقي، الياسمين وزهر البرتقال","fr":"Bouquet sublime de jasmin et roses de Damas","en":"Enchanting bouquet of jasmine and Damascus roses"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000011', '00000003-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000012', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000012', '00000003-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000007', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000003', 3, true, '{"ar":"في أي وقت ومناسبة ستضع هذا العطر في الغالب؟","fr":"Pour quelle occasion porterez-vous principalement ce parfum ?","en":"On what occasion will you primarily wear this scent?"}'::jsonb, '{"ar":"التوقيت المناسب يمنح العطر ذروة ألقه","fr":"Le bon moment décuple la splendeur du parfum","en":"The right occasion brings out the fragrance’s peak beauty"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000008', '00000002-0000-4000-8000-000000000003', 1, '{"ar":"استخدام يومي والعمل","fr":"Quotidien & Bureau","en":"Daily Wear & Office"}'::jsonb, '{"ar":"عطر نظيف وغير مزعج يرافقك بثقة طوال النهار","fr":"Élégance subtile et confortable pour toute la journée","en":"Subtle, clean elegance suited for everyday confidence"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000013', '00000003-0000-4000-8000-000000000008', '00000001-0000-4000-8000-000000000008', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000014', '00000003-0000-4000-8000-000000000008', '00000001-0000-4000-8000-000000000004', 15)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000009', '00000002-0000-4000-8000-000000000003', 2, '{"ar":"سهرات، مواعيد ومناسبات خاصة","fr":"Soirées & Rendez-vous","en":"Evenings & Special Dates"}'::jsonb, '{"ar":"حضور مغناطيسي يترك انطباعاً لا ينسى","fr":"Magnétisme envoûtant et présence mémorable","en":"Magnetic aura that leaves an indelible memory"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000015', '00000003-0000-4000-8000-000000000009', '00000001-0000-4000-8000-000000000009', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000016', '00000003-0000-4000-8000-000000000009', '00000001-0000-4000-8000-000000000005', 15)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000000a', '00000002-0000-4000-8000-000000000003', 3, '{"ar":"احتفالات كبرى ولحظات ملكية","fr":"Grandes Cérémonies & Prestige","en":"Gala & Grand Moments"}'::jsonb, '{"ar":"أفخم النغمات للمناسبات التي تتطلب تألقاً استثنائياً","fr":"Sillages les plus prestigieux pour marquer les esprits","en":"Regal compositions crafted for unforgettable grand occasions"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000017', '00000003-0000-4000-8000-00000000000a', '00000001-0000-4000-8000-00000000000a', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000018', '00000003-0000-4000-8000-00000000000a', '00000001-0000-4000-8000-000000000013', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000004', 4, true, '{"ar":"ما درجة الثبات والفوحان التي تفضلها؟","fr":"Quelle intensité et puissance de sillage préférez-vous ?","en":"What level of projection and intensity do you prefer?"}'::jsonb, '{"ar":"بين النعومة الهادئة والفوحان الجريء الآسر","fr":"Entre subtilité intime et sillage captivant et audacieux","en":"Between intimate whisper and bold, room-filling presence"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000000b', '00000002-0000-4000-8000-000000000004', 1, '{"ar":"هادئ ومقرب (Skin Scent)","fr":"Discret & Intime","en":"Intimate Skin Scent"}'::jsonb, '{"ar":"يكتشفه فقط من يقترب منك بنعومة","fr":"Perçu uniquement par ceux qui s’approchent","en":"Softly perceived only in close proximity"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000019', '00000003-0000-4000-8000-00000000000b', '00000001-0000-4000-8000-00000000000d', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000001a', '00000003-0000-4000-8000-00000000000b', '00000001-0000-4000-8000-000000000008', 10)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000000c', '00000002-0000-4000-8000-000000000004', 2, '{"ar":"فوّاح، طاغي وثابت جداً","fr":"Sillage Intense & Remarquable","en":"Bold Projection & Longevity"}'::jsonb, '{"ar":"يملأ المكان ويترك أثراً عاطراً لساعات طويلة","fr":"Signature olfactive puissante qui emplit l’espace","en":"Commanding trail that announces your presence"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000001b', '00000003-0000-4000-8000-00000000000c', '00000001-0000-4000-8000-00000000000e', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000001c', '00000003-0000-4000-8000-00000000000c', '00000001-0000-4000-8000-000000000009', 15)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000005', 5, true, '{"ar":"أي من هذه النغمات العطرية تلامس حواسك أكثر؟","fr":"Quelles facettes olfactives captivent le plus vos sens ?","en":"Which of these olfactive facets captivates your senses most?"}'::jsonb, '{"ar":"المكونات الأساسية التي تشكل قلب العطر وقاعدته","fr":"Les ingrédients phares qui définissent le cœur du parfum","en":"The core ingredients that define the fragrance heart and base"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000000d', '00000002-0000-4000-8000-000000000005', 1, '{"ar":"برغموت، يوسفي ونفحات خضراء","fr":"Bergamote, Mandarine & Notes Vertes","en":"Bergamot, Mandarin & Green Notes"}'::jsonb, '{"ar":"انتعاش طبيعي مشرق ومبهج","fr":"Éclat hespéridé lumineux et optimiste","en":"Vibrant, sun-drenched Mediterranean freshness"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000001d', '00000003-0000-4000-8000-00000000000d', '00000001-0000-4000-8000-00000000000f', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000001e', '00000003-0000-4000-8000-00000000000d', '00000001-0000-4000-8000-000000000004', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000000e', '00000002-0000-4000-8000-000000000005', 2, '{"ar":"أخشاب، عود وبخور شرقي","fr":"Oud Oriental & Bois de Santal","en":"Precious Oud & Sandalwood"}'::jsonb, '{"ar":"عمق شرقي ملكي وأصالة لا تضاهى","fr":"Profondeur mystique et luxe oriental absolu","en":"Deep smoky sophistication and royal heritage"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000001f', '00000003-0000-4000-8000-00000000000e', '00000001-0000-4000-8000-000000000013', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000020', '00000003-0000-4000-8000-00000000000e', '00000001-0000-4000-8000-000000000010', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000000f', '00000002-0000-4000-8000-000000000005', 3, '{"ar":"عنبر، حبوب التونكا وفانيليا مدغشقر","fr":"Ambre, Fève Tonka & Vanille","en":"Amber, Tonka Bean & Madagascar Vanilla"}'::jsonb, '{"ar":"حلاوة دافئة مخملية تفيض بالجاذبية","fr":"Douceur veloutée et chaleureuse irrésistible","en":"Warm velvet sweetness that comforts and entices"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000021', '00000003-0000-4000-8000-00000000000f', '00000001-0000-4000-8000-000000000011', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000022', '00000003-0000-4000-8000-00000000000f', '00000001-0000-4000-8000-000000000005', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000010', '00000002-0000-4000-8000-000000000005', 4, '{"ar":"توابل دافئة، هيل وقرفة سيلانية","fr":"Épices Chaudes, Cardamome & Cannelle","en":"Warm Spices, Cardamom & Cinnamon"}'::jsonb, '{"ar":"حرارة آسرة تعطي العطر عمقاً وكاريزما خاصة","fr":"Chaleur séduisante et sillage magnétique","en":"Charismatic heat radiating captivating allure"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000023', '00000003-0000-4000-8000-000000000010', '00000001-0000-4000-8000-000000000014', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000024', '00000003-0000-4000-8000-000000000010', '00000001-0000-4000-8000-000000000005', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000006', 6, true, '{"ar":"ما هو الفصل أو الطقس الذي ترتدي فيه العطر عادة؟","fr":"En quelle saison appréciez-vous le plus porter votre parfum ?","en":"In which season do you primarily intend to wear this fragrance?"}'::jsonb, '{"ar":"درجة حرارة الجو تؤثر مباشرة على تطاير وتفاعل الجزيئات العطرية","fr":"Le climat influence directement la diffusion des accords olfactifs","en":"Ambient temperature directly affects the evolution of olfactive notes"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000011', '00000002-0000-4000-8000-000000000006', 1, '{"ar":"أجواء صيفية مشمسة وربيعية منعشة","fr":"Printemps & Été Solaire","en":"Sunny Spring & Summer"}'::jsonb, '{"ar":"نفحات خفيفة لا تثقل الحواس تحت أشعة الشمس","fr":"Fragrances légères et aériennes par temps chaud","en":"Light, crisp notes that thrive in warm weather"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000025', '00000003-0000-4000-8000-000000000011', '00000001-0000-4000-8000-00000000000b', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000026', '00000003-0000-4000-8000-000000000011', '00000001-0000-4000-8000-000000000004', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000012', '00000002-0000-4000-8000-000000000006', 2, '{"ar":"ليالي الشتاء الباردة وأيام الخريف","fr":"Automne & Hiver Frileux","en":"Chilly Autumn & Winter"}'::jsonb, '{"ar":"تركيبات دافئة وثقيلة تحتضنك كمعطف فاخر","fr":"Sillages enveloppants et réconfortants par temps frais","en":"Rich, cocooning compositions that cut through cold air"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000027', '00000003-0000-4000-8000-000000000012', '00000001-0000-4000-8000-00000000000c', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000028', '00000003-0000-4000-8000-000000000012', '00000001-0000-4000-8000-000000000005', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000007', 7, true, '{"ar":"ما تركيز العطر وكثافته التي تبحث عنها؟","fr":"Quelle concentration olfactive privilégiez-vous ?","en":"What concentration and texture do you seek?"}'::jsonb, '{"ar":"التركيز العطري يحدد بقاء الرائحة ودرجة تماسكها","fr":"La concentration définit la tenue et la signature","en":"Concentration defines longevity and presence"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000013', '00000002-0000-4000-8000-000000000007', 1, '{"ar":"ماء تواليت منعش ومريح (EDT)","fr":"Eau de Toilette Aérienne","en":"Airy Eau de Toilette"}'::jsonb, '{"ar":"خفيف ومرن يناسب الاستعمال المتكرر","fr":"Légèreté et versatilité au quotidien","en":"Breezy and comfortable for frequent touch-ups"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000029', '00000003-0000-4000-8000-000000000013', '00000001-0000-4000-8000-00000000000d', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000002a', '00000003-0000-4000-8000-000000000013', '00000001-0000-4000-8000-000000000004', 15)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000014', '00000002-0000-4000-8000-000000000007', 2, '{"ar":"ماء عطر غني وثابت (EDP)","fr":"Eau de Parfum Intense","en":"Rich Eau de Parfum"}'::jsonb, '{"ar":"توازن مثالي بين الفوحان والثبات اليومي","fr":"Équilibre parfait entre puissance et tenue","en":"Ideal balance between rich sillage and all-day staying power"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000002b', '00000003-0000-4000-8000-000000000014', '00000001-0000-4000-8000-00000000000e', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000002c', '00000003-0000-4000-8000-000000000014', '00000001-0000-4000-8000-000000000008', 15)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000015', '00000002-0000-4000-8000-000000000007', 3, '{"ar":"خلاصة عطرية مركزة (Extrait / Parfum)","fr":"Extrait de Parfum Pur","en":"Pure Extrait de Parfum"}'::jsonb, '{"ar":"أقصى درجات الثبات والعمق النادر","fr":"Concentration ultime pour un prestige absolu","en":"Maximum oil concentration for unmatched depth"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000002d', '00000003-0000-4000-8000-000000000015', '00000001-0000-4000-8000-00000000000e', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000002e', '00000003-0000-4000-8000-000000000015', '00000001-0000-4000-8000-000000000006', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000008', 8, true, '{"ar":"ما هو الملمس الحسي الذي يريح حواسك؟","fr":"Quelle texture sensorielle vous inspire le plus ?","en":"Which olfactory texture resonates most with you?"}'::jsonb, '{"ar":"الإحساس بالرائحة يشبه ملامسة الأقمشة الفاخرة","fr":"Le parfum s’éprouve comme une étoffe sur la peau","en":"Fragrance textures evoke fine materials upon skin"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000016', '00000002-0000-4000-8000-000000000008', 1, '{"ar":"نقي، مائي ومشرق كالحرير البارد","fr":"Aérien, Aquatique & Cristallin","en":"Crisp, Airy & Marine"}'::jsonb, '{"ar":"شعور بالانتعاش والنظافة المطلقة","fr":"Sensation de pureté et clarté immédiate","en":"Crystal clarity evoking fresh mountain or sea breeze"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000002f', '00000003-0000-4000-8000-000000000016', '00000001-0000-4000-8000-000000000004', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000030', '00000003-0000-4000-8000-000000000016', '00000001-0000-4000-8000-00000000000f', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000017', '00000002-0000-4000-8000-000000000008', 2, '{"ar":"مخملي، بلسمي ودافئ كالكشمير","fr":"Velouté, Balsamique & Chaleureux","en":"Velvety, Balsamic & Cocooning"}'::jsonb, '{"ar":"نعومة فاخرة تمنح الدفء والأمان","fr":"Douceur caressante et rassurante","en":"Soft, creamy comfort wrapping you like fine cashmere"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000031', '00000003-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000011', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000032', '00000003-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000005', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000018', '00000002-0000-4000-8000-000000000008', 3, '{"ar":"مدخن، جلدي ومهيب كالمخمل الأسود","fr":"Fumé, Cuiré & Ténébreux","en":"Smoky, Leathery & Resinous"}'::jsonb, '{"ar":"غموض جذاب يعكس القوة والتفرد","fr":"Caractère affirmé empreint de mystère","en":"Deep, aristocratic richness with bold smoky nuances"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000033', '00000003-0000-4000-8000-000000000018', '00000001-0000-4000-8000-000000000013', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000034', '00000003-0000-4000-8000-000000000018', '00000001-0000-4000-8000-000000000010', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-000000000009', 9, true, '{"ar":"كيف تصف حضورك وشخصيتك في المجتمع؟","fr":"Comment décririez-vous votre présence naturelle ?","en":"How would you characterize your natural presence?"}'::jsonb, '{"ar":"عطرك هو امتداد غير مرئي لثقتك وشخصيتك","fr":"Votre parfum est le prolongement subtil de votre aura","en":"Your scent is the invisible extension of your persona"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-000000000019', '00000002-0000-4000-8000-000000000009', 1, '{"ar":"بسيط، راقي وهادئ (Minimalist)","fr":"Épuré, Minimaliste & Subtil","en":"Understated & Sophisticated"}'::jsonb, '{"ar":"جمال يكمن في التفاصيل دون ضجيج","fr":"La vraie élégance réside dans la retenue","en":"Quiet luxury that speaks softly with effortless grace"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000035', '00000003-0000-4000-8000-000000000019', '00000001-0000-4000-8000-00000000000d', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000036', '00000003-0000-4000-8000-000000000019', '00000001-0000-4000-8000-000000000007', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000001a', '00000002-0000-4000-8000-000000000009', 2, '{"ar":"قائد كاريزماتي ملهم (Leader)","fr":"Charismatique, Audacieux & Leader","en":"Charismatic, Bold & Magnetic"}'::jsonb, '{"ar":"ثقة طاغية تجذب الأنظار وتلهم المحيطين","fr":"Présence affirmée qui captive immédiatement","en":"Commanding self-assurance that draws admiration"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000037', '00000003-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-00000000000e', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000038', '00000003-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-000000000010', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000001b', '00000002-0000-4000-8000-000000000009', 3, '{"ar":"أرستقراطي ملكي كلاسيكي (Noble)","fr":"Aristocratique & Royal","en":"Timeless Royal Aristocrat"}'::jsonb, '{"ar":"أصالة متجذرة وفخامة لا تزول مع الزمن","fr":"Prestige éternel et raffinement sans compromis","en":"Inherited prestige and regal nobility across generations"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000039', '00000003-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000007', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000003a', '00000003-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000013', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

INSERT INTO public.questions (id, step_order, is_active, question_text, helper_text)
VALUES ('00000002-0000-4000-8000-00000000000a', 10, true, '{"ar":"في أي وقت من اليوم تشعر أن طاقتك في قمتها؟","fr":"À quel moment de la journée votre énergie culmine-t-elle ?","en":"At what time of day does your energy peak?"}'::jsonb, '{"ar":"التناغم بين حركتك وإشعاع العطر يخلق هالة مميزة","fr":"L’accord entre votre rythme et le parfum magnifie le sillage","en":"Alignment with your daily rhythm enhances scent radiance"}'::jsonb)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000001c', '00000002-0000-4000-8000-00000000000a', 1, '{"ar":"إشراقة الصباح الباكر","fr":"La clarté vivifiante du matin","en":"Crisp Sunlit Morning"}'::jsonb, '{"ar":"بدايات نشطة تتطلب نقاءً وحيوية متقدة","fr":"Élan vital et fraîcheur optimiste pour bien démarrer","en":"Dynamic beginnings calling for sparkling vitality"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000003b', '00000003-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-000000000004', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000003c', '00000003-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-00000000000f', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000001d', '00000002-0000-4000-8000-00000000000a', 2, '{"ar":"لحظات الغروب الذهبية","fr":"L’heure dorée du crépuscule","en":"Golden Hour Twilight"}'::jsonb, '{"ar":"هدوء ساحر ونفحات عنبرية دافئة تلائم الانتقال لليل","fr":"Sensualité chaleureuse au coucher du soleil","en":"Mellow warmth transitioning seamlessly into the evening"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000003d', '00000003-0000-4000-8000-00000000001d', '00000001-0000-4000-8000-000000000005', 25)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000003e', '00000003-0000-4000-8000-00000000001d', '00000001-0000-4000-8000-000000000011', 20)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answers (id, question_id, sort_order, title, subtitle_explanation, is_hard_filter)
VALUES ('00000003-0000-4000-8000-00000000001e', '00000002-0000-4000-8000-00000000000a', 3, '{"ar":"سكون منتصف الليل المرصع بالنجوم","fr":"Le mystère captivant de minuit","en":"Starlit Midnight Mystique"}'::jsonb, '{"ar":"عمق آسر ونغمات شرقية تسحر الحضور","fr":"Sillage ténébreux et envoûtant sous les étoiles","en":"Captivating mystery radiating supreme seduction"}'::jsonb, false)
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-00000000003f', '00000003-0000-4000-8000-00000000001e', '00000001-0000-4000-8000-000000000009', 35)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;
INSERT INTO public.answer_tag_weights (id, answer_id, tag_id, weight_points)
VALUES ('00000005-0000-4000-8000-000000000040', '00000003-0000-4000-8000-00000000001e', '00000001-0000-4000-8000-000000000006', 30)
ON CONFLICT (answer_id, tag_id) DO UPDATE SET weight_points = EXCLUDED.weight_points;

-- 4. Perfumes & Perfume-to-Tag Relationships (Strictly Image-Free)
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000001',
  'Sauvage Edt',
  'Dior',
  '{"ar":"توليفة أرستقراطية متوازنة من Dior تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Dior, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Dior, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  197,
  'Zone B-02',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000001', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000001', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000001', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000001', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000001', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000002',
  'Sauvage Edp',
  'Dior',
  '{"ar":"توليفة أرستقراطية متوازنة من Dior تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Dior, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Dior, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  214,
  'Zone C-03',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000002', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000002', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000002', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000002', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000002', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000003',
  'Sauvage Parfum',
  'Dior',
  '{"ar":"توليفة أرستقراطية متوازنة من Dior تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Dior, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Dior, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  231,
  'Zone D-04',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000003', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000003', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000003', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000003', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000003', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000004',
  'Sauvage Elixir',
  'Dior',
  '{"ar":"توليفة أرستقراطية متوازنة من Dior تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Dior, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Dior, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  248,
  'Zone E-05',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000004', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000004', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000004', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000004', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000004', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000005',
  'Homme Intense',
  'Dior',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dior, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dior, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  265,
  'Zone F-06',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000005', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000005', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000005', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000005', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000005', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000005', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000005', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000006',
  'Homme Parfum',
  'Dior',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dior, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dior, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  282,
  'Zone VIP-07',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000006', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000006', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000007',
  'J''Adore Edp',
  'Dior',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dior, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dior, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  299,
  'Zone A-08',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000007', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000008',
  'Aventus',
  'Creed',
  '{"ar":"توليفة عطرية متميزة من Creed تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Creed offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Creed delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  316,
  'Zone B-09',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000008', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000008', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000008', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000008', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000008', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000008', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000009',
  'Aventus For Her',
  'Creed',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Creed, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Creed, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  333,
  'Zone C-10',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000009', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000009', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000009', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000009', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000009', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000009', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000009', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000000a',
  'Silver Mountain Water',
  'Creed',
  '{"ar":"توليفة عطرية متميزة من Creed تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Creed offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Creed delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  350,
  'Zone D-11',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000a', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000a', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000a', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000000b',
  'Green Irish Tweed',
  'Creed',
  '{"ar":"توليفة أرستقراطية متوازنة من Creed تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Creed, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Creed, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  367,
  'Zone E-12',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000b', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000b', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000b', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000b', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000000c',
  'Millésime Impérial',
  'Creed',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Creed, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Creed, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  384,
  'Zone F-01',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000c', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000c', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000c', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000c', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000c', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000000d',
  'Original Vetiver',
  'Creed',
  '{"ar":"توليفة أرستقراطية متوازنة من Creed تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Creed, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Creed, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  401,
  'Zone VIP-02',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000d', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000d', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000d', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000d', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000d', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000000e',
  'Original Santal',
  'Creed',
  '{"ar":"توليفة خشبية حارة آسرة من Creed تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Creed, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Creed, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  418,
  'Zone A-03',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000e', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000e', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000e', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000e', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000e', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000e', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000000f',
  'Imagination',
  'Louis Vuitton',
  '{"ar":"توليفة أرستقراطية متوازنة من Louis Vuitton تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Louis Vuitton, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Louis Vuitton, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  435,
  'Zone B-04',
  true,
  true,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000f', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000f', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000f', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000f', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000f', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000000f', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000010',
  'L''Immensité',
  'Louis Vuitton',
  '{"ar":"توليفة أرستقراطية متوازنة من Louis Vuitton تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Louis Vuitton, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Louis Vuitton, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  452,
  'Zone C-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000010', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000010', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000010', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000010', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000010', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000011',
  'Afternoon Swim',
  'Louis Vuitton',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Louis Vuitton, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Louis Vuitton, bringing effortless daytime radiance."}'::jsonb,
  469,
  'Zone D-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000011', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000011', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000011', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000011', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000011', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000012',
  'Attrape-Rêves',
  'Louis Vuitton',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Louis Vuitton, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Louis Vuitton, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  186,
  'Zone E-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000012', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000012', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000012', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000012', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000012', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000012', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000012', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000013',
  'Heures D''Absence',
  'Louis Vuitton',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Louis Vuitton, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Louis Vuitton, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  203,
  'Zone F-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000013', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000013', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000013', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000013', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000013', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000013', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000013', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000014',
  'Le Jour Se Lève',
  'Louis Vuitton',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Louis Vuitton, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Louis Vuitton, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  220,
  'Zone VIP-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000014', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000014', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000014', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000014', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000014', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000014', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000014', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000015',
  'Rose Des Vents',
  'Louis Vuitton',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Louis Vuitton, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Louis Vuitton, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  237,
  'Zone A-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000015', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000015', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000015', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000015', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000015', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000015', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000015', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000016',
  'Black Orchid Edp',
  'Tom Ford',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Tom Ford, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Tom Ford, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  254,
  'Zone B-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000016', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000016', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000016', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000016', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000016', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000016', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000016', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000017',
  'Black Orchid Edt',
  'Tom Ford',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Tom Ford, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Tom Ford, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  271,
  'Zone C-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000017', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000018',
  'Tobacco Vanille Edp',
  'Tom Ford',
  '{"ar":"توليفة عطرية متميزة من Tom Ford تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Tom Ford offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Tom Ford delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  288,
  'Zone D-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000018', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000018', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000018', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000018', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000018', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000018', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000019',
  'Lost Cherry Edp',
  'Tom Ford',
  '{"ar":"توليفة عطرية متميزة من Tom Ford تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Tom Ford offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Tom Ford delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  305,
  'Zone E-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000019', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000019', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000019', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000019', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000019', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000019', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000019', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000001a',
  'Velvet Orchid Edp',
  'Tom Ford',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Tom Ford, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Tom Ford, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  322,
  'Zone F-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001a', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000001b',
  'Fucking Fabulous Edp',
  'Tom Ford',
  '{"ar":"توليفة أرستقراطية متوازنة من Tom Ford تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Tom Ford, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Tom Ford, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  339,
  'Zone VIP-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001b', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000001c',
  'Oud Wood Edp',
  'Tom Ford',
  '{"ar":"توليفة عطرية متميزة من Tom Ford تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Tom Ford offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Tom Ford delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  356,
  'Zone A-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001c', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000001d',
  'Le Male',
  'Jean Paul Gaultier',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Jean Paul Gaultier, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  373,
  'Zone B-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001d', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001d', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001d', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001d', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001d', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001d', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000001e',
  'Ultra Male',
  'Jean Paul Gaultier',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Jean Paul Gaultier, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  390,
  'Zone C-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001e', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001e', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001e', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001e', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001e', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001e', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000001f',
  'Le Male Le Parfum',
  'Jean Paul Gaultier',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Jean Paul Gaultier, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  407,
  'Zone D-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001f', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001f', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001f', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001f', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001f', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001f', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000001f', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000020',
  'Le Beau',
  'Jean Paul Gaultier',
  '{"ar":"توليفة أرستقراطية متوازنة من Jean Paul Gaultier تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Jean Paul Gaultier, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Jean Paul Gaultier, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  424,
  'Zone E-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000020', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000020', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000020', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000020', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000020', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000021',
  'Le Beau Le Parfum',
  'Jean Paul Gaultier',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Jean Paul Gaultier, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  441,
  'Zone F-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000021', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000021', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000021', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000021', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000021', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000021', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000021', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000022',
  'Le Beau Paradise Garden',
  'Jean Paul Gaultier',
  '{"ar":"توليفة عطرية متميزة من Jean Paul Gaultier تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Jean Paul Gaultier offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Jean Paul Gaultier delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  458,
  'Zone VIP-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000022', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000022', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000022', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000022', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000023',
  'Le Male In The Navy',
  'Jean Paul Gaultier',
  '{"ar":"توليفة أرستقراطية متوازنة من Jean Paul Gaultier تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Jean Paul Gaultier, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Jean Paul Gaultier, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  475,
  'Zone A-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000023', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000023', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000023', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000023', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000024',
  'Libre Edp',
  'Yves Saint Laurent',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Yves Saint Laurent, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  192,
  'Zone B-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000024', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000024', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000024', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000024', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000024', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000024', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000024', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000025',
  'Libre Intense Edp',
  'Yves Saint Laurent',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Yves Saint Laurent, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  209,
  'Zone C-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000025', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000025', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000025', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000025', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000025', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000025', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000025', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000026',
  'Libre L''Eau Nue Edp',
  'Yves Saint Laurent',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Yves Saint Laurent, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Yves Saint Laurent, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  226,
  'Zone D-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000026', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000026', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000026', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000026', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000027',
  'Mon Paris Edp',
  'Yves Saint Laurent',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Yves Saint Laurent, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Yves Saint Laurent, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  243,
  'Zone E-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000027', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000027', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000027', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000027', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000027', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000027', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000027', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000028',
  'Mon Paris Intensement Edp',
  'Yves Saint Laurent',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Yves Saint Laurent, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Yves Saint Laurent, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  260,
  'Zone F-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000028', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000028', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000028', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000028', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000028', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000028', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000028', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000029',
  'Black Opium Edp',
  'Yves Saint Laurent',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Yves Saint Laurent, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  277,
  'Zone VIP-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000029', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000029', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000029', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000029', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000029', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000002a',
  'Black Opium Intense Edp',
  'Yves Saint Laurent',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Yves Saint Laurent, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  294,
  'Zone A-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002a', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002a', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002a', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002a', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002a', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000002b',
  'Stronger With You Edt',
  'Giorgio Armani',
  '{"ar":"توليفة أرستقراطية متوازنة من Giorgio Armani تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Giorgio Armani, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Giorgio Armani, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  311,
  'Zone B-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002b', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002b', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002b', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002b', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002b', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002b', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002b', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000002c',
  'Stronger With You Intensely Edp',
  'Giorgio Armani',
  '{"ar":"توليفة عطرية متميزة من Giorgio Armani تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Giorgio Armani offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Giorgio Armani delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  328,
  'Zone C-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002c', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002c', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002c', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002c', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002c', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002c', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000002d',
  'Stronger With You Absolutely Edp',
  'Giorgio Armani',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Giorgio Armani, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  345,
  'Zone D-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002d', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002d', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002d', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002d', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002d', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002d', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002d', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000002e',
  'Stronger With You Leather Edp',
  'Giorgio Armani',
  '{"ar":"تحفة شرقية فاخرة تتوجها نفحات العود الملكي والجلود المدخنة لهيبة مطلقة وسحر لا يضاهى في المناسبات الكبرى.","fr":"Un chef-d’œuvre oriental majestueux sublimé par le oud royal et des accords cuirés intenses pour les grandes occasions.","en":"A majestic oriental signature from Giorgio Armani, enriched with royal oud and smoky leather for unforgettable grandeur."}'::jsonb,
  362,
  'Zone E-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002e', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002e', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002e', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002e', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000002f',
  'Stronger With You Oud Edp',
  'Giorgio Armani',
  '{"ar":"توليفة عطرية متميزة من Giorgio Armani تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Giorgio Armani offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Giorgio Armani delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  379,
  'Zone F-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002f', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002f', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002f', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002f', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002f', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002f', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000002f', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000030',
  'Stronger With You Only Edp',
  'Giorgio Armani',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Giorgio Armani, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Giorgio Armani, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  396,
  'Zone VIP-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000030', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000030', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000030', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000030', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000030', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000030', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000030', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000031',
  'Stronger With You Freeze Edp',
  'Giorgio Armani',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Giorgio Armani, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Giorgio Armani, bringing effortless daytime radiance."}'::jsonb,
  413,
  'Zone A-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000031', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000031', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000031', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000031', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000032',
  'Delina Edp',
  'Parfums de Marly',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Parfums de Marly, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Parfums de Marly, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  430,
  'Zone B-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000032', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000032', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000032', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000032', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000032', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000032', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000032', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000033',
  'Delina Exclusif Edp',
  'Parfums de Marly',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Parfums de Marly, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Parfums de Marly, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  447,
  'Zone C-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000033', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000033', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000033', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000033', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000033', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000033', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000033', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000034',
  'Delina La Rosée Edp',
  'Parfums de Marly',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Parfums de Marly, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Parfums de Marly, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  464,
  'Zone D-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000034', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000034', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000034', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000034', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000034', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000034', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000034', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000035',
  'Valaya Edp',
  'Parfums de Marly',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Parfums de Marly, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Parfums de Marly, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  181,
  'Zone E-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000035', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000035', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000035', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000035', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000035', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000035', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000036',
  'Valaya Exclusif Edp',
  'Parfums de Marly',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Parfums de Marly, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Parfums de Marly, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  198,
  'Zone F-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000036', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000036', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000036', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000036', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000036', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000036', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000037',
  'Castley Edp',
  'Parfums de Marly',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Parfums de Marly, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Parfums de Marly, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  215,
  'Zone VIP-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000037', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000037', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000037', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000037', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000037', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000037', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000038',
  'Palatine Edp',
  'Parfums de Marly',
  '{"ar":"توليفة عطرية متميزة من Parfums de Marly تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Parfums de Marly offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Parfums de Marly delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  232,
  'Zone A-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000038', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000038', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000038', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000038', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000038', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000038', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000039',
  'Accento',
  'Xerjoff',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Xerjoff, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Xerjoff, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  249,
  'Zone B-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000039', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000039', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000039', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000039', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000039', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000039', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000003a',
  'Mefisto Gentiluomo',
  'Xerjoff',
  '{"ar":"توليفة أرستقراطية متوازنة من Xerjoff تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Xerjoff, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Xerjoff, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  266,
  'Zone C-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003a', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003a', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003a', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003a', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003a', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000003b',
  'Erba Pura',
  'Xerjoff',
  '{"ar":"توليفة عطرية متميزة من Xerjoff تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Xerjoff offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Xerjoff delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  283,
  'Zone D-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003b', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003b', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003b', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003b', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000003c',
  'More Than Words',
  'Xerjoff',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Xerjoff, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Xerjoff, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  300,
  'Zone E-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003c', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003c', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003c', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003c', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003c', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003c', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003c', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000003d',
  'Naxos',
  'Xerjoff',
  '{"ar":"توليفة أرستقراطية متوازنة من Xerjoff تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Xerjoff, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Xerjoff, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  317,
  'Zone F-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003d', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003d', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003d', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003d', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003d', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003d', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003d', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003d', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000003e',
  'Starlight',
  'Xerjoff',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Xerjoff, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  334,
  'Zone VIP-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003e', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003e', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003e', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003e', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000003f',
  'Wardasina',
  'Xerjoff',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Xerjoff, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Xerjoff, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  351,
  'Zone A-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003f', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003f', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003f', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003f', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003f', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000003f', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000040',
  'Paradoxe Eau De Parfum',
  'Prada',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Prada, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Prada, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  368,
  'Zone B-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000040', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000040', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000040', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000040', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000040', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000040', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000040', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000041',
  'Paradoxe Intense Eau De Parfum',
  'Prada',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Prada, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Prada, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  385,
  'Zone C-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000041', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000041', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000041', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000041', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000041', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000041', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000041', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000042',
  'Paradoxe Virtual Flower Eau De Parfum',
  'Prada',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Prada, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Prada, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  402,
  'Zone D-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000042', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000042', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000042', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000042', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000042', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000043',
  'Paradoxe Radical Essence Parfum',
  'Prada',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Prada, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  419,
  'Zone E-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000043', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000043', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000043', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000043', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000043', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000043', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000043', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000044',
  'Luna Rossa Eau De Parfum',
  'Prada',
  '{"ar":"توليفة أرستقراطية متوازنة من Prada تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Prada, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Prada, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  436,
  'Zone F-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000044', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000044', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000044', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000044', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000045',
  'Luna Rossa Ocean Eau De Parfum',
  'Prada',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Prada, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Prada, bringing effortless daytime radiance."}'::jsonb,
  453,
  'Zone VIP-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000045', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000045', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000045', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000045', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000046',
  'Luna Rossa Carbon Eau De Parfum',
  'Prada',
  '{"ar":"توليفة أرستقراطية متوازنة من Prada تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Prada, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Prada, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  470,
  'Zone A-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000046', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000046', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000046', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000046', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000046', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000047',
  'Terre D''Hermès Edt',
  'Hermès',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Hermès, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Hermès, bringing effortless daytime radiance."}'::jsonb,
  187,
  'Zone B-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000047', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000047', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000047', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000047', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000047', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000047', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000047', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000048',
  'Terre D''Hermès Edp',
  'Hermès',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Hermès, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Hermès, bringing effortless daytime radiance."}'::jsonb,
  204,
  'Zone C-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000048', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000048', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000048', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000048', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000048', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000048', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000048', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000049',
  'Terre D''Hermès Eau Très Fraîche',
  'Hermès',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Hermès, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Hermès, bringing effortless daytime radiance."}'::jsonb,
  221,
  'Zone D-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000049', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000049', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000049', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000049', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000049', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000049', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000049', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000004a',
  'Terre D''Hermès Eau Givrée',
  'Hermès',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Hermès, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Hermès, bringing effortless daytime radiance."}'::jsonb,
  238,
  'Zone E-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004a', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004a', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004a', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004a', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004a', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004a', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004a', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000004b',
  'H24 Edt',
  'Hermès',
  '{"ar":"توليفة عطرية متميزة من Hermès تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Hermès offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Hermès delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  255,
  'Zone F-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004b', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004b', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004b', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000004c',
  'H24 Herbes Vives Edp',
  'Hermès',
  '{"ar":"توليفة أرستقراطية متوازنة من Hermès تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Hermès, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Hermès, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  272,
  'Zone VIP-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004c', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004c', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004c', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004c', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000004d',
  'Un Jardin Sur Le Nil Edt',
  'Hermès',
  '{"ar":"توليفة عطرية متميزة من Hermès تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Hermès offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Hermès delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  289,
  'Zone A-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004d', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004d', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004d', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004d', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000004e',
  'The One Edp',
  'Dolce & Gabbana',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dolce & Gabbana, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dolce & Gabbana, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  306,
  'Zone B-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004e', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004e', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004e', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004e', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004e', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004e', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004e', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000004f',
  'The One Edp Intense',
  'Dolce & Gabbana',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dolce & Gabbana, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dolce & Gabbana, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  323,
  'Zone C-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004f', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004f', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004f', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004f', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004f', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004f', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000004f', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000050',
  'The Only One Edp',
  'Dolce & Gabbana',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dolce & Gabbana, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dolce & Gabbana, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  340,
  'Zone D-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000050', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000050', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000050', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000050', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000050', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000050', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000050', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000051',
  'The Only One 2 Edp',
  'Dolce & Gabbana',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dolce & Gabbana, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dolce & Gabbana, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  357,
  'Zone E-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000051', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000051', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000051', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000051', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000051', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000051', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000051', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000052',
  'Devotion Edp',
  'Dolce & Gabbana',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dolce & Gabbana, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dolce & Gabbana, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  374,
  'Zone F-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000052', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000052', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000052', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000052', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000052', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000052', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000052', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000053',
  'Devotion Edp Intense',
  'Dolce & Gabbana',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Dolce & Gabbana, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Dolce & Gabbana, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  391,
  'Zone VIP-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000053', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000053', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000053', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000053', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000053', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000053', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000053', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000054',
  'Light Blue Edt',
  'Dolce & Gabbana',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Dolce & Gabbana, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Dolce & Gabbana, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  408,
  'Zone A-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000054', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000054', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000054', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000054', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000054', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000055',
  'Good Girl',
  'Carolina Herrera',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Carolina Herrera, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Carolina Herrera, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  425,
  'Zone B-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000055', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000055', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000055', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000055', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000055', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000055', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000055', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000056',
  'Good Girl Blush',
  'Carolina Herrera',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Carolina Herrera, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Carolina Herrera, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  442,
  'Zone C-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000056', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000056', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000056', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000056', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000056', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000056', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000056', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000057',
  'Good Girl Supreme',
  'Carolina Herrera',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Carolina Herrera, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Carolina Herrera, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  459,
  'Zone D-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000057', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000057', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000057', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000057', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000057', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000057', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000057', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000058',
  'Very Good Girl',
  'Carolina Herrera',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Carolina Herrera, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Carolina Herrera, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  476,
  'Zone E-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000058', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000058', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000058', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000058', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000058', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000058', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000058', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000059',
  'Very Good Girl Elixir',
  'Carolina Herrera',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Carolina Herrera, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Carolina Herrera, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  193,
  'Zone F-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000059', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000059', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000059', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000059', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000059', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000059', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000059', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000005a',
  '212 Vip',
  'Carolina Herrera',
  '{"ar":"توليفة خشبية حارة آسرة من Carolina Herrera تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Carolina Herrera, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Carolina Herrera, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  210,
  'Zone VIP-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005a', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005a', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005a', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005a', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005a', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005a', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000005b',
  '212 Vip Black',
  'Carolina Herrera',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Carolina Herrera, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  227,
  'Zone A-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005b', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005b', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005b', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005b', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005b', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005b', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000005c',
  'Eros Parfum',
  'Versace',
  '{"ar":"توليفة أرستقراطية متوازنة من Versace تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Versace, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Versace, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  244,
  'Zone B-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005c', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005c', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005c', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005c', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005c', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005c', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000005d',
  'Eros Flame',
  'Versace',
  '{"ar":"توليفة خشبية حارة آسرة من Versace تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Versace, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Versace, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  261,
  'Zone C-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005d', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005d', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005d', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005d', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005d', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005d', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000005e',
  'Eros Energy',
  'Versace',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Versace, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Versace, bringing effortless daytime radiance."}'::jsonb,
  278,
  'Zone D-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005e', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005e', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005e', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005e', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005e', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000005f',
  'Dylan Blue Pour Homme',
  'Versace',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Versace, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Versace, bringing effortless daytime radiance."}'::jsonb,
  295,
  'Zone E-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005f', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005f', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005f', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005f', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005f', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000005f', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000060',
  'Man Eau Fraiche',
  'Versace',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Versace, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Versace, bringing effortless daytime radiance."}'::jsonb,
  312,
  'Zone F-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000060', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000060', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000060', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000060', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000060', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000060', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000061',
  'Pour Homme',
  'Versace',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Versace, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Versace, bringing effortless daytime radiance."}'::jsonb,
  329,
  'Zone VIP-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000061', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000061', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000061', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000061', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000061', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000061', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000062',
  'Crystal Noir',
  'Versace',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Versace, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Versace, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  346,
  'Zone A-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000062', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000062', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000062', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000062', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000062', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000062', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000062', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000063',
  'Donna Born In Roma Edp',
  'Valentino',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Valentino, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Valentino, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  363,
  'Zone B-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000063', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000063', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000063', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000063', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000063', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000063', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000064',
  'Donna Born In Roma Intense Edp',
  'Valentino',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Valentino, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Valentino, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  380,
  'Zone C-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000064', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000064', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000064', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000064', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000064', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000064', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000064', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000065',
  'Donna Born In Roma Coral Fantasy Edp',
  'Valentino',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Valentino, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Valentino, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  397,
  'Zone D-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000065', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000065', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000065', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000065', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000065', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000066',
  'Donna Born In Roma Green Stravaganza Edp',
  'Valentino',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Valentino, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Valentino, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  414,
  'Zone E-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000066', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000066', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000066', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000066', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000067',
  'Valentina Edp',
  'Valentino',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Valentino, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Valentino, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  431,
  'Zone F-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000067', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000067', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000067', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000067', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000067', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000067', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000067', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000068',
  'Valentina Assoluto Edp',
  'Valentino',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Valentino, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Valentino, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  448,
  'Zone VIP-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000068', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000068', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000068', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000068', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000068', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000068', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000068', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000069',
  'Valentina Pink Edp',
  'Valentino',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Valentino, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Valentino, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  465,
  'Zone A-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000069', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000069', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000069', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000069', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000069', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000006a',
  'Phantom',
  'Paco Rabanne',
  '{"ar":"توليفة أرستقراطية متوازنة من Paco Rabanne تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Paco Rabanne, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Paco Rabanne, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  182,
  'Zone B-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006a', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006a', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006a', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006a', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006a', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006a', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000006b',
  'Fame',
  'Paco Rabanne',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Paco Rabanne, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Paco Rabanne, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  199,
  'Zone C-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006b', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006b', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006b', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006b', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006b', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006b', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006b', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000006c',
  'Invictus Victory Elixir',
  'Paco Rabanne',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Paco Rabanne, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  216,
  'Zone D-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006c', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006c', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006c', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006c', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006c', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006c', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000006d',
  'Invictus Legend',
  'Paco Rabanne',
  '{"ar":"توليفة خشبية حارة آسرة من Paco Rabanne تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Paco Rabanne, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Paco Rabanne, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  233,
  'Zone E-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006d', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006d', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006d', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006d', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006d', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006d', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000006e',
  'Invictus Platinum',
  'Paco Rabanne',
  '{"ar":"توليفة أرستقراطية متوازنة من Paco Rabanne تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Paco Rabanne, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Paco Rabanne, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  250,
  'Zone F-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006e', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006e', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006e', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006e', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006e', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000006f',
  'Lady Million',
  'Paco Rabanne',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Paco Rabanne, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Paco Rabanne, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  267,
  'Zone VIP-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006f', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006f', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006f', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006f', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006f', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006f', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000006f', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000070',
  '1 Million Eau De Toilette',
  'Paco Rabanne',
  '{"ar":"توليفة خشبية حارة آسرة من Paco Rabanne تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Paco Rabanne, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Paco Rabanne, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  284,
  'Zone A-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000070', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000070', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000070', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000070', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000070', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000070', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000071',
  'Shalimar Eau De Parfum',
  'Guerlain',
  '{"ar":"توليفة عطرية متميزة من Guerlain تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Guerlain offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Guerlain delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  301,
  'Zone B-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000071', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000071', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000071', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000071', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000071', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000072',
  'Shalimar Souffle De Parfum',
  'Guerlain',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Guerlain, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Guerlain, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  318,
  'Zone C-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000072', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000072', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000072', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000072', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000072', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000072', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000072', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000073',
  'Shalimar Parfum Initial Eau De Parfum',
  'Guerlain',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Guerlain, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Guerlain, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  335,
  'Zone D-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000073', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000073', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000073', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000073', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000073', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000073', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000073', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000074',
  'Shalimar Cologne',
  'Guerlain',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Guerlain, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Guerlain, bringing effortless daytime radiance."}'::jsonb,
  352,
  'Zone E-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000074', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000074', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000074', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000074', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000074', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000075',
  'Mon Guerlain Eau De Parfum',
  'Guerlain',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Guerlain, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Guerlain, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  369,
  'Zone F-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000075', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000075', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000075', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000075', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000075', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000075', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000075', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000076',
  'Mon Guerlain Bloom Of Rose Eau De Parfum',
  'Guerlain',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Guerlain, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Guerlain, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  386,
  'Zone VIP-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000076', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000076', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000076', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000076', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000076', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000076', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000076', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000077',
  'Mon Guerlain Intense Eau De Parfum',
  'Guerlain',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Guerlain, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Guerlain, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  403,
  'Zone A-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000077', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000077', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000077', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000077', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000077', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000077', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000077', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000078',
  'Instant Crush',
  'Mancera',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Mancera, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Mancera, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  420,
  'Zone B-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000078', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000078', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000078', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000078', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000078', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000078', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000078', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000079',
  'Cedrat Boise',
  'Mancera',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Mancera, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Mancera, bringing effortless daytime radiance."}'::jsonb,
  437,
  'Zone C-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000079', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000079', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000079', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000079', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000079', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000079', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000007a',
  'Red Tobacco',
  'Mancera',
  '{"ar":"توليفة عطرية متميزة من Mancera تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Mancera offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Mancera delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  454,
  'Zone D-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007a', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007a', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007a', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007a', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000007b',
  'Black Vanilla',
  'Mancera',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Mancera, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  471,
  'Zone E-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007b', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007b', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007b', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007b', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007b', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007b', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000007c',
  'Feminity',
  'Mancera',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Mancera, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Mancera, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  188,
  'Zone F-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007c', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007c', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007c', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007c', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000007d',
  'Pearl',
  'Mancera',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Mancera, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Mancera, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  205,
  'Zone VIP-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007d', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007d', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007d', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007d', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000007e',
  'Velvet Vanilla',
  'Mancera',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Mancera, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Mancera, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  222,
  'Zone A-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007e', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007e', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007e', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007e', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007e', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007e', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007e', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000007f',
  'English Pear & Freesia Cologne',
  'Jo Malone',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Jo Malone, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Jo Malone, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  239,
  'Zone B-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007f', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007f', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007f', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007f', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000007f', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000080',
  'Peony & Blush Suede Cologne',
  'Jo Malone',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Jo Malone, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Jo Malone, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  256,
  'Zone C-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000080', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000080', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000080', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000080', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000081',
  'Lime Basil & Mandarin Cologne',
  'Jo Malone',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Jo Malone, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Jo Malone, bringing effortless daytime radiance."}'::jsonb,
  273,
  'Zone D-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000081', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000081', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000081', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000081', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000081', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000082',
  'Wood Sage & Sea Salt Cologne',
  'Jo Malone',
  '{"ar":"توليفة أرستقراطية متوازنة من Jo Malone تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Jo Malone, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Jo Malone, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  290,
  'Zone E-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000082', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000082', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000082', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000082', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000082', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000083',
  'Pomegranate Noir Cologne',
  'Jo Malone',
  '{"ar":"توليفة عطرية متميزة من Jo Malone تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Jo Malone offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Jo Malone delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  307,
  'Zone F-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000083', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000083', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000083', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000083', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000083', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000083', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000083', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000084',
  'Nectarine Blossom & Honey Cologne',
  'Jo Malone',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Jo Malone, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Jo Malone, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  324,
  'Zone VIP-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000084', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000084', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000084', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000084', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000084', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000085',
  'Red Roses Cologne',
  'Jo Malone',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Jo Malone, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Jo Malone, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  341,
  'Zone A-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000085', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000085', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000085', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000085', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000086',
  'Philosykos Eau De Toilette',
  'Diptyque',
  '{"ar":"توليفة عطرية متميزة من Diptyque تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Diptyque offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Diptyque delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  358,
  'Zone B-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000086', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000086', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000086', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000086', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000086', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000086', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000087',
  'Do Son Eau De Toilette',
  'Diptyque',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Diptyque, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Diptyque, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  375,
  'Zone C-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000087', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000087', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000087', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000087', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000088',
  'L''Ombre Dans L''Eau Eau De Toilette',
  'Diptyque',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Diptyque, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Diptyque, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  392,
  'Zone D-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000088', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000088', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000088', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000088', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000088', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000089',
  'Tubéreuse Eau De Toilette',
  'Diptyque',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Diptyque, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Diptyque, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  409,
  'Zone E-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000089', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000089', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000089', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000089', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000008a',
  'Eau Rose Eau De Toilette',
  'Diptyque',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Diptyque, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Diptyque, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  426,
  'Zone F-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008a', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008a', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008a', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008a', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000008b',
  'Fleur De Peau Eau De Parfum',
  'Diptyque',
  '{"ar":"إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.","fr":"Une harmonie florale orientale envoûtante signée Diptyque, mariant pétales de jasmin et ambre velouté séduisant.","en":"An alluring floriental masterpiece from Diptyque, marrying precious jasmine petals with a sumptuous amber trail."}'::jsonb,
  443,
  'Zone VIP-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008b', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008b', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008b', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008b', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008b', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008b', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008b', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000008c',
  'Volutes Eau De Parfum',
  'Diptyque',
  '{"ar":"توليفة عطرية متميزة من Diptyque تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Diptyque offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Diptyque delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  460,
  'Zone A-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008c', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008c', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008c', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008c', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008c', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000008d',
  'Chrome Edt',
  'Azzaro',
  '{"ar":"توليفة أرستقراطية متوازنة من Azzaro تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Azzaro, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Azzaro, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  477,
  'Zone B-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008d', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008d', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008d', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008d', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000008e',
  'Chrome Intense Edt',
  'Azzaro',
  '{"ar":"توليفة أرستقراطية متوازنة من Azzaro تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Azzaro, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Azzaro, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  194,
  'Zone C-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008e', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008e', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008e', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008e', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000008f',
  'Chrome Aqua Edt',
  'Azzaro',
  '{"ar":"توليفة أرستقراطية متوازنة من Azzaro تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Azzaro, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Azzaro, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  211,
  'Zone D-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008f', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008f', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008f', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000008f', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000090',
  'Chrome Extreme Edt',
  'Azzaro',
  '{"ar":"توليفة أرستقراطية متوازنة من Azzaro تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Azzaro, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Azzaro, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  228,
  'Zone E-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000090', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000090', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000090', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000090', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000091',
  'Chrome Azure Edt',
  'Azzaro',
  '{"ar":"توليفة أرستقراطية متوازنة من Azzaro تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Azzaro, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Azzaro, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  245,
  'Zone F-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000091', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000091', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000091', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000091', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000092',
  'Chrome Legend Edt',
  'Azzaro',
  '{"ar":"توليفة أرستقراطية متوازنة من Azzaro تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Azzaro, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Azzaro, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  262,
  'Zone VIP-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000092', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000092', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000092', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000092', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000093',
  'Chrome Sport Edt',
  'Azzaro',
  '{"ar":"توليفة أرستقراطية متوازنة من Azzaro تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Azzaro, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Azzaro, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  279,
  'Zone A-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000093', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000093', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000093', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000093', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000094',
  'Boss Bottled Edt',
  'Hugo Boss',
  '{"ar":"توليفة خشبية حارة آسرة من Hugo Boss تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Hugo Boss, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Hugo Boss, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  296,
  'Zone B-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000094', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000094', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000094', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000094', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000094', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000094', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000095',
  'Boss Bottled Edp',
  'Hugo Boss',
  '{"ar":"توليفة خشبية حارة آسرة من Hugo Boss تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Hugo Boss, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Hugo Boss, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  313,
  'Zone C-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000095', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000095', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000095', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000095', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000095', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000095', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000096',
  'Boss Bottled Infinite',
  'Hugo Boss',
  '{"ar":"توليفة أرستقراطية متوازنة من Hugo Boss تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Hugo Boss, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Hugo Boss, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  330,
  'Zone D-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000096', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000096', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000096', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000096', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000096', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000097',
  'Boss Bottled Tonic',
  'Hugo Boss',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Hugo Boss, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Hugo Boss, bringing effortless daytime radiance."}'::jsonb,
  347,
  'Zone E-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000097', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000097', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000097', '00000001-0000-4000-8000-00000000000f')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000097', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000097', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000097', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000098',
  'Boss The Scent Edt',
  'Hugo Boss',
  '{"ar":"توليفة عطرية متميزة من Hugo Boss تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Hugo Boss offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Hugo Boss delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  364,
  'Zone F-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000098', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000098', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000098', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000098', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000098', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000098', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-000000000099',
  'Boss The Scent Intense Edp',
  'Hugo Boss',
  '{"ar":"توليفة عطرية متميزة من Hugo Boss تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Hugo Boss offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Hugo Boss delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  381,
  'Zone VIP-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000099', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000099', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000099', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000099', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000099', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-000000000099', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000009a',
  'Hugo Man Edt',
  'Hugo Boss',
  '{"ar":"توليفة عطرية متميزة من Hugo Boss تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Hugo Boss offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Hugo Boss delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  398,
  'Zone A-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009a', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009a', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009a', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009a', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000009b',
  'Legend Edt',
  'Montblanc',
  '{"ar":"توليفة أرستقراطية متوازنة من Montblanc تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Montblanc, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Montblanc, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  415,
  'Zone B-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009b', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009b', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009b', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009b', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000009c',
  'Legend Edp',
  'Montblanc',
  '{"ar":"توليفة أرستقراطية متوازنة من Montblanc تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Montblanc, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Montblanc, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  432,
  'Zone C-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009c', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009c', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009c', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009c', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009c', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000009d',
  'Legend Spirit',
  'Montblanc',
  '{"ar":"توليفة أرستقراطية متوازنة من Montblanc تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Montblanc, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Montblanc, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  449,
  'Zone D-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009d', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009d', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009d', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009d', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009d', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000009e',
  'Legend Blue',
  'Montblanc',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Montblanc, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Montblanc, bringing effortless daytime radiance."}'::jsonb,
  466,
  'Zone E-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009e', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009e', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009e', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009e', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-00000000009f',
  'Legend Red',
  'Montblanc',
  '{"ar":"توليفة عطرية متميزة من Montblanc تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Montblanc offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Montblanc delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  183,
  'Zone F-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009f', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009f', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009f', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009f', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009f', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-00000000009f', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a0',
  'Legend Night',
  'Montblanc',
  '{"ar":"توليفة أرستقراطية متوازنة من Montblanc تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Montblanc, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Montblanc, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  200,
  'Zone VIP-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a0', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a0', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a0', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a0', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a0', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a1',
  'Explorer',
  'Montblanc',
  '{"ar":"توليفة أرستقراطية متوازنة من Montblanc تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Montblanc, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Montblanc, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  217,
  'Zone A-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a1', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a1', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a1', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a1', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a1', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a2',
  'Abaan',
  'Lattafa',
  '{"ar":"توليفة حصرية من دار Lattafa ذات أبعاد عطرية فريدة بانتظار استكمال التقييم الحسي وتحديد النغمات التفصيلية.","fr":"Création exclusive de Lattafa offrant un profil captivant en attente de validation sensorielle approfondie.","en":"An exclusive olfactory creation by Lattafa featuring intriguing facets awaiting detailed sensory evaluation."}'::jsonb,
  234,
  'Zone B-07',
  true,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a2', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a2', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a3',
  'Adeeb',
  'Lattafa',
  '{"ar":"توليفة حصرية من دار Lattafa ذات أبعاد عطرية فريدة بانتظار استكمال التقييم الحسي وتحديد النغمات التفصيلية.","fr":"Création exclusive de Lattafa offrant un profil captivant en attente de validation sensorielle approfondie.","en":"An exclusive olfactory creation by Lattafa featuring intriguing facets awaiting detailed sensory evaluation."}'::jsonb,
  251,
  'Zone C-08',
  true,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a3', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a3', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a4',
  'Afeef',
  'Lattafa',
  '{"ar":"توليفة حصرية من دار Lattafa ذات أبعاد عطرية فريدة بانتظار استكمال التقييم الحسي وتحديد النغمات التفصيلية.","fr":"Création exclusive de Lattafa offrant un profil captivant en attente de validation sensorielle approfondie.","en":"An exclusive olfactory creation by Lattafa featuring intriguing facets awaiting detailed sensory evaluation."}'::jsonb,
  268,
  'Zone D-09',
  true,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a4', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a4', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a5',
  'Afkaar',
  'Lattafa',
  '{"ar":"توليفة حصرية من دار Lattafa ذات أبعاد عطرية فريدة بانتظار استكمال التقييم الحسي وتحديد النغمات التفصيلية.","fr":"Création exclusive de Lattafa offrant un profil captivant en attente de validation sensorielle approfondie.","en":"An exclusive olfactory creation by Lattafa featuring intriguing facets awaiting detailed sensory evaluation."}'::jsonb,
  285,
  'Zone E-10',
  true,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a5', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a5', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a6',
  'Al Awsaaf',
  'Lattafa',
  '{"ar":"توليفة حصرية من دار Lattafa ذات أبعاد عطرية فريدة بانتظار استكمال التقييم الحسي وتحديد النغمات التفصيلية.","fr":"Création exclusive de Lattafa offrant un profil captivant en attente de validation sensorielle approfondie.","en":"An exclusive olfactory creation by Lattafa featuring intriguing facets awaiting detailed sensory evaluation."}'::jsonb,
  302,
  'Zone F-11',
  true,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a6', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a6', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a7',
  'Al Azal',
  'Lattafa',
  '{"ar":"توليفة حصرية من دار Lattafa ذات أبعاد عطرية فريدة بانتظار استكمال التقييم الحسي وتحديد النغمات التفصيلية.","fr":"Création exclusive de Lattafa offrant un profil captivant en attente de validation sensorielle approfondie.","en":"An exclusive olfactory creation by Lattafa featuring intriguing facets awaiting detailed sensory evaluation."}'::jsonb,
  319,
  'Zone VIP-12',
  true,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a7', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a7', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a8',
  'Al Dur Al Maknoon Gold',
  'Lattafa',
  '{"ar":"توليفة حصرية من دار Lattafa ذات أبعاد عطرية فريدة بانتظار استكمال التقييم الحسي وتحديد النغمات التفصيلية.","fr":"Création exclusive de Lattafa offrant un profil captivant en attente de validation sensorielle approfondie.","en":"An exclusive olfactory creation by Lattafa featuring intriguing facets awaiting detailed sensory evaluation."}'::jsonb,
  336,
  'Zone A-01',
  true,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a8', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a8', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000a9',
  'Amber Oud Aqua Dubai',
  'Al Haramain',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Al Haramain, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Al Haramain, bringing effortless daytime radiance."}'::jsonb,
  353,
  'Zone B-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a9', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a9', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a9', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a9', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a9', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a9', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000a9', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000aa',
  'Detour Noir',
  'Al Haramain',
  '{"ar":"توليفة خشبية حارة آسرة من Al Haramain تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Al Haramain, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Al Haramain, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  370,
  'Zone C-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000aa', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000aa', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000aa', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000aa', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000aa', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000aa', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000ab',
  'Detour Noir Intense',
  'Al Haramain',
  '{"ar":"توليفة خشبية حارة آسرة من Al Haramain تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Al Haramain, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Al Haramain, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  387,
  'Zone D-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ab', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ab', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ab', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ab', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ab', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ab', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000ac',
  'Detour Eco',
  'Al Haramain',
  '{"ar":"توليفة أرستقراطية متوازنة من Al Haramain تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Al Haramain, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Al Haramain, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  404,
  'Zone E-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ac', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ac', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ac', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ac', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ac', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000ad',
  'Detour Rouge',
  'Al Haramain',
  '{"ar":"توليفة خشبية حارة آسرة من Al Haramain تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Al Haramain, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Al Haramain, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  421,
  'Zone F-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ad', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ad', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ad', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ad', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ad', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ad', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000ae',
  '9 Am Dive',
  'Afnan',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Afnan, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Afnan, bringing effortless daytime radiance."}'::jsonb,
  438,
  'Zone VIP-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ae', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ae', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ae', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ae', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000af',
  '9 Am Pour Femme',
  'Afnan',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Afnan, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Afnan, bringing effortless daytime radiance."}'::jsonb,
  455,
  'Zone A-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000af', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000af', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000af', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000af', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b0',
  '9 Am Pour Homme',
  'Afnan',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Afnan, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Afnan, bringing effortless daytime radiance."}'::jsonb,
  472,
  'Zone B-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b0', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b0', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b0', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b0', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b1',
  '9 Pm',
  'Afnan',
  '{"ar":"توليفة عطرية متميزة من Afnan تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Afnan offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Afnan delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  189,
  'Zone C-10',
  true,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b1', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b1', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b2',
  '9 Pm Rebel',
  'Afnan',
  '{"ar":"توليفة عطرية متميزة من Afnan تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Afnan offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Afnan delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  206,
  'Zone D-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b2', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b2', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b2', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b2', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b2', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b2', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b3',
  'Cherry Bouquet',
  'Afnan',
  '{"ar":"نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.","fr":"Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.","en":"An indulgent oriental gourmand by Afnan, blending Madagascar vanilla, roasted tonka, and radiant golden amber."}'::jsonb,
  223,
  'Zone E-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b3', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b3', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b3', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b3', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b4',
  'Abstract Portrait',
  'Afnan',
  '{"ar":"توليفة أرستقراطية متوازنة من Afnan تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Afnan, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Afnan, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  240,
  'Zone F-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b4', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b4', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b4', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b4', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b4', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b4', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b4', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b4', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b5',
  'Kuro',
  'Ajmal',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Ajmal, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Ajmal, bringing effortless daytime radiance."}'::jsonb,
  257,
  'Zone VIP-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b5', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b5', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b5', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b5', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b6',
  'Blue',
  'Ajmal',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Ajmal, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Ajmal, bringing effortless daytime radiance."}'::jsonb,
  274,
  'Zone A-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b6', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b6', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b6', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b6', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b7',
  'Shiro',
  'Ajmal',
  '{"ar":"توليفة عطرية متميزة من Ajmal تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Ajmal offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Ajmal delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  291,
  'Zone B-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b7', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b7', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b7', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b7', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b7', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b7', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b8',
  'Rain Drops',
  'Ajmal',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Ajmal, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Ajmal, bringing effortless daytime radiance."}'::jsonb,
  308,
  'Zone C-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b8', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b8', '00000001-0000-4000-8000-00000000000d')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b8', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b8', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000b9',
  'Wisal Dahab',
  'Ajmal',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Ajmal, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Ajmal, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  325,
  'Zone D-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b9', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b9', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b9', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b9', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b9', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b9', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000b9', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000ba',
  'Evoke For Him',
  'Ajmal',
  '{"ar":"توليفة عطرية متميزة من Ajmal تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Ajmal offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Ajmal delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  342,
  'Zone E-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ba', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ba', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ba', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000ba', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000bb',
  'Blu',
  'Ajmal',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Ajmal, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Ajmal, bringing effortless daytime radiance."}'::jsonb,
  359,
  'Zone F-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bb', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bb', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bb', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bb', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bb', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bb', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000bc',
  'Shaghaf (Nafaies Al Shaghaf)',
  'Rasasi',
  '{"ar":"توليفة عطرية متميزة من Rasasi تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.","fr":"Une création équilibrée de Rasasi offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.","en":"A distinctive fragrance by Rasasi delivering a masterfully balanced scent profile tailored for refined tastes."}'::jsonb,
  376,
  'Zone VIP-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bc', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bc', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bc', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bc', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bc', '00000001-0000-4000-8000-000000000011')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bc', '00000001-0000-4000-8000-000000000009')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000bd',
  'Shuhrah',
  'Rasasi',
  '{"ar":"توليفة خشبية حارة آسرة من Rasasi تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Rasasi, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Rasasi, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  393,
  'Zone A-10',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bd', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bd', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bd', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bd', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bd', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bd', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000be',
  'Sotoor Seen',
  'Rasasi',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Rasasi, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Rasasi, bringing effortless daytime radiance."}'::jsonb,
  410,
  'Zone B-11',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000be', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000be', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000be', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000be', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000be', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000be', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000bf',
  'Sotoor Taa',
  'Rasasi',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Rasasi, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Rasasi, bringing effortless daytime radiance."}'::jsonb,
  427,
  'Zone C-12',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bf', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bf', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bf', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000bf', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c0',
  'Sotoor Waaw',
  'Rasasi',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Rasasi, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Rasasi, bringing effortless daytime radiance."}'::jsonb,
  444,
  'Zone D-01',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c0', '00000001-0000-4000-8000-000000000003')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c0', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c0', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c0', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c0', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c0', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c1',
  'Hawas Tropical',
  'Rasasi',
  '{"ar":"انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.","fr":"Une bouffée d’air pur hespéridée et aquatique par Rasasi, évoquant la fraîcheur marine et l’élégance solaire.","en":"A vibrant rush of Mediterranean citrus and marine breeze by Rasasi, bringing effortless daytime radiance."}'::jsonb,
  461,
  'Zone E-02',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c1', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c1', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c1', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c1', '00000001-0000-4000-8000-00000000000b')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c1', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c2',
  'Club De Nuit Intense Man',
  'Armaf',
  '{"ar":"توليفة خشبية حارة آسرة من Armaf تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Armaf, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Armaf, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  478,
  'Zone F-03',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c2', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c2', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c2', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c2', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c2', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c2', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c3',
  'Cdnim Pure Parfum',
  'Armaf',
  '{"ar":"توليفة خشبية حارة آسرة من Armaf تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Armaf, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Armaf, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  195,
  'Zone VIP-04',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c3', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c3', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c3', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c3', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c3', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c3', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c4',
  'Cdnim Edp',
  'Armaf',
  '{"ar":"توليفة خشبية حارة آسرة من Armaf تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Armaf, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Armaf, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  212,
  'Zone A-05',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c4', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c4', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c4', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c4', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c4', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c4', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c5',
  'Cdnim Limited Edition',
  'Armaf',
  '{"ar":"توليفة خشبية حارة آسرة من Armaf تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.","fr":"Une composition boisée et épicée remarquable par Armaf, unissant la chaleur des épices nobles au cèdre raffiné.","en":"A commanding woody-spicy fragrance by Armaf, uniting warm noble spices with deep, enduring cedar accords."}'::jsonb,
  229,
  'Zone B-06',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c5', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c5', '00000001-0000-4000-8000-00000000000e')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c5', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c5', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c5', '00000001-0000-4000-8000-000000000014')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c5', '00000001-0000-4000-8000-000000000005')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c6',
  'Cdn Women',
  'Armaf',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Armaf, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Armaf, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  246,
  'Zone C-07',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c6', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c6', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c6', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c6', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c6', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c7',
  'Lionheart Man',
  'Armaf',
  '{"ar":"توليفة أرستقراطية متوازنة من Armaf تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.","fr":"Une élégance fougère intemporelle signée Armaf, fusionnant la fraîcheur de la lavande à la noblesse des bois.","en":"A timeless aromatic fougère by Armaf, blending crisp lavender and herbs over an authoritative woody foundation."}'::jsonb,
  263,
  'Zone D-08',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c7', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c7', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c7', '00000001-0000-4000-8000-000000000010')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c7', '00000001-0000-4000-8000-000000000006')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c7', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfumes (id, name, brand, description, price, shelf_location, is_available, is_featured, is_draft)
VALUES (
  '00000004-0000-4000-8000-0000000000c8',
  'Yum Yum',
  'Armaf',
  '{"ar":"باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.","fr":"Un bouquet floral raffiné et lumineux signé Armaf, célébrant la grâce naturelle et l’élégance intemporelle.","en":"A graceful floral bouquet by Armaf, radiating natural poise, delicate sweetness, and timeless romance."}'::jsonb,
  280,
  'Zone E-09',
  true,
  false,
  false
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  description = EXCLUDED.description,
  is_draft = EXCLUDED.is_draft;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c8', '00000001-0000-4000-8000-000000000001')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c8', '00000001-0000-4000-8000-000000000008')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c8', '00000001-0000-4000-8000-000000000012')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c8', '00000001-0000-4000-8000-000000000007')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;
INSERT INTO public.perfume_tags (perfume_id, tag_id)
VALUES ('00000004-0000-4000-8000-0000000000c8', '00000001-0000-4000-8000-000000000004')
ON CONFLICT (perfume_id, tag_id) DO NOTHING;