import type { Config } from "tailwindcss";

const config: Config = {
  darkMode: ["class"],
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "#0B0B0D", // Deep studio obsidian
        surface: "#141417",    // Matte charcoal card surface
        surfaceElevated: "#1C1C21", // Elevated studio slate
        gold: {
          DEFAULT: "#FF5500",  // Signature Burnt Orange (matching Seamless Custom Bundles UI)
          light: "#FF7129",
          dark: "#CC4400",
          glow: "rgba(255, 85, 0, 0.28)",
        },
        amberAccent: "#EA580C",
        textPrimary: "#FAFAFA", // Zinc-50
        textMuted: "#8E8E98",   // Sober studio grey
      },
      fontFamily: {
        latin: ["var(--font-inter)", "sans-serif"],
        arabic: ["var(--font-cairo)", "sans-serif"],
      },
      letterSpacing: {
        tightest: "-0.04em",
        tighter: "-0.02em",
      },
      keyframes: {
        pulseGlow: {
          "0%, 100%": { opacity: "1", transform: "scale(1)" },
          "50%": { opacity: "0.85", transform: "scale(1.02)" },
        },
        fadeIn: {
          "0%": { opacity: "0", transform: "translateY(8px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
      },
      animation: {
        "pulse-glow": "pulseGlow 2.5s ease-in-out infinite",
        "fade-in": "fadeIn 0.4s cubic-bezier(0.16, 1, 0.3, 1) forwards",
      },
    },
  },
  plugins: [],
};

export default config;
