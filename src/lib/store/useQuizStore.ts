import { create } from 'zustand';

export interface QuizState {
  // State
  selectedAnswers: Record<string, string>; // questionId -> answerId
  currentStepIndex: number;
  history: string[]; // stack of questionIds
  mode: 'web' | 'kiosk';
  isKioskLocked: boolean;

  // Actions
  selectAnswer: (questionId: string, answerId: string, autoAdvance?: boolean) => void;
  nextStep: () => void;
  goToPreviousStep: () => void;
  goToStep: (index: number) => void;
  resetQuiz: () => void;
  setMode: (mode: 'web' | 'kiosk') => void;
  setKioskLocked: (locked: boolean) => void;

  // Computed state accessors
  getAnsweredCount: () => number;
  canEarlyExit: () => boolean;
  getAccuracyPercentage: (totalQuestionsCount?: number) => number;
  getSelectedAnswerIds: () => string[];
}

export const useQuizStore = create<QuizState>((set, get) => ({
  selectedAnswers: {},
  currentStepIndex: 0,
  history: [],
  mode: 'web',
  isKioskLocked: false,

  selectAnswer: (questionId: string, answerId: string, autoAdvance: boolean = true) => {
    set((state) => {
      const updatedAnswers = {
        ...state.selectedAnswers,
        [questionId]: answerId,
      };

      const lastHistoryItem = state.history[state.history.length - 1];
      const newHistory = lastHistoryItem === questionId
        ? state.history
        : [...state.history, questionId];

      const newStep = autoAdvance ? state.currentStepIndex + 1 : state.currentStepIndex;

      return {
        selectedAnswers: updatedAnswers,
        history: newHistory,
        currentStepIndex: newStep,
      };
    });
  },

  nextStep: () => {
    set((state) => ({
      currentStepIndex: state.currentStepIndex + 1,
    }));
  },

  goToPreviousStep: () => {
    set((state) => {
      const newHistory = [...state.history];
      newHistory.pop();

      return {
        currentStepIndex: Math.max(0, state.currentStepIndex - 1),
        history: newHistory,
      };
    });
  },

  goToStep: (index: number) => {
    set({ currentStepIndex: Math.max(0, index) });
  },

  resetQuiz: () => {
    set((state) => ({
      selectedAnswers: {},
      currentStepIndex: 0,
      history: [],
      mode: state.mode,
      isKioskLocked: state.isKioskLocked,
    }));
  },

  setMode: (mode: 'web' | 'kiosk') => {
    set({ mode });
  },

  setKioskLocked: (isKioskLocked: boolean) => {
    set({ isKioskLocked });
  },

  getAnsweredCount: () => {
    return Object.keys(get().selectedAnswers).length;
  },

  canEarlyExit: () => {
    return Object.keys(get().selectedAnswers).length >= 2;
  },

  getAccuracyPercentage: (_totalQuestionsCount: number = 8) => {
    const answered = Object.keys(get().selectedAnswers).length;
    if (answered === 0) return 0;
    if (answered === 1) return 25;
    if (answered === 2) return 45; // Strictly per PRD Section 5 & Design Section 4
    if (answered === 3) return 60;
    if (answered === 4) return 72;
    if (answered === 5) return 84;
    if (answered === 6) return 92;

    const base = 92;
    const remaining = Math.max(0, answered - 6);
    const maxAdditional = Math.min(6, remaining * 2);
    return Math.min(98, base + maxAdditional);
  },

  getSelectedAnswerIds: () => {
    return Object.values(get().selectedAnswers);
  },
}));
