export type Locale = 'en_us' | 'en_uk' | 'en_au' | 'fr_fr' | 'jp_jp' | 'es_es' | 'it_it' | 'de_de' | 'nl_nl' | 'sv_se' | 'pt_br' | 'zh_cn' | 'ko_kr' | 'ru_ru' | 'pl_pl' | 'tr_tr' | 'ar_sa' | 'hi_in' | 'vi_vn' | 'th_th' | 'id_id'

const translations: Record<Locale, Record<string, string>> = {
  en_us: {},
  en_uk: {},
  en_au: {},
  fr_fr: {},
  jp_jp: {},
  es_es: {},
  it_it: {},
  de_de: {},
  nl_nl: {},
  sv_se: {},
  pt_br: {},
  zh_cn: {},
  ko_kr: {},
  ru_ru: {},
  pl_pl: {},
  tr_tr: {},
  ar_sa: {},
  hi_in: {},
  vi_vn: {},
  th_th: {},
  id_id: {},
}

export async function loadLocale(locale: Locale): Promise<Record<string, string>> {
  if (Object.keys(translations[locale]).length > 0) {
    return translations[locale]
  }

  const response = await fetch(`/locales/${locale}.lang`)
  const text = await response.text()
  
  const parsed: Record<string, string> = {}
  text.split('\n').forEach(line => {
    if (line.trim() && !line.startsWith('#')) {
      const [key, ...valueParts] = line.split('=')
      if (key && valueParts.length > 0) {
        parsed[key.trim()] = valueParts.join('=').trim()
      }
    }
  })
  
  translations[locale] = parsed
  return parsed
}

export function t(translations: Record<string, string>, key: string): string {
  return translations[key] || key
}
