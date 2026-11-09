'use client';

import { useEffect, useState, useRef, useCallback } from 'react';
import { useRouter } from '@/i18n/routing';
import { useQuizStore } from '@/lib/store/useQuizStore';

const SCENT_PROFILES: Record<
  string,
  {
    name: string;
    family: string;
    concentration: string;
    sillage: string;
    longevity: string;
    top: string[];
    heart: string[];
    base: string[];
  }
> = {
  lava: {
    name: 'LAVA — Bella Vita',
    family: 'Oriental Amber Velvet',
    concentration: 'Eau de Parfum (24% Essence Concentration)',
    sillage: 'Radiant & Magnetic (Leaves a 2-meter sensual wake)',
    longevity: '12–14 Hours on skin, 48 hours on cashmere',
    top: ['Black Plum Noir', 'Calabrian Bergamot', 'Pink Peppercorn'],
    heart: ['Tuscan Iris Concrete', 'Midnight Violet Leaves', 'Atlas Frankincense'],
    base: ['Madagascar Bourbon Vanilla', 'Smoked Amber Resin', 'Cashmere Musk', 'Atlas Cedar'],
  },
  sahara: {
    name: 'SAHARA NOIR',
    family: 'Smoky Leather & Royal Oud',
    concentration: 'Extrait de Parfum (30% Essence Concentration)',
    sillage: 'Commanding Beast-Mode (Assertive room presence)',
    longevity: '16+ Hours on skin',
    top: ['Royal Saffron', 'Bitter Almond', 'Cardamom Pods'],
    heart: ['Tanned Leather', 'Atlas Cedarwood', 'Smoked Birch'],
    base: ['Cambodian Dark Oud', 'Ambergris Accord', 'Saharan Resins'],
  },
  jardin: {
    name: 'JARDIN D’ALGER',
    family: 'Solar Mediterranean Citrus & Fig',
    concentration: 'Eau de Parfum (20% Essence Concentration)',
    sillage: 'Airy & Luminous (Fresh coastal projection)',
    longevity: '8–10 Hours on skin',
    top: ['Green Fig Leaf', 'Calabrian Bergamot', 'Mandarin Zest'],
    heart: ['Orange Blossom Petals', 'Neroli', 'Saline Marine Mist'],
    base: ['Haitian Vetiver', 'Sunlit Amber', 'White Cedar'],
  },
  rose: {
    name: 'ROSE DES SABLES',
    family: 'Silky Rose & Cashmere Musk',
    concentration: 'Extrait de Parfum (28% Essence Concentration)',
    sillage: 'Sensual & Harmonious (Intoxicating floral trail)',
    longevity: '12 Hours on skin',
    top: ['Pink Pepper', 'Sparkling Lychee', 'Italian Tangerine'],
    heart: ['Damask Rose Absolue', 'White Peony', 'Cashmere Woods'],
    base: ['Silk Musk', 'Golden Amber', 'Sandalwood Embers'],
  },
  atlas: {
    name: 'N° 05 • ATLAS CÈDRE BLEU',
    family: 'Woody & Oud Architecture',
    concentration: 'Extrait de Parfum (26% Essence Concentration)',
    sillage: 'Majestic & Noble (Crisp high-altitude cedar sillage)',
    longevity: '14–16 Hours on skin',
    top: ['Atlas Cedarwood', 'Wild Cardamom', 'Blue Juniper Berry'],
    heart: ['Moroccan Thuja', 'Pine Resin', 'Nutmeg Essence'],
    base: ['Haitian Vetiver', 'Smoked Birch', 'Mineral Moss'],
  },
  emeraude: {
    name: 'N° 06 • ÉMERAUDE DU SAHARA',
    family: 'Mediterranean Fresh & Oasis Green',
    concentration: 'Eau de Parfum (22% Essence Concentration)',
    sillage: 'Vibrant & Refreshing (Aromatic mint & cypress projection)',
    longevity: '10–12 Hours on skin',
    top: ['Fresh Mint Leaf', 'Sicilian Bergamot', 'Green Cypress'],
    heart: ['Smoked Frankincense', 'Black Tea Infusion', 'Neroli Water'],
    base: ['Desert Amber', 'Oakmoss', 'Cedar Needles'],
  },
  ambre: {
    name: 'N° 07 • AMBRE IMPÉRIAL',
    family: 'Velvet Amber Royal',
    concentration: 'Extrait de Parfum (30% Essence Concentration)',
    sillage: 'Opulent & Enveloping (Hypnotic warm resinous cloud)',
    longevity: '18+ Hours on skin, days on outerwear',
    top: ['Golden Ambergris', 'Blood Mandarin', 'Coriander Seed'],
    heart: ['Damask Rose', 'Roasted Tonka Bean', 'Cistus Labdanum'],
    base: ['Benzoin Tears', 'Bourbon Vanilla Bean', 'Patchouli Heart'],
  },
  cuir: {
    name: 'N° 08 • CUIR ROYAL DE TLEMCEN',
    family: 'Woody & Oud / Andalusian Leather',
    concentration: 'Extrait de Parfum (32% Essence Concentration)',
    sillage: 'Intense Aristocratic Presence (Sensual smoky leather aura)',
    longevity: '16–20 Hours on skin',
    top: ['Bitter Almond', 'Saffron Thread', 'Thyme Herb'],
    heart: ['Vintage Andalusian Leather', 'Smoked Birch', 'Orris Root'],
    base: ['Labdanum Resin', 'Dark Oud', 'Spanish Cistus'],
  },
  zellige: {
    name: "N° 09 • ZELLIGE D'OR",
    family: 'Woody & Oud / Imperial Floral Saffron',
    concentration: 'Extrait de Parfum (32% Essence Concentration)',
    sillage: 'Opulent & Enveloping (Royal ceremonial presence)',
    longevity: '18+ Hours on skin, 48 hours on fabrics',
    top: ['Tlemcen Bitter Orange Blossom', 'Golden Saffron Threads', 'Cardamom Nectar'],
    heart: ['Imperial Cambodian Oud', 'Smoked Atlas Cedar', 'Wild Mountain Thyme'],
    base: ['Ambergris Accord', 'Warm Wild Honeycomb', 'Cashmere Musk', 'Dark Resins'],
  },
  nuit: {
    name: "N° 10 • NUIT D'ALGER",
    family: 'Damask Florals / Midnight Jasmine & Heliotrope',
    concentration: 'Eau de Parfum (22% Essence Concentration)',
    sillage: 'Mysterious & Intimate (Soft sensual nighttime wake)',
    longevity: '12–14 Hours on skin',
    top: ['Star Night-Blooming Jasmine', 'Calabrian Bergamot', 'Wild Pink Pepper'],
    heart: ['Heliotrope Nectar', 'Damascena Rose Absolute', 'White Iris Petals'],
    base: ['Cashmere Wood', 'Bourbon Vanilla Infusion', 'Velvet Silk Musk'],
  },
  mitidja: {
    name: 'N° 11 • FLEUR DE MITIDJA',
    family: 'Mediterranean Fresh / Solar Neroli & Citrus',
    concentration: 'Eau de Parfum (20% Essence Concentration)',
    sillage: 'Luminous & Invigorating (Fresh coastal citrus projection)',
    longevity: '10–12 Hours on skin',
    top: ['Mitidja Bitter Orange Neroli', 'Green Mandarin', 'Petitgrain Bigarade'],
    heart: ['Sea Salt Coastal Breeze', 'Orange Blossom Absolute', 'Crushed Fig Leaf'],
    base: ['White Atlas Cedar', 'Sunlit Golden Amber', 'Sheer Silk Musk'],
  },
  dune: {
    name: 'N° 12 • DUNE VANILLÉE',
    family: 'Velvet Amber / Smoked Vanilla & Roasted Moka',
    concentration: 'Extrait de Parfum (28% Essence Concentration)',
    sillage: 'Warm & Hypnotic (Delicious addictive amber trail)',
    longevity: '16+ Hours on skin',
    top: ['Roasted Algerian Moka Coffee', 'Bitter Almond Essence', 'Cinnamon Bark'],
    heart: ['Smoked Bourbon Vanilla Pods', 'Night Orchid Petals', 'Praline Nectar'],
    base: ['Golden Amber Resin', 'New Caledonian Sandalwood', 'Dark Cocoa Butter'],
  },
};

const WILAYAS = [
  { code: 1, name: '01 - Adrar', fee: 1100 },
  { code: 2, name: '02 - Chlef', fee: 600 },
  { code: 3, name: '03 - Laghouat', fee: 700 },
  { code: 4, name: '04 - Oum El Bouaghi', fee: 650 },
  { code: 5, name: '05 - Batna', fee: 650 },
  { code: 6, name: '06 - Béjaïa', fee: 600 },
  { code: 7, name: '07 - Biskra', fee: 750 },
  { code: 8, name: '08 - Béchar', fee: 850 },
  { code: 9, name: '09 - Blida', fee: 500 },
  { code: 10, name: '10 - Bouira', fee: 550 },
  { code: 11, name: '11 - Tamanrasset', fee: 1100 },
  { code: 12, name: '12 - Tébessa', fee: 700 },
  { code: 13, name: '13 - Tlemcen', fee: 650 },
  { code: 14, name: '14 - Tiaret', fee: 650 },
  { code: 15, name: '15 - Tizi Ouzou', fee: 550 },
  { code: 16, name: '16 - Alger (Algiers)', fee: 400 },
  { code: 17, name: '17 - Djelfa', fee: 650 },
  { code: 18, name: '18 - Jijel', fee: 600 },
  { code: 19, name: '19 - Sétif', fee: 600 },
  { code: 20, name: '20 - Saïda', fee: 650 },
  { code: 21, name: '21 - Skikda', fee: 600 },
  { code: 22, name: '22 - Sidi Bel Abbès', fee: 650 },
  { code: 23, name: '23 - Annaba', fee: 600 },
  { code: 24, name: '24 - Guelma', fee: 650 },
  { code: 25, name: '25 - Constantine', fee: 600 },
  { code: 26, name: '26 - Médéa', fee: 500 },
  { code: 27, name: '27 - Mostaganem', fee: 600 },
  { code: 28, name: "28 - M'Sila", fee: 650 },
  { code: 29, name: '29 - Mascara', fee: 650 },
  { code: 30, name: '30 - Ouargla (Hassi Messaoud)', fee: 850 },
  { code: 31, name: '31 - Oran', fee: 600 },
  { code: 32, name: '32 - El Bayadh', fee: 750 },
  { code: 33, name: '33 - Illizi', fee: 1100 },
  { code: 34, name: '34 - Bordj Bou Arreridj', fee: 600 },
  { code: 35, name: '35 - Boumerdès', fee: 500 },
  { code: 36, name: '36 - El Tarf', fee: 650 },
  { code: 37, name: '37 - Tindouf', fee: 1100 },
  { code: 38, name: '38 - Tissemsilt', fee: 650 },
  { code: 39, name: '39 - El Oued', fee: 800 },
  { code: 40, name: '40 - Khenchela', fee: 700 },
  { code: 41, name: '41 - Souk Ahras', fee: 700 },
  { code: 42, name: '42 - Tipaza', fee: 500 },
  { code: 43, name: '43 - Mila', fee: 650 },
  { code: 44, name: '44 - Aïn Defla', fee: 550 },
  { code: 45, name: '45 - Naâma', fee: 800 },
  { code: 46, name: '46 - Aïn Témouchent', fee: 600 },
  { code: 47, name: '47 - Ghardaïa', fee: 800 },
  { code: 48, name: '48 - Relizane', fee: 600 },
  { code: 49, name: '49 - Timimoun', fee: 1100 },
  { code: 50, name: '50 - Bordj Badji Mokhtar', fee: 1100 },
  { code: 51, name: '51 - Ouled Djellal', fee: 750 },
  { code: 52, name: '52 - Béni Abbès', fee: 1100 },
  { code: 53, name: '53 - In Salah', fee: 1100 },
  { code: 54, name: '54 - In Guezzam', fee: 1100 },
  { code: 55, name: '55 - Touggourt', fee: 800 },
  { code: 56, name: '56 - Djanet', fee: 1100 },
  { code: 57, name: "57 - El M'Ghair", fee: 800 },
  { code: 58, name: '58 - El Meniaa', fee: 850 },
];

interface ProductItem {
  id: string;
  category: string;
  name: string;
  subtitle: string;
  badge: string;
  badgeGold?: boolean;
  badgeHero?: boolean;
  isHeroDock?: boolean;
  image: string;
  notes: string[];
  searchNotes: string;
  priceDZD: number;
}

const PRODUCTS: ProductItem[] = [
  {
    id: 'sahara',
    category: 'woody-oud',
    name: 'SAHARA NOIR',
    subtitle: 'Smoky Atlas Cedar & Black Oud',
    badge: 'Extrait de Parfum',
    badgeGold: true,
    image: '/lava-assets/assets/sahara_bottle.webp',
    notes: ['Saffron', 'Black Oud', 'Smoked Leather'],
    searchNotes: 'Saffron Black Oud Smoked Leather Atlas Cedar Ambergris',
    priceDZD: 18500,
  },
  {
    id: 'lava',
    category: 'velvet-amber',
    name: 'LAVA — Bella Vita',
    subtitle: 'Sensual Plum Noir & Tuscan Iris',
    badge: 'Signature Flacon • 28% OFF',
    badgeHero: true,
    isHeroDock: true,
    image: '/lava-assets/assets/lava_bottle.webp',
    notes: ['Black Plum', 'Tuscan Iris', 'Bourbon Vanilla'],
    searchNotes: 'Black Plum Tuscan Iris Bourbon Vanilla Amber Resin Frankincense',
    priceDZD: 15120,
  },
  {
    id: 'jardin',
    category: 'mediterranean-fresh',
    name: "JARDIN D'ALGER",
    subtitle: 'Mediterranean Fig & Neroli Blossom',
    badge: 'Eau de Parfum',
    image: '/lava-assets/assets/emerald_bottle.webp',
    notes: ['Green Fig', 'Neroli', 'Sea Salt Mist'],
    searchNotes: 'Green Fig Neroli Sea Salt Mist Bergamot Orange Blossom Citrus',
    priceDZD: 16500,
  },
  {
    id: 'rose',
    category: 'damask-florals',
    name: 'ROSE DES SABLES',
    subtitle: 'Damask Rose & Cashmere Wood',
    badge: 'Extrait de Parfum',
    image: '/lava-assets/assets/rose_bottle.webp',
    notes: ['Damask Rose', 'Pink Pepper', 'Cashmere'],
    searchNotes: 'Damask Rose Pink Pepper Cashmere Musk White Peony Amber',
    priceDZD: 17800,
  },
  {
    id: 'atlas',
    category: 'woody-oud',
    name: 'N° 05 • ATLAS CÈDRE BLEU',
    subtitle: 'Atlas Cedarwood & Moroccan Thuja',
    badge: 'Extrait de Parfum',
    badgeGold: true,
    image: '/lava-assets/assets/azure_bottle.webp',
    notes: ['Atlas Cedarwood', 'Moroccan Thuja', 'Haitian Vetiver'],
    searchNotes: 'Atlas Cedarwood Moroccan Thuja Wild Cardamom Haitian Vetiver Cedar Juniper Pine',
    priceDZD: 17200,
  },
  {
    id: 'emeraude',
    category: 'mediterranean-fresh',
    name: 'N° 06 • ÉMERAUDE DU SAHARA',
    subtitle: 'Desert Cypress & Fresh Mint Leaf',
    badge: 'Eau de Parfum',
    image: '/lava-assets/assets/emerald_bottle.webp',
    notes: ['Desert Cypress', 'Fresh Mint Leaf', 'Black Tea'],
    searchNotes: 'Desert Cypress Fresh Mint Leaf Smoked Frankincense Black Tea Mint Cypress Neroli',
    priceDZD: 15400,
  },
  {
    id: 'ambre',
    category: 'velvet-amber damask-florals',
    name: 'N° 07 • AMBRE IMPÉRIAL',
    subtitle: 'Golden Ambergris & Roasted Tonka',
    badge: 'Extrait de Parfum',
    badgeGold: true,
    image: '/lava-assets/assets/lava_bottle.webp',
    notes: ['Golden Ambergris', 'Roasted Tonka', 'Damask Rose'],
    searchNotes: 'Golden Ambergris Roasted Tonka Bean Damask Rose Benzoin Tears Amber Tonka Vanilla',
    priceDZD: 18500,
  },
  {
    id: 'cuir',
    category: 'woody-oud',
    name: 'N° 08 • CUIR ROYAL DE TLEMCEN',
    subtitle: 'Vintage Andalusian Leather & Almond',
    badge: 'Extrait de Parfum',
    badgeGold: true,
    image: '/lava-assets/assets/sahara_bottle.webp',
    notes: ['Vintage Leather', 'Bitter Almond', 'Smoked Birch'],
    searchNotes: 'Vintage Andalusian Leather Bitter Almond Smoked Birch Labdanum Cuir Leather Oud',
    priceDZD: 17900,
  },
  {
    id: 'zellige',
    category: 'woody-oud',
    name: "N° 09 • ZELLIGE D'OR",
    subtitle: 'Imperial Oud & Golden Saffron',
    badge: 'Extrait de Parfum',
    badgeGold: true,
    image: '/lava-assets/assets/sahara_bottle.webp',
    notes: ['Imperial Oud', 'Golden Saffron', 'Orange Blossom'],
    searchNotes: 'Imperial Cambodian Oud Orange Blossom Golden Saffron Honeyed Cedar Sandalwood Amber Oud',
    priceDZD: 19800,
  },
  {
    id: 'nuit',
    category: 'damask-florals',
    name: "N° 10 • NUIT D'ALGER",
    subtitle: 'Midnight Jasmine & Cashmere Heliotrope',
    badge: 'Eau de Parfum',
    image: '/lava-assets/assets/rose_bottle.webp',
    notes: ['Midnight Jasmine', 'Heliotrope', 'Cashmere Wood'],
    searchNotes: 'Midnight Jasmine Cashmere Heliotrope Damask Rose White Iris Petals Bourbon Vanilla Florals',
    priceDZD: 16900,
  },
  {
    id: 'mitidja',
    category: 'mediterranean-fresh',
    name: 'N° 11 • FLEUR DE MITIDJA',
    subtitle: 'Mitidja Neroli & Sea Salt Petitgrain',
    badge: 'Eau de Parfum',
    image: '/lava-assets/assets/azure_bottle.webp',
    notes: ['Bitter Neroli', 'Petitgrain', 'Sea Salt Mist'],
    searchNotes: 'Bitter Neroli Blossom Sea Salt Petitgrain Green Mandarin Coastal Breeze White Musk Fresh',
    priceDZD: 15800,
  },
  {
    id: 'dune',
    category: 'velvet-amber',
    name: 'N° 12 • DUNE VANILLÉE',
    subtitle: 'Smoked Bourbon Vanilla & Roasted Moka',
    badge: 'Extrait de Parfum',
    badgeGold: true,
    image: '/lava-assets/assets/lava_bottle.webp',
    notes: ['Smoked Vanilla', 'Roasted Moka', 'Dark Amber'],
    searchNotes: 'Smoked Bourbon Vanilla Roasted Moka Coffee Dark Ambergris Sandalwood Velvet Amber Tonka',
    priceDZD: 17900,
  },
];

interface CartItem {
  id: string;
  name: string;
  priceDZD: number;
  image: string;
  quantity: number;
}

const normalize = (str: string) =>
  (str || '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();

export default function LavaLandingClient() {
  const router = useRouter();
  const { resetQuiz } = useQuizStore();

  // State for Search & Filtering
  const [activeFilter, setActiveFilter] = useState('all');
  const [searchTerm, setSearchTerm] = useState('');

  // State for Cart & Modals
  const [cartItems, setCartItems] = useState<CartItem[]>([]);
  const [isCartOpen, setIsCartOpen] = useState(false);
  const [isCheckoutOpen, setIsCheckoutOpen] = useState(false);
  const [activeScentKey, setActiveScentKey] = useState<string | null>(null);
  const [toastMsg, setToastMsg] = useState<string | null>(null);

  // Checkout Form State
  const [orderName, setOrderName] = useState('');
  const [orderPhone, setOrderPhone] = useState('');
  const [orderWilaya, setOrderWilaya] = useState<number>(16);
  const [orderAddress, setOrderAddress] = useState('');
  const [confirmedOrder, setConfirmedOrder] = useState<{
    name: string;
    phone: string;
    wilaya: string;
    trackingNumber: string;
    waUrl: string;
  } | null>(null);

  // Refs for GPU Scroll-Docking Engine
  const masterFrameRef = useRef<HTMLElement | null>(null);
  const flaconWrapperRef = useRef<HTMLDivElement | null>(null);
  const flaconTiltRef = useRef<HTMLDivElement | null>(null);
  const branchShadowRef = useRef<HTMLDivElement | null>(null);
  const heroStageRef = useRef<HTMLElement | null>(null);
  const heroAnchorRef = useRef<HTMLDivElement | null>(null);
  const dockTargetRef = useRef<HTMLDivElement | null>(null);
  const heroDockCardRef = useRef<HTMLElement | null>(null);
  const recomputeGeoRef = useRef<(() => void) | null>(null);

  // Navigate to the actual quiz on website 2 (localhost:3010)
  const handleLaunchQuiz = useCallback(
    (e?: React.MouseEvent) => {
      if (e) e.preventDefault();
      resetQuiz();
      router.push('/quiz');
    },
    [resetQuiz, router]
  );

  // Show Toast
  const showToast = useCallback((msg: string) => {
    setToastMsg(msg);
  }, []);

  useEffect(() => {
    if (!toastMsg) return;
    const t = setTimeout(() => setToastMsg(null), 2800);
    return () => clearTimeout(t);
  }, [toastMsg]);

  // Cart Actions
  const addItemToCart = (id: string, name: string, priceDZD: number, image: string) => {
    setCartItems((prev) => {
      const existing = prev.find((item) => item.id === id);
      if (existing) {
        return prev.map((item) =>
          item.id === id ? { ...item, quantity: item.quantity + 1 } : item
        );
      }
      return [...prev, { id, name, priceDZD, image, quantity: 1 }];
    });
    setIsCartOpen(true);
    showToast(`Added ${name} to your bag`);
  };

  const updateCartQty = (id: string, delta: number) => {
    setCartItems((prev) =>
      prev
        .map((item) => (item.id === id ? { ...item, quantity: item.quantity + delta } : item))
        .filter((item) => item.quantity > 0)
    );
  };

  const removeCartItem = (id: string) => {
    setCartItems((prev) => prev.filter((item) => item.id !== id));
  };

  const totalCartCount = cartItems.reduce((acc, item) => acc + item.quantity, 0);
  const subtotalDZD = cartItems.reduce((acc, item) => acc + item.priceDZD * item.quantity, 0);
  const selectedWilayaObj = WILAYAS.find((w) => w.code === Number(orderWilaya)) || WILAYAS[15];
  const deliveryFee = selectedWilayaObj ? selectedWilayaObj.fee : 400;

  const generateWhatsAppUrl = () => {
    if (cartItems.length === 0) {
      return (
        'https://wa.me/213550123456?text=' +
        encodeURIComponent(
          'Bonjour LAVA Parfums, je souhaite des informations sur votre collection haute parfumerie.'
        )
      );
    }
    const itemsList = cartItems
      .map(
        (i) =>
          `• ${i.name} (x${i.quantity}) - ${(i.priceDZD * i.quantity).toLocaleString('fr-DZ')} DZD`
      )
      .join('\n');
    const msg = `Bonjour LAVA Parfums, je souhaite commander:\n\n${itemsList}\n\nSous-total: ${subtotalDZD.toLocaleString(
      'fr-DZ'
    )} DZD\nMode: Paiement à la Livraison (Cash on Delivery)`;
    return 'https://wa.me/213550123456?text=' + encodeURIComponent(msg);
  };

  const handleCheckoutSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const trackingNumber = 'YAL-DZ-' + Math.floor(100000 + Math.random() * 900000);
    const waConfirmMsg = encodeURIComponent(
      `Bonjour LAVA Parfums, j'ai confirmé ma commande.\nNom: ${orderName}\nTéléphone: ${orderPhone}\nWilaya: ${selectedWilayaObj.name}\nSuivi Yalidine: ${trackingNumber}`
    );
    const waUrl = `https://wa.me/213550123456?text=${waConfirmMsg}`;
    setConfirmedOrder({
      name: orderName,
      phone: orderPhone,
      wilaya: selectedWilayaObj.name,
      trackingNumber,
      waUrl,
    });
  };

  // Filtered Products
  const cleanSearch = normalize(searchTerm.trim());
  const visibleProducts = PRODUCTS.filter((p) => {
    const matchesCategory = activeFilter === 'all' || p.category.includes(activeFilter);
    if (!matchesCategory) return false;
    if (!cleanSearch) return true;
    return (
      normalize(p.name).includes(cleanSearch) ||
      normalize(p.subtitle).includes(cleanSearch) ||
      normalize(p.searchNotes).includes(cleanSearch) ||
      normalize(p.category).includes(cleanSearch)
    );
  });

  const isHeroDockVisible = visibleProducts.some((p) => p.isHeroDock);

  // GPU Scroll-Docking Engine Effect (Ported directly from scroll-dock.js)
  useEffect(() => {
    const masterFrame = masterFrameRef.current;
    const flaconWrapper = flaconWrapperRef.current;
    const flaconTilt = flaconTiltRef.current;
    const branchShadow = branchShadowRef.current;
    const heroStage = heroStageRef.current;
    const heroAnchor = heroAnchorRef.current;
    const dockTarget = dockTargetRef.current;
    const heroDockCard = heroDockCardRef.current;

    if (!flaconWrapper || !dockTarget || !heroStage || !masterFrame) return;

    const BASE_W = 275;
    const DOCK_W = 122;
    const DOCK_H = 241;
    const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    const geo = {
      vpW: 1440,
      vpH: 960,
      masterDocLeft: 0,
      masterDocTop: 0,
      heroDocLeft: 0,
      heroDocTop: 0,
      heroW: 275,
      heroH: 530,
      heroAnchorW: 275,
      heroAnchorH: 530,
      dockDocLeft: 0,
      dockDocTop: 0,
      dockTargetW: 122,
      dockTargetH: 241,
      startScroll: 0,
      endScroll: 1000,
      isMobile: false,
      isTablet: false,
    };

    let isDocked = false;
    let targetProgress = 0;
    let currentProgress = 0;
    let isTicking = false;
    let lastFlaconOpacity: string | null = null;
    let lastFlaconVisibility: string | null = null;
    let lastFlaconPointerEvents: string | null = null;

    function setFlaconState(opacity: string, visibility: string, pointerEvents: string) {
      if (!flaconWrapper) return;
      if (lastFlaconOpacity !== opacity) {
        flaconWrapper.style.opacity = opacity;
        lastFlaconOpacity = opacity;
      }
      if (lastFlaconVisibility !== visibility) {
        flaconWrapper.style.visibility = visibility;
        lastFlaconVisibility = visibility;
      }
      if (lastFlaconPointerEvents !== pointerEvents) {
        flaconWrapper.style.pointerEvents = pointerEvents;
        lastFlaconPointerEvents = pointerEvents;
      }
    }

    function cacheGeometry() {
      if (!masterFrame || !dockTarget || !heroStage) return;
      const scrollY = window.scrollY || window.pageYOffset;
      const vpW = window.innerWidth;
      const vpH = window.innerHeight;

      geo.vpW = vpW;
      geo.vpH = vpH;
      geo.isMobile = vpW < 800;
      geo.isTablet = vpW >= 800 && vpW <= 1100;

      const mRect = masterFrame.getBoundingClientRect();
      geo.masterDocLeft = mRect.left;
      geo.masterDocTop = mRect.top + scrollY;

      const dRect = dockTarget.getBoundingClientRect();
      if (dRect.width > 0 && dRect.height > 0) {
        geo.dockDocLeft = dRect.left;
        geo.dockDocTop = dRect.top + scrollY;
        geo.dockTargetW = dRect.width;
        geo.dockTargetH = dRect.height;
      }

      if (heroAnchor) {
        const hRect = heroAnchor.getBoundingClientRect();
        geo.heroAnchorW = hRect.width || 275;
        geo.heroAnchorH = hRect.height || geo.heroAnchorW * 1.93;
        geo.heroW = geo.heroAnchorW;
        geo.heroH = geo.heroAnchorH;
        geo.heroDocLeft = hRect.left;
        geo.heroDocTop = hRect.top + scrollY;
      } else {
        const heroRect = heroStage.getBoundingClientRect();
        geo.heroW = Math.min(275, heroRect.width * 0.35);
        geo.heroH = geo.heroW * 1.93;
        geo.heroAnchorW = geo.heroW;
        geo.heroAnchorH = geo.heroH;
        geo.heroDocLeft = heroRect.left + heroRect.width * 0.52 - geo.heroW / 2;
        geo.heroDocTop = heroRect.top + scrollY + heroRect.height * 0.42 - geo.heroH / 2;
      }

      geo.startScroll = 0;
      geo.endScroll = Math.max(120, geo.dockDocTop - vpH * 0.5);
    }

    function lerp(start: number, end: number, factor: number) {
      return start + (end - start) * factor;
    }

    function easeInOutQuad(t: number) {
      return t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t;
    }

    function applyTransform() {
      if (!flaconWrapper) return;
      const scrollY = window.scrollY || window.pageYOffset;
      const clampedProgress = Math.max(0, Math.min(1, currentProgress));
      const eased = easeInOutQuad(clampedProgress);

      const heroRestingViewportX = geo.heroDocLeft + geo.heroW / 2;
      const heroRestingViewportY = geo.heroDocTop + geo.heroH / 2;

      const dockTargetViewportX = geo.dockDocLeft + geo.dockTargetW / 2;
      const dockTargetViewportY = geo.dockDocTop - geo.endScroll + geo.dockTargetH / 2 + 6;

      const midViewportX = geo.isMobile
        ? (geo.vpW || window.innerWidth) * 0.5
        : (geo.vpW || window.innerWidth) * 0.54;
      const midViewportY = (geo.vpH || window.innerHeight) * 0.48;

      const Cx = 2 * midViewportX - 0.5 * (heroRestingViewportX + dockTargetViewportX);
      const Cy = 2 * midViewportY - 0.5 * (heroRestingViewportY + dockTargetViewportY);

      const oneMinusT = 1 - eased;
      const targetVX =
        oneMinusT * oneMinusT * heroRestingViewportX +
        2 * oneMinusT * eased * Cx +
        eased * eased * dockTargetViewportX;
      const targetVY =
        oneMinusT * oneMinusT * heroRestingViewportY +
        2 * oneMinusT * eased * Cy +
        eased * eased * dockTargetViewportY;

      let targetW = lerp(geo.heroW, DOCK_W, eased);
      let targetH = targetW * 1.93;

      let finalLeft = 0;
      let finalTop = 0;

      if (currentProgress <= 0) {
        targetW = geo.heroW;
        targetH = geo.heroH;
        finalLeft = geo.heroDocLeft + (geo.heroAnchorW - geo.heroW) / 2;
        finalTop = geo.heroDocTop - scrollY + (geo.heroAnchorH - geo.heroH) / 2;
      } else if (currentProgress >= 1) {
        targetW = DOCK_W;
        targetH = DOCK_H;
        finalLeft = geo.dockDocLeft + (geo.dockTargetW - DOCK_W) / 2;
        finalTop = geo.dockDocTop - scrollY + (geo.dockTargetH - DOCK_H) / 2 + 6;
      } else {
        finalLeft = targetVX - targetW / 2;
        finalTop = targetVY - targetH / 2;
      }

      const scale = targetW / BASE_W;

      let finalRotateZ = 0;
      let finalRotateY = 0;

      if (!prefersReduced) {
        const restingTilt = -6.5;
        const baseTilt = lerp(restingTilt, 0, eased);
        let wobbleZ = 0;
        let wobbleY = 0;

        if (clampedProgress > 0.03 && clampedProgress < 0.97) {
          wobbleZ = Math.sin(clampedProgress * Math.PI) * -6.5;
          wobbleY = Math.sin(clampedProgress * Math.PI) * 15.0;
        }

        finalRotateZ = baseTilt + wobbleZ;
        finalRotateY = wobbleY;
      }

      if (branchShadow) {
        if (clampedProgress < 0.08) {
          branchShadow.style.opacity = (1 - clampedProgress / 0.08).toFixed(3);
        } else {
          branchShadow.style.opacity = '0';
        }
      }

      flaconWrapper.style.transform = `translate3d(${finalLeft.toFixed(2)}px, ${finalTop.toFixed(
        2
      )}px, 0) scale(${scale.toFixed(4)})`;

      if (flaconTilt) {
        flaconTilt.style.transform = `rotateZ(${finalRotateZ.toFixed(
          2
        )}deg) rotateY(${finalRotateY.toFixed(2)}deg)`;
      }

      const isDockHidden =
        heroDockCard &&
        (heroDockCard.classList.contains('is-search-hidden') ||
          heroDockCard.style.display === 'none');

      if (clampedProgress > 0.01 && clampedProgress < 0.94) {
        flaconWrapper.classList.add('is-scrolling');
      } else {
        flaconWrapper.classList.remove('is-scrolling');
      }

      if (isDockHidden) {
        if (clampedProgress <= 0.05) {
          setFlaconState('1', 'visible', 'none');
        } else {
          const fadeProgress = Math.min(1, (clampedProgress - 0.05) / 0.2);
          const opVal = (1 - fadeProgress).toFixed(3);
          if (fadeProgress >= 1) {
            setFlaconState('0', 'hidden', 'none');
          } else {
            setFlaconState(opVal, 'visible', 'none');
          }
        }
        if (isDocked && heroDockCard) {
          isDocked = false;
          heroDockCard.classList.remove('docked');
          flaconWrapper.classList.remove('is-docked');
        }
      } else {
        setFlaconState('1', 'visible', 'none');

        if (clampedProgress >= 0.94) {
          if (!isDocked && heroDockCard) {
            isDocked = true;
            heroDockCard.classList.add('docked');
            flaconWrapper.classList.add('is-docked');
          }
        } else {
          if (isDocked && heroDockCard) {
            isDocked = false;
            heroDockCard.classList.remove('docked');
            flaconWrapper.classList.remove('is-docked');
          }
        }
      }
    }

    function updateFrame() {
      cacheGeometry();
      const scrollY = window.scrollY || window.pageYOffset;

      if (scrollY <= 0) {
        targetProgress = 0;
      } else if (scrollY >= geo.endScroll) {
        targetProgress = 1;
      } else {
        targetProgress = scrollY / geo.endScroll;
      }

      currentProgress = targetProgress;
      applyTransform();
      isTicking = false;
    }

    function onScroll() {
      if (!isTicking) {
        isTicking = true;
        requestAnimationFrame(updateFrame);
      }
    }

    let resizeTimeout: ReturnType<typeof setTimeout> | null = null;
    function onWindowResize() {
      if (resizeTimeout) clearTimeout(resizeTimeout);
      resizeTimeout = setTimeout(() => {
        cacheGeometry();
        updateFrame();
      }, 100);
    }

    flaconWrapper.style.position = 'fixed';
    cacheGeometry();
    updateFrame();

    // Re-run geometry cache slightly after mount to ensure web fonts / images settled
    const settleTimer = setTimeout(() => {
      updateFrame();
    }, 250);

    const resizeObserver =
      typeof ResizeObserver !== 'undefined'
        ? new ResizeObserver(() => {
            updateFrame();
          })
        : null;
    if (resizeObserver && masterFrame) {
      resizeObserver.observe(masterFrame);
      if (dockTarget) resizeObserver.observe(dockTarget);
    }

    recomputeGeoRef.current = () => {
      updateFrame();
    };

    window.addEventListener('scroll', onScroll, { passive: true });
    window.addEventListener('resize', onWindowResize, { passive: true });
    window.addEventListener('load', updateFrame, { passive: true });

    return () => {
      clearTimeout(settleTimer);
      if (resizeTimeout) clearTimeout(resizeTimeout);
      if (resizeObserver) resizeObserver.disconnect();
      window.removeEventListener('scroll', onScroll);
      window.removeEventListener('resize', onWindowResize);
      window.removeEventListener('load', updateFrame);
    };
  }, []);

  // Recompute geometry whenever filter or search changes
  useEffect(() => {
    if (recomputeGeoRef.current) {
      recomputeGeoRef.current();
    }
  }, [activeFilter, searchTerm, isHeroDockVisible]);

  const scrollToTop = (e: React.MouseEvent) => {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const scrollToCollection = (e: React.MouseEvent) => {
    e.preventDefault();
    setActiveFilter('all');
    setSearchTerm('');
    const el = document.getElementById('collection');
    if (el) el.scrollIntoView({ behavior: 'smooth' });
  };

  const scrollToSection = (e: React.MouseEvent, id: string) => {
    e.preventDefault();
    const el = document.getElementById(id);
    if (el) el.scrollIntoView({ behavior: 'smooth' });
  };

  const resetFilters = () => {
    setActiveFilter('all');
    setSearchTerm('');
  };

  const activeScentProfile = activeScentKey ? SCENT_PROFILES[activeScentKey] : null;

  return (
    <div className="lava-landing-root" dir="ltr">
      {/* Load exact stylesheets from lava-perfume */}
      <link rel="preconnect" href="https://fonts.googleapis.com" />
      <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
      <link
        href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800;900&family=Syne:wght@700;800&display=swap"
        rel="stylesheet"
      />
      <link rel="stylesheet" href="/lava-assets/css/glassmorphism.css" />
      <link rel="stylesheet" href="/lava-assets/css/main.css" />

      <main className="master-frame" ref={masterFrameRef}>
        {/* Brand Header Navigation */}
        <header className="site-header">
          <div className="header-nav-row">
            <a
              href="#hero"
              onClick={scrollToTop}
              className="brand-logo"
              aria-label="LAVA Parfums Home"
            >
              <div className="brand-icon" aria-hidden="true">
                <span></span>
                <span></span>
                <span></span>
              </div>
              <div>
                <span className="brand-name">LAVA</span>
                <span
                  style={{
                    display: 'block',
                    fontSize: '0.62rem',
                    letterSpacing: '0.28em',
                    color: 'var(--color-orange-neon)',
                    fontFamily: 'var(--font-sans)',
                    textTransform: 'uppercase',
                  }}
                >
                  Parfums
                </span>
              </div>
            </a>

            <nav aria-label="Main Navigation">
              <ul className="nav-links">
                <li>
                  <a href="#hero" onClick={scrollToTop} className="nav-link active">
                    Home
                  </a>
                </li>
                <li>
                  <a
                    href="#collection"
                    onClick={scrollToCollection}
                    className="nav-link"
                    id="nav-link-collections"
                  >
                    Collections
                  </a>
                </li>
                <li>
                  <a
                    href="/quiz"
                    onClick={handleLaunchQuiz}
                    className="nav-link trigger-quiz"
                  >
                    Scent Quiz
                  </a>
                </li>
                <li>
                  <a
                    href="#vip-perks"
                    onClick={(e) => scrollToSection(e, 'vip-perks')}
                    className="nav-link"
                  >
                    Wilayas Delivery
                  </a>
                </li>
                <li>
                  <a
                    href="#vip-perks"
                    onClick={(e) => scrollToSection(e, 'vip-perks')}
                    className="nav-link"
                  >
                    Contact
                  </a>
                </li>
              </ul>
            </nav>

            <div className="nav-actions">
              <button
                type="button"
                onClick={handleLaunchQuiz}
                className="btn-get-started trigger-quiz"
              >
                <span>Get Started</span>
                <span className="btn-arrow-circle">↗</span>
              </button>

              <button
                type="button"
                className="cart-toggle-btn"
                id="cart-toggle-btn"
                aria-label="Open Shopping Bag"
                onClick={() => setIsCartOpen(true)}
              >
                <svg
                  width="20"
                  height="20"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                >
                  <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                  <line x1="3" y1="6" x2="21" y2="6"></line>
                  <path d="M16 10a4 4 0 0 1-8 0"></path>
                </svg>
                <span className="cart-count" id="cart-badge-count">
                  {totalCartCount}
                </span>
              </button>
            </div>
          </div>
        </header>

        {/* HERO SECTION */}
        <section className="hero-stage" id="hero" ref={heroStageRef}>
          <div className="hero-branch-layer" aria-hidden="true"></div>

          <div className="hero-content-left">
            {/* Rotating Avatar Muse Badge */}
            <div className="badge-avatar-wrap">
              <img
                src="/lava-assets/assets/avatar_muse.webp"
                alt="LAVA Fragrance Muse"
                className="avatar-muse-img"
                width="42"
                height="42"
              />
              <div className="badge-text-ring">
                <svg viewBox="0 0 100 100">
                  <path
                    id="circlePath"
                    d="M 50, 50 m -38, 0 a 38,38 0 1,1 76,0 a 38,38 0 1,1 -76,0"
                    fill="transparent"
                  />
                  <text>
                    <textPath href="#circlePath" startOffset="0%">
                      ✦ DISCOVER TIMELESS ELEGANCE ✦ THE ART OF SCENT
                    </textPath>
                  </text>
                </svg>
              </div>
            </div>

            {/* 28% OFF Promo Badge */}
            <div className="promo-badge-row">
              <div className="promo-tag">
                <span className="badge-dot"></span>
                <span>28% OFF</span>
              </div>
              <p className="promo-subtitle">
                Get premium quality for less. A deal you won&apos;t want to miss.
              </p>
            </div>

            {/* Headline */}
            <h1 className="hero-headline">
              Unleash Your
              <br />
              Inner Fire.
              <br />
              <span className="highlight">Discover LAVA.</span>
            </h1>

            {/* Designated Flacon Resting Stage on the Tree Branch */}
            <div
              id="hero-flacon-anchor"
              className="hero-flacon-perch"
              aria-hidden="true"
              ref={heroAnchorRef}
            ></div>

            {/* Description */}
            <p className="hero-description">
              LAVA is more than a fragrance. It&apos;s a statement of sophistication and passion, a
              tribute to the beautiful moments that define you.
            </p>

            {/* CTA & Social Proof */}
            <div className="hero-cta-row">
              <button
                type="button"
                className="btn-explore trigger-quiz"
                aria-label="Pass the Scent Quiz"
                onClick={handleLaunchQuiz}
              >
                <span>Pass Quiz</span>
                <span className="btn-arrow-circle">↗</span>
              </button>

              <div className="social-proof-wrap">
                <div className="avatar-pile">
                  <img
                    src="/lava-assets/assets/avatar_muse.webp"
                    alt="Reviewer 1"
                    width="32"
                    height="32"
                    loading="lazy"
                  />
                  <img
                    src="/lava-assets/assets/avatar_muse.webp"
                    alt="Reviewer 2"
                    width="32"
                    height="32"
                    loading="lazy"
                    style={{ filter: 'sepia(0.6) hue-rotate(280deg)' }}
                  />
                  <img
                    src="/lava-assets/assets/avatar_muse.webp"
                    alt="Reviewer 3"
                    width="32"
                    height="32"
                    loading="lazy"
                    style={{ filter: 'brightness(1.1) hue-rotate(45deg)' }}
                  />
                </div>
                <div className="rating-details">
                  <div className="rating-score">5.0</div>
                  <div className="rating-stars">★★★★★</div>
                  <div style={{ fontSize: '0.72rem', color: 'var(--color-text-muted)' }}>
                    9K+ Reviews
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Right Column: Social Links */}
          <aside className="hero-content-right" aria-label="Social connections">
            <nav className="social-rail" aria-label="Social Media">
              <a
                href="https://instagram.com"
                target="_blank"
                rel="noopener noreferrer"
                className="social-item"
              >
                <span>Instagram</span>
                <div className="social-line"></div>
                <div className="social-icon-circle">
                  <svg
                    width="12"
                    height="12"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  >
                    <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                    <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                    <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                  </svg>
                </div>
              </a>
              <a
                href="https://facebook.com"
                target="_blank"
                rel="noopener noreferrer"
                className="social-item"
              >
                <span>Facebook</span>
                <div className="social-line"></div>
                <div className="social-icon-circle">
                  <svg
                    width="12"
                    height="12"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  >
                    <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path>
                  </svg>
                </div>
              </a>
              <a
                href="https://linkedin.com"
                target="_blank"
                rel="noopener noreferrer"
                className="social-item"
              >
                <span>LinkedIn</span>
                <div className="social-line"></div>
                <div className="social-icon-circle">
                  <svg
                    width="12"
                    height="12"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  >
                    <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path>
                    <rect x="2" y="9" width="4" height="12"></rect>
                    <circle cx="4" cy="4" r="2"></circle>
                  </svg>
                </div>
              </a>
            </nav>
          </aside>
        </section>

        {/* SCENT FINDER QUIZ TEASER BANNER */}
        <section className="quiz-teaser-section" id="quiz-teaser">
          <div className="quiz-teaser-card">
            <div className="quiz-teaser-content">
              <div className="section-eyebrow">Alchemical Olfactory Match</div>
              <h3>Find Your Signature Scent</h3>
              <p>
                Answer sensory questions to match your soul aura with our haute parfumerie
                collection. Receive bespoke notes pyramid and discovery recommendations.
              </p>
            </div>
            <button
              type="button"
              onClick={handleLaunchQuiz}
              className="btn-launch-quiz trigger-quiz"
            >
              Take the Scent Quiz ↗
            </button>
          </div>
        </section>

        {/* HAUTE PARFUMERIE MODULAR PRODUCT GRID */}
        <section className="collection-section" id="collection">
          <div className="section-header split-editorial-header">
            <div className="section-header-left">
              <div className="section-eyebrow">Haute Parfumerie Collection</div>
              <h2 className="section-title">Sculpted for Eternity</h2>
            </div>
            <div className="section-header-right">
              <p className="section-description">
                Each flacon is cast from satin glass and crowned with a tactile mineral pebble cap.
                Master-blended with precious botanicals from the Mediterranean coast and Saharan
                sands.
              </p>
            </div>
          </div>

          {/* Luxury Instant Search & Olfactory Category Filters */}
          <div className="collection-search-container" id="collection-search-bar">
            <div className="search-input-wrapper">
              <span className="search-icon" aria-hidden="true">
                🔍
              </span>
              <input
                type="text"
                id="flacon-search-input"
                className="flacon-search-input"
                placeholder="Search flacons by name, note (Oud, Amber, Plum, Fig, Neroli, Cedar)..."
                aria-label="Search flacons by name, note (Oud, Amber, Plum, Fig, Neroli, Cedar)..."
                autoComplete="off"
                spellCheck={false}
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
              {searchTerm.length > 0 && (
                <button
                  type="button"
                  id="flacon-search-clear"
                  className="flacon-search-clear"
                  aria-label="Clear search"
                  onClick={() => setSearchTerm('')}
                >
                  ✕
                </button>
              )}
            </div>

            <div className="category-pills-row" role="tablist" aria-label="Fragrance categories">
              {[
                { key: 'all', label: 'All Flacons (12)' },
                { key: 'velvet-amber', label: 'Velvet Amber' },
                { key: 'woody-oud', label: 'Woody & Oud' },
                { key: 'mediterranean-fresh', label: 'Mediterranean Fresh' },
                { key: 'damask-florals', label: 'Damask Florals' },
              ].map((cat) => (
                <button
                  key={cat.key}
                  type="button"
                  className={`category-pill ${activeFilter === cat.key ? 'active' : ''}`}
                  role="tab"
                  aria-selected={activeFilter === cat.key}
                  onClick={() => setActiveFilter(cat.key)}
                >
                  {cat.label}
                </button>
              ))}
            </div>

            <div className="search-status-bar">
              <span id="search-results-count" className="search-results-count">
                {visibleProducts.length === PRODUCTS.length
                  ? `Showing all ${PRODUCTS.length} flacons`
                  : visibleProducts.length === 1
                  ? 'Showing 1 flacon'
                  : visibleProducts.length === 0
                  ? searchTerm
                    ? `No flacons found matching "${searchTerm}"`
                    : 'No flacons found'
                  : `Showing ${visibleProducts.length} of ${PRODUCTS.length} flacons`}
              </span>
            </div>
          </div>

          <div className="product-grid" id="main-product-grid">
            {PRODUCTS.map((product) => {
              const isVisible = visibleProducts.some((vp) => vp.id === product.id);
              return (
                <article
                  key={product.id}
                  ref={product.isHeroDock ? heroDockCardRef : undefined}
                  id={product.isHeroDock ? 'slot-lava-card' : undefined}
                  className={`product-card ${product.isHeroDock ? 'slot-hero-dock' : ''} ${
                    !isVisible ? 'is-search-hidden' : ''
                  }`}
                  style={{ display: isVisible ? '' : 'none' }}
                  data-id={product.id}
                  data-category={product.category}
                  data-name={product.name}
                  data-notes={product.searchNotes}
                >
                  <span
                    className={`card-badge ${product.badgeGold ? 'gold' : ''}`}
                    style={
                      product.badgeHero
                        ? {
                            background: 'rgba(232, 120, 138, 0.25)',
                            color: 'var(--color-sunset-rim)',
                            borderColor: 'var(--color-sunset-rim)',
                          }
                        : undefined
                    }
                  >
                    {product.badge}
                  </span>

                  {product.isHeroDock && (
                    <div className="docking-pedestal-glow" aria-hidden="true"></div>
                  )}

                  {product.isHeroDock ? (
                    <div
                      className="card-flacon-stage"
                      id="dock-target-anchor"
                      ref={dockTargetRef}
                    ></div>
                  ) : (
                    <div className="card-flacon-stage">
                      <img
                        src={product.image}
                        alt={`${product.name} Flacon`}
                        className="static-card-flacon"
                        loading="lazy"
                        decoding="async"
                        width="122"
                        height="241"
                      />
                    </div>
                  )}

                  <h3 className="product-title">{product.name}</h3>
                  <div className="product-subtitle">{product.subtitle}</div>
                  <div className="scent-notes-row">
                    {product.notes.map((n) => (
                      <span key={n} className="note-tag">
                        {n}
                      </span>
                    ))}
                  </div>
                  <div className="card-footer">
                    <button
                      type="button"
                      className="btn-add-cart-luxury"
                      aria-label={`Add ${product.name} to bag`}
                      onClick={() =>
                        addItemToCart(product.id, product.name, product.priceDZD, product.image)
                      }
                    >
                      <span>Add to Bag</span>
                      <span className="cart-plus-icon">+</span>
                    </button>
                  </div>
                  <button
                    type="button"
                    className="btn-quick-notes"
                    onClick={() => setActiveScentKey(product.id)}
                  >
                    Olfactory Architecture ↗
                  </button>
                </article>
              );
            })}

            {visibleProducts.length === 0 && (
              <div className="no-search-results">
                <h4>No Flacons Found</h4>
                <p>
                  No haute parfumerie match for {searchTerm ? `"${searchTerm}"` : 'the active filter'}
                  . Try searching by note like <em>Oud, Amber, Plum, Fig, Neroli, Cedar</em> or
                  reset filters.
                </p>
                <button
                  type="button"
                  className="category-pill"
                  style={{ marginTop: '14px' }}
                  onClick={resetFilters}
                >
                  Reset All Filters
                </button>
              </div>
            )}
          </div>
        </section>

        {/* ALGERIAN LUXURY MARKET VIP PERKS */}
        <section className="vip-perks-section" id="vip-perks">
          <div className="perks-grid">
            <div className="perk-card">
              <div className="perk-icon-wrap">🚚</div>
              <div className="perk-content">
                <h4>Livraison Express 58 Wilayas</h4>
                <p>
                  Fast track delivery directly to your home or Yalidine desk across all 58 Algerian
                  wilayas in 24 to 48 hours.
                </p>
              </div>
            </div>

            <div className="perk-card">
              <div className="perk-icon-wrap">💵</div>
              <div className="perk-content">
                <h4>Paiement à la Livraison (COD)</h4>
                <p>
                  Pay cash upon unboxing your flacon at your doorstep. We also accept Carte CIB and
                  Edahabia online.
                </p>
              </div>
            </div>

            <div className="perk-card">
              <div className="perk-icon-wrap">✨</div>
              <div className="perk-content">
                <h4>Haute Parfumerie Guaranteed</h4>
                <p>
                  Every flacon includes a tamper-evident serial wax seal and two complimentary 2ml
                  sample vials to test first.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* THE 2D PERFUME BOTTLE (SCROLL ORCHESTRATED FLACON) */}
        <div
          id="interactive-flacon-wrapper"
          ref={flaconWrapperRef}
          title="Scroll down to watch LAVA dock into the collection grid"
        >
          <div className="flacon-idle-float">
            <div className="flacon-body-tilt" id="flacon-body-tilt" ref={flaconTiltRef}>
              <img
                src="/lava-assets/assets/lava_bottle.webp"
                alt="LAVA Bella Vita Perfume Flacon"
                className="flacon-image"
                id="hero-flacon-img"
                width="275"
                height="530"
                decoding="async"
              />
            </div>
          </div>
          <div className="flacon-branch-shadow" aria-hidden="true" ref={branchShadowRef}></div>
        </div>

        {/* Footer */}
        <footer className="site-footer">
          <div className="footer-brand">
            <div className="brand-icon" style={{ transform: 'scale(0.8)' }} aria-hidden="true">
              <span></span>
              <span></span>
              <span></span>
            </div>
            <span>© 2026 LAVA Parfums Haute Parfumerie. Alger — Paris — Dubai.</span>
          </div>

          <ul className="footer-links">
            <li>
              <a href="#hero" onClick={scrollToTop}>
                Return to Tree Branch ↑
              </a>
            </li>
            <li>
              <a href="#collection" onClick={scrollToCollection}>
                Collections
              </a>
            </li>
            <li>
              <a href="/quiz" onClick={handleLaunchQuiz} className="trigger-quiz">
                Scent Finder
              </a>
            </li>
            <li>
              <a
                href="https://wa.me/213550123456"
                target="_blank"
                rel="noopener noreferrer"
              >
                WhatsApp Concierge
              </a>
            </li>
          </ul>
        </footer>
      </main>

      {/* MODAL: OLFACTORY ARCHITECTURE QUICK-VIEW */}
      <div
        className={`glass-modal-backdrop ${activeScentProfile ? 'active' : ''}`}
        id="scent-detail-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Scent Details"
        onClick={(e) => {
          if (e.target === e.currentTarget) setActiveScentKey(null);
        }}
      >
        <div className="glass-modal-panel">
          <button
            type="button"
            className="modal-close-btn"
            aria-label="Close Details"
            onClick={() => setActiveScentKey(null)}
          >
            ✕
          </button>
          {activeScentProfile && (
            <div>
              <div
                style={{
                  fontSize: '0.76rem',
                  letterSpacing: '0.2em',
                  color: 'var(--color-sunset-rim)',
                  textTransform: 'uppercase',
                  marginBottom: '6px',
                }}
              >
                Olfactory Architecture
              </div>
              <h3
                style={{
                  fontFamily: 'var(--font-display)',
                  fontSize: '2rem',
                  color: '#fff',
                  marginBottom: '8px',
                }}
              >
                {activeScentProfile.name}
              </h3>
              <div
                style={{
                  display: 'inline-block',
                  padding: '4px 12px',
                  background: 'rgba(240, 170, 112, 0.15)',
                  color: 'var(--color-sunset-rim)',
                  borderRadius: '9999px',
                  fontSize: '0.8rem',
                  fontWeight: 600,
                  marginBottom: '24px',
                }}
              >
                {activeScentProfile.family} • {activeScentProfile.concentration}
              </div>

              <div
                style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(2, 1fr)',
                  gap: '16px',
                  marginBottom: '28px',
                }}
              >
                <div
                  style={{
                    background: 'rgba(255, 255, 255, 0.05)',
                    padding: '14px',
                    borderRadius: '14px',
                    border: '1px solid rgba(255, 255, 255, 0.08)',
                  }}
                >
                  <div
                    style={{
                      fontSize: '0.72rem',
                      color: 'var(--color-text-muted)',
                      textTransform: 'uppercase',
                      letterSpacing: '0.06em',
                    }}
                  >
                    Longevity
                  </div>
                  <div
                    style={{
                      fontWeight: 600,
                      fontSize: '0.95rem',
                      color: '#fff',
                      marginTop: '4px',
                    }}
                  >
                    {activeScentProfile.longevity}
                  </div>
                </div>
                <div
                  style={{
                    background: 'rgba(255, 255, 255, 0.05)',
                    padding: '14px',
                    borderRadius: '14px',
                    border: '1px solid rgba(255, 255, 255, 0.08)',
                  }}
                >
                  <div
                    style={{
                      fontSize: '0.72rem',
                      color: 'var(--color-text-muted)',
                      textTransform: 'uppercase',
                      letterSpacing: '0.06em',
                    }}
                  >
                    Sillage / Projection
                  </div>
                  <div
                    style={{
                      fontWeight: 600,
                      fontSize: '0.95rem',
                      color: '#fff',
                      marginTop: '4px',
                    }}
                  >
                    {activeScentProfile.sillage}
                  </div>
                </div>
              </div>

              <div style={{ marginBottom: '28px' }}>
                <div
                  style={{
                    fontWeight: 700,
                    fontSize: '0.85rem',
                    color: '#fff',
                    textTransform: 'uppercase',
                    letterSpacing: '0.08em',
                    marginBottom: '12px',
                  }}
                >
                  The Fragrance Pyramid
                </div>

                <div style={{ marginBottom: '12px' }}>
                  <span
                    style={{
                      fontSize: '0.78rem',
                      color: 'var(--color-sunset-rim)',
                      fontWeight: 600,
                      textTransform: 'uppercase',
                    }}
                  >
                    Top Notes:
                  </span>
                  <div
                    style={{
                      display: 'flex',
                      gap: '6px',
                      flexWrap: 'wrap',
                      marginTop: '6px',
                    }}
                  >
                    {activeScentProfile.top.map((n) => (
                      <span key={n} className="note-tag">
                        {n}
                      </span>
                    ))}
                  </div>
                </div>

                <div style={{ marginBottom: '12px' }}>
                  <span
                    style={{
                      fontSize: '0.78rem',
                      color: 'var(--color-sunset-rose)',
                      fontWeight: 600,
                      textTransform: 'uppercase',
                    }}
                  >
                    Heart Notes:
                  </span>
                  <div
                    style={{
                      display: 'flex',
                      gap: '6px',
                      flexWrap: 'wrap',
                      marginTop: '6px',
                    }}
                  >
                    {activeScentProfile.heart.map((n) => (
                      <span key={n} className="note-tag">
                        {n}
                      </span>
                    ))}
                  </div>
                </div>

                <div>
                  <span
                    style={{
                      fontSize: '0.78rem',
                      color: 'var(--color-gold-light)',
                      fontWeight: 600,
                      textTransform: 'uppercase',
                    }}
                  >
                    Base Notes:
                  </span>
                  <div
                    style={{
                      display: 'flex',
                      gap: '6px',
                      flexWrap: 'wrap',
                      marginTop: '6px',
                    }}
                  >
                    {activeScentProfile.base.map((n) => (
                      <span key={n} className="note-tag">
                        {n}
                      </span>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* DRAWER: SHOPPING BAG */}
      <div
        className={`cart-drawer-backdrop ${isCartOpen ? 'active' : ''}`}
        id="cart-drawer-backdrop"
        onClick={(e) => {
          if (e.target === e.currentTarget) setIsCartOpen(false);
        }}
      >
        <div className="cart-drawer" role="dialog" aria-modal="true" aria-label="Your Fragrance Bag">
          <div className="cart-drawer-header">
            <h3 style={{ fontFamily: 'var(--font-display)', fontSize: '1.35rem', color: '#fff' }}>
              Your Fragrance Bag
            </h3>
            <button
              type="button"
              className="modal-close-btn"
              aria-label="Close Bag"
              style={{ position: 'static' }}
              onClick={() => setIsCartOpen(false)}
            >
              ✕
            </button>
          </div>

          <div className="cart-items-list" id="cart-items-container">
            {cartItems.length === 0 ? (
              <div
                style={{
                  textAlign: 'center',
                  padding: '48px 16px',
                  color: 'var(--color-text-muted)',
                }}
              >
                <div style={{ fontSize: '2.2rem', marginBottom: '12px', opacity: 0.5 }}>🛍️</div>
                <div style={{ fontWeight: 600, color: '#fff', marginBottom: '6px' }}>
                  Your Fragrance Bag is Empty
                </div>
                <p style={{ fontSize: '0.82rem' }}>
                  Explore LAVA on the branch or find your signature scent with our bespoke quiz.
                </p>
              </div>
            ) : (
              cartItems.map((item) => (
                <div key={item.id} className="cart-item">
                  <img src={item.image} alt={item.name} className="cart-item-img" />
                  <div className="cart-item-info">
                    <div className="cart-item-title">{item.name}</div>
                    <div className="cart-item-price">
                      {item.priceDZD.toLocaleString('fr-DZ')} DZD
                    </div>
                    <div
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '10px',
                        marginTop: '8px',
                      }}
                    >
                      <button
                        type="button"
                        style={{
                          width: '24px',
                          height: '24px',
                          borderRadius: '50%',
                          border: '1px solid rgba(255,255,255,0.2)',
                          background: 'transparent',
                          color: '#fff',
                          cursor: 'pointer',
                        }}
                        onClick={() => updateCartQty(item.id, -1)}
                      >
                        -
                      </button>
                      <span style={{ fontSize: '0.85rem', fontWeight: 600 }}>{item.quantity}</span>
                      <button
                        type="button"
                        style={{
                          width: '24px',
                          height: '24px',
                          borderRadius: '50%',
                          border: '1px solid rgba(255,255,255,0.2)',
                          background: 'transparent',
                          color: '#fff',
                          cursor: 'pointer',
                        }}
                        onClick={() => updateCartQty(item.id, 1)}
                      >
                        +
                      </button>
                      <button
                        type="button"
                        style={{
                          background: 'none',
                          border: 'none',
                          color: '#e8788a',
                          fontSize: '0.75rem',
                          marginLeft: 'auto',
                          cursor: 'pointer',
                        }}
                        onClick={() => removeCartItem(item.id)}
                      >
                        Remove
                      </button>
                    </div>
                  </div>
                </div>
              ))
            )}
          </div>

          <div className="cart-summary">
            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                fontSize: '0.95rem',
                color: 'var(--color-text-secondary)',
              }}
            >
              <span>Subtotal:</span>
              <span id="cart-subtotal-val" style={{ fontWeight: 700, color: '#fff' }}>
                {subtotalDZD.toLocaleString('fr-DZ')} DZD
              </span>
            </div>
            <div style={{ fontSize: '0.75rem', color: 'var(--color-sunset-rim)' }}>
              ✦ Complimentary luxury satin gift pouch &amp; 2 sample vials included
            </div>
            <button
              type="button"
              className="btn-checkout"
              disabled={cartItems.length === 0}
              onClick={() => {
                setIsCartOpen(false);
                setConfirmedOrder(null);
                setIsCheckoutOpen(true);
              }}
            >
              Proceed to Wilayas Checkout ↗
            </button>
            <button
              type="button"
              className="btn-whatsapp-instant"
              onClick={() => window.open(generateWhatsAppUrl(), '_blank')}
              style={{
                width: '100%',
                marginTop: '8px',
                padding: '12px',
                background: 'rgba(37, 211, 102, 0.15)',
                border: '1px solid rgba(37, 211, 102, 0.35)',
                borderRadius: '9999px',
                color: '#25d366',
                fontWeight: 600,
                fontSize: '0.85rem',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                gap: '8px',
              }}
            >
              <span>Commander en 1 Clic sur WhatsApp 💬</span>
            </button>
          </div>
        </div>
      </div>

      {/* MODAL: ALGERIAN CHECKOUT & WILAYAS FORM */}
      <div
        className={`glass-modal-backdrop ${isCheckoutOpen ? 'active' : ''}`}
        id="checkout-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Checkout"
        onClick={(e) => {
          if (e.target === e.currentTarget) setIsCheckoutOpen(false);
        }}
      >
        <div className="glass-modal-panel" style={{ maxWidth: '540px' }}>
          <button
            type="button"
            className="modal-close-btn"
            onClick={() => setIsCheckoutOpen(false)}
            aria-label="Close Checkout"
          >
            ✕
          </button>

          {!confirmedOrder ? (
            <>
              <div className="notice-pill" style={{ marginBottom: '12px' }}>
                🇩🇿 EXPÉDITION 58 WILAYAS • PAIEMENT À LA LIVRAISON
              </div>
              <h3
                style={{
                  fontFamily: 'var(--font-display)',
                  fontSize: '1.8rem',
                  color: '#fff',
                  marginBottom: '6px',
                }}
              >
                Finaliser Votre Commande
              </h3>
              <p
                style={{
                  fontSize: '0.85rem',
                  color: 'var(--color-text-secondary)',
                  marginBottom: '24px',
                }}
              >
                Remplissez vos coordonnées pour recevoir votre flacon via Yalidine Express.
              </p>

              <form
                onSubmit={handleCheckoutSubmit}
                style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}
              >
                <div>
                  <label
                    htmlFor="order-name"
                    style={{
                      display: 'block',
                      fontSize: '0.78rem',
                      color: 'var(--color-text-secondary)',
                      marginBottom: '6px',
                      textTransform: 'uppercase',
                    }}
                  >
                    Nom &amp; Prénom
                  </label>
                  <input
                    type="text"
                    id="order-name"
                    required
                    value={orderName}
                    onChange={(e) => setOrderName(e.target.value)}
                    placeholder="Ex: Souhil Malik"
                    style={{
                      width: '100%',
                      padding: '12px 16px',
                      background: 'rgba(255,255,255,0.06)',
                      border: '1px solid rgba(255,255,255,0.15)',
                      borderRadius: '12px',
                      color: '#fff',
                      fontSize: '0.9rem',
                      outline: 'none',
                    }}
                  />
                </div>

                <div>
                  <label
                    htmlFor="order-phone"
                    style={{
                      display: 'block',
                      fontSize: '0.78rem',
                      color: 'var(--color-text-secondary)',
                      marginBottom: '6px',
                      textTransform: 'uppercase',
                    }}
                  >
                    Numéro de Téléphone (Algérie)
                  </label>
                  <input
                    type="tel"
                    id="order-phone"
                    required
                    value={orderPhone}
                    onChange={(e) => setOrderPhone(e.target.value)}
                    placeholder="05XX XX XX XX / 06XX XX XX XX"
                    style={{
                      width: '100%',
                      padding: '12px 16px',
                      background: 'rgba(255,255,255,0.06)',
                      border: '1px solid rgba(255,255,255,0.15)',
                      borderRadius: '12px',
                      color: '#fff',
                      fontSize: '0.9rem',
                      outline: 'none',
                    }}
                  />
                </div>

                <div>
                  <label
                    htmlFor="checkout-wilaya"
                    style={{
                      display: 'block',
                      fontSize: '0.78rem',
                      color: 'var(--color-text-secondary)',
                      marginBottom: '6px',
                      textTransform: 'uppercase',
                    }}
                  >
                    Wilaya de Livraison
                  </label>
                  <select
                    id="checkout-wilaya"
                    required
                    value={orderWilaya}
                    onChange={(e) => setOrderWilaya(Number(e.target.value))}
                    style={{
                      width: '100%',
                      padding: '12px 16px',
                      background: '#261633',
                      border: '1px solid rgba(255,255,255,0.15)',
                      borderRadius: '12px',
                      color: '#fff',
                      fontSize: '0.9rem',
                      outline: 'none',
                    }}
                  >
                    {WILAYAS.map((w) => (
                      <option key={w.code} value={w.code}>
                        {w.name} (+{w.fee} DZD Delivery)
                      </option>
                    ))}
                  </select>
                </div>

                <div
                  style={{
                    background: 'rgba(255,255,255,0.04)',
                    border: '1px solid rgba(255,255,255,0.1)',
                    borderRadius: '12px',
                    padding: '12px 16px',
                    fontSize: '0.82rem',
                    color: 'var(--color-text-secondary)',
                  }}
                >
                  <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px' }}>
                    <span>Sous-total articles:</span>
                    <strong style={{ color: '#fff' }}>
                      {subtotalDZD.toLocaleString('fr-DZ')} DZD
                    </strong>
                  </div>
                  <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '6px' }}>
                    <span>Livraison Yalidine:</span>
                    <span style={{ color: 'var(--color-sunset-rim)' }}>
                      +{deliveryFee.toLocaleString('fr-DZ')} DZD
                    </span>
                  </div>
                  <div
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      borderTop: '1px solid rgba(255,255,255,0.1)',
                      paddingTop: '6px',
                      fontWeight: 700,
                      color: '#fff',
                    }}
                  >
                    <span>Total à la livraison:</span>
                    <span style={{ color: 'var(--color-sunset-rim)', fontSize: '0.95rem' }}>
                      {(subtotalDZD + deliveryFee).toLocaleString('fr-DZ')} DZD
                    </span>
                  </div>
                </div>

                <div>
                  <label
                    htmlFor="order-address"
                    style={{
                      display: 'block',
                      fontSize: '0.78rem',
                      color: 'var(--color-text-secondary)',
                      marginBottom: '6px',
                      textTransform: 'uppercase',
                    }}
                  >
                    Commune &amp; Adresse de Livraison
                  </label>
                  <input
                    type="text"
                    id="order-address"
                    required
                    value={orderAddress}
                    onChange={(e) => setOrderAddress(e.target.value)}
                    placeholder="Ex: Hydra, Boulevard Sidi Yahia"
                    style={{
                      width: '100%',
                      padding: '12px 16px',
                      background: 'rgba(255,255,255,0.06)',
                      border: '1px solid rgba(255,255,255,0.15)',
                      borderRadius: '12px',
                      color: '#fff',
                      fontSize: '0.9rem',
                      outline: 'none',
                    }}
                  />
                </div>

                <div
                  style={{
                    background: 'rgba(240, 170, 112, 0.1)',
                    border: '1px solid rgba(240, 170, 112, 0.25)',
                    borderRadius: '14px',
                    padding: '14px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '12px',
                  }}
                >
                  <input
                    type="radio"
                    id="pay-cod"
                    name="payment_method"
                    value="cod"
                    defaultChecked
                    style={{ accentColor: 'var(--color-sunset-rim)' }}
                  />
                  <label htmlFor="pay-cod" style={{ fontSize: '0.85rem', color: '#fff', cursor: 'pointer' }}>
                    <strong>Paiement à la Livraison (Espèces)</strong>
                    <br />
                    <span style={{ fontSize: '0.75rem', color: 'var(--color-text-secondary)' }}>
                      Payez le livreur Yalidine Express après inspection du colis.
                    </span>
                  </label>
                </div>

                <button type="submit" className="btn-checkout" style={{ marginTop: '8px' }}>
                  Confirmer la Commande ↗
                </button>
              </form>
            </>
          ) : (
            <div style={{ textAlign: 'center', padding: '20px 10px' }}>
              <div style={{ fontSize: '3.2rem', marginBottom: '16px' }}>✨</div>
              <div className="notice-pill" style={{ marginBottom: '12px' }}>
                COMMANDE CONFIRMÉE • CASH ON DELIVERY
              </div>
              <h2
                style={{
                  fontFamily: 'var(--font-display)',
                  fontSize: '2.2rem',
                  color: '#fff',
                  marginBottom: '12px',
                }}
              >
                Merci, {confirmedOrder.name}!
              </h2>
              <p
                style={{
                  fontSize: '0.95rem',
                  color: 'var(--color-text-secondary)',
                  maxWidth: '480px',
                  margin: '0 auto 24px',
                  lineHeight: 1.6,
                }}
              >
                Votre flacon LAVA Haute Parfumerie est soigneusement emballé dans son coffret satiné.
                Notre transporteur <strong>Yalidine Express</strong> vous contactera au{' '}
                <strong>{confirmedOrder.phone}</strong> dès son arrivée à{' '}
                <strong>{confirmedOrder.wilaya}</strong>.
              </p>

              <div
                style={{
                  background: 'rgba(255, 255, 255, 0.05)',
                  border: '1px dashed rgba(240, 170, 112, 0.4)',
                  borderRadius: '16px',
                  padding: '18px',
                  maxWidth: '380px',
                  margin: '0 auto 24px',
                }}
              >
                <div
                  style={{
                    fontSize: '0.75rem',
                    color: 'var(--color-text-muted)',
                    textTransform: 'uppercase',
                    letterSpacing: '0.1em',
                  }}
                >
                  Numéro de Suivi Yalidine
                </div>
                <div
                  style={{
                    fontFamily: 'monospace',
                    fontSize: '1.3rem',
                    fontWeight: 700,
                    color: 'var(--color-sunset-rim)',
                    marginTop: '4px',
                  }}
                >
                  {confirmedOrder.trackingNumber}
                </div>
                <div
                  style={{
                    fontSize: '0.75rem',
                    color: 'var(--color-text-secondary)',
                    marginTop: '4px',
                  }}
                >
                  Paiement à la réception (Espèces ou CIB)
                </div>
              </div>

              <div style={{ display: 'flex', gap: '12px', justifyContent: 'center', flexWrap: 'wrap' }}>
                <a
                  href={confirmedOrder.waUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="btn-checkout"
                  style={{
                    textDecoration: 'none',
                    display: 'inline-flex',
                    alignItems: 'center',
                    gap: '8px',
                    background: 'rgba(37, 211, 102, 0.2)',
                    border: '1px solid #25d366',
                    color: '#fff',
                  }}
                >
                  <span>Suivi WhatsApp 💬</span>
                </a>
                <button
                  type="button"
                  className="btn-checkout"
                  onClick={() => {
                    setIsCheckoutOpen(false);
                    setCartItems([]);
                    setConfirmedOrder(null);
                  }}
                >
                  Retourner à l&apos;Accueil
                </button>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* TOAST NOTIFICATION */}
      {toastMsg && (
        <div
          style={{
            position: 'fixed',
            bottom: '28px',
            left: '28px',
            background: 'rgba(36, 21, 46, 0.95)',
            border: '1px solid rgba(240, 170, 112, 0.4)',
            borderRadius: '9999px',
            padding: '12px 24px',
            color: '#fff',
            fontSize: '0.86rem',
            boxShadow: '0 10px 30px rgba(0,0,0,0.6)',
            zIndex: 11000,
            backdropFilter: 'blur(14px)',
            pointerEvents: 'none',
          }}
        >
          {toastMsg}
        </div>
      )}
    </div>
  );
}
