"use client";

import React, {
  createContext,
  useContext,
  useState,
  useEffect,
  ReactNode,
} from "react";
import { useSettingsStore, Language } from "@/lib/stores/settingsStore";
import { loadLocale, Locale } from "@/lib/i18n/loader";

interface TranslationContextType {
  t: (key: string, params?: Record<string, string | number>) => string;
  currentLocale: Locale;
  isLoading: boolean;
}

const TranslationContext = createContext<TranslationContextType | undefined>(
  undefined
);

const languageToLocaleMap: Record<Language, Locale> = {
  en: "en_us",
  es: "es_es",
  fr: "fr_fr",
  de: "de_de",
  ja: "jp_jp",
  zh: "zh_cn",
  ko: "ko_kr",
  pt: "pt_br",
  it: "it_it",
  ru: "ru_ru",
  ar: "ar_sa",
  hi: "hi_in",
  vi: "vi_vn",
  th: "th_th",
  id: "id_id",
  tr: "tr_tr",
  nl: "nl_nl",
  sv: "sv_se",
  pl: "pl_pl",
};

export function TranslationProvider({ children }: { children: ReactNode }) {
  const { language } = useSettingsStore();
  const [translations, setTranslations] = useState<Record<string, string>>({});
  const [isLoading, setIsLoading] = useState(true);
  const [currentLocale, setCurrentLocale] = useState<Locale>(
    languageToLocaleMap[language] || "en_us"
  );

  useEffect(() => {
    const fetchTranslations = async () => {
      setIsLoading(true);
      const targetLocale = languageToLocaleMap[language] || "en_us";
      setCurrentLocale(targetLocale);
      try {
        const loadedTranslations = await loadLocale(targetLocale);
        setTranslations(loadedTranslations);
      } catch (error) {
        console.error("Failed to load translations for locale:", targetLocale, error);
        // Fallback to English if loading fails
        const fallbackTranslations = await loadLocale("en_us");
        setTranslations(fallbackTranslations);
        setCurrentLocale("en_us");
      } finally {
        setIsLoading(false);
      }
    };

    fetchTranslations();
  }, [language]);

  const t = (key: string, params?: Record<string, string | number>) => {
    let translation = translations[key] || key;
    if (params) {
      for (const paramKey in params) {
        translation = translation.replace(
          new RegExp(`{${paramKey}}`, 'g'),
          String(params[paramKey])
        );
      }
    }
    return translation;
  };

  return (
    <TranslationContext.Provider value={{ t, currentLocale, isLoading }}>
      {children}
    </TranslationContext.Provider>
  );
}

export function useTranslation() {
  const context = useContext(TranslationContext);
  if (context === undefined) {
    throw new Error("useTranslation must be used within a TranslationProvider");
  }
  return context;
}
