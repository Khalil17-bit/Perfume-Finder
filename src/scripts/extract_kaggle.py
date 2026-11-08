import os
import json
import re
import pandas as pd
import kagglehub

def clean_brand_name(raw: str) -> str:
    raw = str(raw).strip()
    brand_map = {
        'dumont': 'Dumont',
        'armaf': 'Armaf',
        'paris corner': 'Paris Corner',
        'fragrance world': 'Fragrance World',
        'xerjoff': 'Xerjoff',
        'rasasi': 'Rasasi',
        'riffs': 'Riffs',
        'al haramain': 'Al Haramain',
        'ajmal': 'Ajmal',
        'dirham': 'Dirham',
        'nusuk': 'Nusuk',
        'ard al zaafaran': 'Ard Al Zaafaran',
        'hamidi': 'Hamidi',
        'ibraheem al qurashi': 'Ibraheem Al Qurashi',
        'rue broca': 'Rue Broca',
        'swiss arabian': 'Swiss Arabian',
        'my perfumes': 'My Perfumes',
        'sheikh zayed': 'Sheikh Zayed',
        'al wataniah': 'Al Wataniah',
        'insurrection': 'Insurrection',
        'al rehab': 'Al Rehab',
        'zimaya': 'Zimaya',
        'khadlj': 'Khadlaj',
        'herms': 'Hermès',
        'hermès': 'Hermès',
        'dior': 'Dior',
        'creed': 'Creed',
        'louis vuitton': 'Louis Vuitton',
        'tom ford': 'Tom Ford',
        'jean paul gaultier': 'Jean Paul Gaultier',
        'yves saint laurent': 'Yves Saint Laurent',
        'giorgio armani': 'Giorgio Armani',
        'parfums de marly': 'Parfums de Marly',
        'prada': 'Prada',
        'dolce & gabbana': 'Dolce & Gabbana',
        'carolina herrera': 'Carolina Herrera',
        'versace': 'Versace',
        'valentino': 'Valentino',
        'paco rabanne': 'Paco Rabanne',
        'guerlain': 'Guerlain',
        'mancera': 'Mancera',
        'jo malone': 'Jo Malone',
        'diptyque': 'Diptyque',
        'azzaro': 'Azzaro',
        'hugo boss': 'Hugo Boss',
        'montblanc': 'Montblanc',
        'lattafa': 'Lattafa',
        'afnan': 'Afnan',
        'maison alhambra': 'Maison Alhambra',
    }
    cleaned = brand_map.get(raw.lower())
    if cleaned:
        return cleaned
    return raw.title() if len(raw) < 20 else raw

def generate_sensory_description(name: str, brand: str, category: str, target: str, longevity: str):
    cat_lower = category.lower()
    
    # Check for unclassified / unknown
    if 'unknown' in cat_lower or not cat_lower or cat_lower == 'nan':
        return {
            'ar': f'توليفة حصرية من دار {brand} ذات أبعاد عطرية فريدة بانتظار استكمال التقييم الحسي وتحديد النغمات التفصيلية.',
            'fr': f'Création exclusive de {brand} offrant un profil captivant en attente de validation sensorielle approfondie.',
            'en': f'An exclusive olfactory creation by {brand} featuring intriguing facets awaiting detailed sensory evaluation.'
        }
    
    if any(k in cat_lower for k in ['woody spicy', 'spicy woody']):
        ar = f'توليفة خشبية حارة آسرة من {brand} تمزج بين دفء التوابل النبيلة وثبات أخشاب الأرز لإطلالة واثقة وجذابة.'
        fr = f'Une composition boisée et épicée remarquable par {brand}, unissant la chaleur des épices nobles au cèdre raffiné.'
        en = f'A commanding woody-spicy fragrance by {brand}, uniting warm noble spices with deep, enduring cedar accords.'
    elif any(k in cat_lower for k in ['woody aromatic', 'fougere', 'fougère']):
        ar = f'توليفة أرستقراطية متوازنة من {brand} تجمع بين نضارة اللافندر والأعشاب ونفحات الأخشاب الدافئة لحضور متألق.'
        fr = f'Une élégance fougère intemporelle signée {brand}, fusionnant la fraîcheur de la lavande à la noblesse des bois.'
        en = f'A timeless aromatic fougère by {brand}, blending crisp lavender and herbs over an authoritative woody foundation.'
    elif any(k in cat_lower for k in ['citrus', 'fresh', 'aquatic', 'marine']):
        ar = f'انفجار من الانتعاش المتوسطي المشرق بلمسات البرغموت والنفحات المائية، يمنحك حيوية ونقاء يدوم طوال اليوم.'
        fr = f'Une bouffée d’air pur hespéridée et aquatique par {brand}, évoquant la fraîcheur marine et l’élégance solaire.'
        en = f'A vibrant rush of Mediterranean citrus and marine breeze by {brand}, bringing effortless daytime radiance.'
    elif any(k in cat_lower for k in ['floriental', 'oriental floral', 'amber floral']):
        ar = f'إبداع شرقي زهري ساحر يفيض بأنوثة الورد والياسمين مع قاعدة عنبرية مخملية دافئة تأسر الحواس.'
        fr = f'Une harmonie florale orientale envoûtante signée {brand}, mariant pétales de jasmin et ambre velouté séduisant.'
        en = f'An alluring floriental masterpiece from {brand}, marrying precious jasmine petals with a sumptuous amber trail.'
    elif any(k in cat_lower for k in ['oriental vanilla', 'gourmand', 'amber']):
        ar = f'نفحات دافئة ومغرية من الفانيليا الفاخرة وحبوب التونكا المغلفة بالعنبر الذهبي لإحساس غامر بالجاذبية والفخامة.'
        fr = f'Une symphonie gourmande et sensuelle où la vanille Bourbon s’associe à l’ambre doré pour un sillage irrésistible.'
        en = f'An indulgent oriental gourmand by {brand}, blending Madagascar vanilla, roasted tonka, and radiant golden amber.'
    elif any(k in cat_lower for k in ['floral', 'fruity floral', 'chypre']):
        ar = f'باقة راقية من الأزهار النبيلة ولمسات الفواكه الرقيقة تعكس الأناقة الكلاسيكية والجمال الهادئ في كل لحظة.'
        fr = f'Un bouquet floral raffiné et lumineux signé {brand}, célébrant la grâce naturelle et l’élégance intemporelle.'
        en = f'A graceful floral bouquet by {brand}, radiating natural poise, delicate sweetness, and timeless romance.'
    elif any(k in cat_lower for k in ['oud', 'leather', 'dark']):
        ar = f'تحفة شرقية فاخرة تتوجها نفحات العود الملكي والجلود المدخنة لهيبة مطلقة وسحر لا يضاهى في المناسبات الكبرى.'
        fr = f'Un chef-d’œuvre oriental majestueux sublimé par le oud royal et des accords cuirés intenses pour les grandes occasions.'
        en = f'A majestic oriental signature from {brand}, enriched with royal oud and smoky leather for unforgettable grandeur.'
    else:
        ar = f'توليفة عطرية متميزة من {brand} تتناغم فيها النغمات العطرية لتقدم تجربة حسية فريدة تلائم شخصيتك الراقية.'
        fr = f'Une création équilibrée de {brand} offrant un voyage olfactif raffiné conçu pour sublimer chaque instant.'
        en = f'A distinctive fragrance by {brand} delivering a masterfully balanced scent profile tailored for refined tastes.'
        
    return {'ar': ar, 'fr': fr, 'en': en}

def map_accords_to_tags(category: str, target: str, longevity: str):
    cat_lower = str(category).lower()
    t_lower = str(target).lower()
    l_lower = str(longevity).lower()
    
    tags = []
    
    # 1. Gender tag
    if 'male' in t_lower or 'men' in t_lower:
        tags.append('tag_male')
    elif 'female' in t_lower or 'women' in t_lower:
        tags.append('tag_female')
    elif 'unisex' in t_lower:
        tags.append('tag_unisex')
    else:
        tags.append('tag_unisex')
        
    # 2. Longevity / Intensity
    if any(k in l_lower for k in ['strong', 'very strong', '6', '8']):
        tags.append('tag_strong')
    elif 'light' in l_lower:
        tags.append('tag_subtle')
    elif 'medium' in l_lower:
        tags.append('tag_daily')
        
    # 3. Category / Accords mapping
    if 'woody' in cat_lower:
        tags.extend(['tag_woody', 'tag_mysterious'])
    if 'spicy' in cat_lower:
        tags.extend(['tag_spicy', 'tag_warm'])
    if 'fougere' in cat_lower or 'fougère' in cat_lower:
        tags.extend(['tag_fresh', 'tag_woody', 'tag_daily'])
    if 'citrus' in cat_lower:
        tags.extend(['tag_citrus', 'tag_fresh', 'tag_summer'])
    if 'fresh' in cat_lower or 'aquatic' in cat_lower or 'marine' in cat_lower:
        tags.extend(['tag_fresh', 'tag_summer'])
    if 'aromatic' in cat_lower:
        tags.extend(['tag_fresh', 'tag_daily'])
    if 'floral' in cat_lower or 'floriental' in cat_lower:
        tags.extend(['tag_floral', 'tag_elegant'])
    if 'amber' in cat_lower or 'oriental' in cat_lower or 'vanilla' in cat_lower:
        tags.extend(['tag_amber', 'tag_warm', 'tag_evening'])
    if 'oud' in cat_lower:
        tags.extend(['tag_oud', 'tag_mysterious', 'tag_special'])
    if 'leather' in cat_lower:
        tags.extend(['tag_mysterious', 'tag_woody'])
    if 'fruity' in cat_lower:
        tags.extend(['tag_fresh', 'tag_floral'])
    if 'chypre' in cat_lower:
        tags.extend(['tag_elegant', 'tag_woody'])
        
    # Deduplicate preserving order
    unique_tags = list(dict.fromkeys(tags))
    
    # Descriptive tags are non-gender tags
    descriptive_tags = [t for t in unique_tags if t not in ['tag_male', 'tag_female', 'tag_unisex']]
    is_draft = len(descriptive_tags) < 2
    
    return unique_tags, is_draft

def main():
    print("Downloading / verifying Kaggle perfume dataset...")
    path = kagglehub.dataset_download('ayushghawana/perfume-dataset')
    csv_file = os.path.join(path, 'Perfumes_dataset.csv')
    
    if not os.path.exists(csv_file):
        raise FileNotFoundError(f"Could not find Perfumes_dataset.csv in {path}")
        
    df = pd.read_csv(csv_file)
    print(f"Loaded raw dataset with {len(df)} records.")
    
    df = df[df['perfume'].astype(str).str.strip() != '']
    df = df[df['brand'].astype(str).str.strip().str.lower() != 'brand']
    
    df['brand_clean'] = df['brand'].apply(clean_brand_name)
    df['perfume_clean'] = df['perfume'].apply(lambda s: str(s).strip().title())
    
    priority_brands = [
        'Dior', 'Creed', 'Louis Vuitton', 'Tom Ford', 'Jean Paul Gaultier',
        'Yves Saint Laurent', 'Giorgio Armani', 'Parfums de Marly', 'Xerjoff',
        'Prada', 'Hermès', 'Dolce & Gabbana', 'Carolina Herrera',
        'Versace', 'Valentino', 'Paco Rabanne', 'Guerlain', 'Mancera',
        'Jo Malone', 'Diptyque', 'Azzaro', 'Hugo Boss', 'Montblanc',
        'Lattafa', 'Al Haramain', 'Afnan', 'Ajmal', 'Rasasi', 'Armaf',
        'Dumont', 'Paris Corner', 'Maison Alhambra'
    ]
    
    selected_parts = []
    for brand in priority_brands:
        sub = df[df['brand_clean'].str.lower() == brand.lower()]
        take = min(len(sub), 7)
        if take > 0:
            selected_parts.append(sub.head(take))
            
    res_df = pd.concat(selected_parts).drop_duplicates(subset=['brand_clean', 'perfume_clean'])
    if len(res_df) < 200:
        remaining = df[~df.index.isin(res_df.index)]
        res_df = pd.concat([res_df, remaining.head(200 - len(res_df))])
    elif len(res_df) > 200:
        res_df = res_df.head(200)
        
    print(f"Selected {len(res_df)} balanced luxury & prestige perfumes.")
    
    perfumes_data = []
    shelf_letters = ['A', 'B', 'C', 'D', 'E', 'F', 'VIP']
    
    draft_count = 0
    for idx, (_, row) in enumerate(res_df.iterrows(), start=1):
        brand = row['brand_clean']
        name = row['perfume_clean']
        cat = str(row['category']).strip()
        target = str(row['target_audience']).strip()
        longevity = str(row['longevity']).strip()
        
        tags, is_draft = map_accords_to_tags(cat, target, longevity)
        if is_draft:
            draft_count += 1
            
        desc = generate_sensory_description(name, brand, cat, target, longevity)
        
        shelf_sec = shelf_letters[idx % len(shelf_letters)]
        shelf_num = (idx % 12) + 1
        shelf_location = f"Zone {shelf_sec}-{shelf_num:02d}"
        
        price = 180 + ((idx * 17) % 300)
        is_featured = idx <= 15
        
        perfumes_data.append({
            'id': f"kgl_perfume_{idx:03d}",
            'name': f"{name}",
            'brand': f"{brand}",
            'category': cat,
            'target_audience': target,
            'longevity': longevity,
            'description': desc,
            'price': price,
            'shelf_location': shelf_location,
            'is_available': True,
            'is_featured': is_featured,
            'is_draft': is_draft,
            'tags': tags,
        })
        
    output_path = os.path.join(os.path.dirname(__file__), 'kaggle-200.json')
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(perfumes_data, f, ensure_ascii=False, indent=2)
        
    print(f"Successfully generated {output_path} with {len(perfumes_data)} perfumes.")
    print(f"Drafts flagged for merchant review (< 2 descriptive tags): {draft_count}")

if __name__ == '__main__':
    main()
