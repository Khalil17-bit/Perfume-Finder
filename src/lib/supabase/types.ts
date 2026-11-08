export type LocalizedString = {
  ar: string;
  fr: string;
  en: string;
  [key: string]: string;
};

export type TagCategory = 'gender' | 'vibe' | 'occasion' | 'season' | 'intensity' | 'notes';

export interface StoreSettings {
  id: string;
  store_name: LocalizedString;
  hero_title: LocalizedString;
  hero_subtitle: LocalizedString;
  logo_url: string | null;
  store_address: LocalizedString;
  operating_hours: LocalizedString;
  social_links: {
    instagram?: string;
    tiktok?: string;
    whatsapp?: string;
    maps?: string;
  };
  default_locale: string;
  kiosk_pin: string;
  updated_at: string;
}

export interface Tag {
  id: string;
  slug: string;
  category: TagCategory;
  label: LocalizedString;
  created_at: string;
}

export interface Perfume {
  id: string;
  name: string; // Strictly English/Latin
  brand: string | null;
  description: LocalizedString;
  price: number | null;
  shelf_location: string | null;
  is_available: boolean;
  is_featured: boolean;
  is_draft: boolean;
  created_at: string;
}

export interface PerfumeTag {
  perfume_id: string;
  tag_id: string;
}

export interface Question {
  id: string;
  step_order: number;
  is_active: boolean;
  question_text: LocalizedString;
  helper_text: LocalizedString | null;
  created_at: string;
}

export interface Answer {
  id: string;
  question_id: string;
  sort_order: number;
  title: LocalizedString;
  subtitle_explanation: LocalizedString | null;
  image_url: string | null;
  is_hard_filter: boolean;
  created_at: string;
}

export interface AnswerTagWeight {
  id: string;
  answer_id: string;
  tag_id: string;
  weight_points: number;
}

export interface AnalyticsLog {
  id: string;
  mode: 'web' | 'kiosk';
  answered_count: number;
  top_perfume_id: string | null;
  selected_answer_ids: string[];
  created_at: string;
}

export interface Database {
  public: {
    Tables: {
      store_settings: {
        Row: StoreSettings;
        Insert: Partial<StoreSettings>;
        Update: Partial<StoreSettings>;
      };
      tags: {
        Row: Tag;
        Insert: Omit<Tag, 'id' | 'created_at'> & { id?: string; created_at?: string };
        Update: Partial<Tag>;
      };
      perfumes: {
        Row: Perfume;
        Insert: Omit<Perfume, 'id' | 'created_at'> & { id?: string; created_at?: string };
        Update: Partial<Perfume>;
      };
      perfume_tags: {
        Row: PerfumeTag;
        Insert: PerfumeTag;
        Update: Partial<PerfumeTag>;
      };
      questions: {
        Row: Question;
        Insert: Omit<Question, 'id' | 'created_at'> & { id?: string; created_at?: string };
        Update: Partial<Question>;
      };
      answers: {
        Row: Answer;
        Insert: Omit<Answer, 'id' | 'created_at'> & { id?: string; created_at?: string };
        Update: Partial<Answer>;
      };
      answer_tag_weights: {
        Row: AnswerTagWeight;
        Insert: Omit<AnswerTagWeight, 'id'> & { id?: string };
        Update: Partial<AnswerTagWeight>;
      };
      analytics_logs: {
        Row: AnalyticsLog;
        Insert: Omit<AnalyticsLog, 'id' | 'created_at'> & { id?: string; created_at?: string };
        Update: Partial<AnalyticsLog>;
      };
    };
  };
}
