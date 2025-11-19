import type { Config } from 'tailwindcss'
import { expressiveColors, expressiveColorsDark, expressiveShape, expressiveSpacing, expressiveElevation } from './src/lib/design/material3-expressive'

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        // Legacy support
        primary: 'rgb(var(--color-primary-main) / <alpha-value>)',
        secondary: 'rgb(var(--color-secondary-main) / <alpha-value>)',
        // Material 3 Expressive colors
        m3: {
          primary: {
            main: 'rgb(var(--color-primary-main) / <alpha-value>)',
            light: 'rgb(var(--color-primary-light) / <alpha-value>)',
            dark: 'rgb(var(--color-primary-dark) / <alpha-value>)',
            container: 'rgb(var(--color-primary-container) / <alpha-value>)',
            onContainer: 'rgb(var(--color-primary-onContainer) / <alpha-value>)',
          },
          secondary: {
            main: 'rgb(var(--color-secondary-main) / <alpha-value>)',
            light: 'rgb(var(--color-secondary-light) / <alpha-value>)',
            dark: 'rgb(var(--color-secondary-dark) / <alpha-value>)',
            container: 'rgb(var(--color-secondary-container) / <alpha-value>)',
            onContainer: 'rgb(var(--color-secondary-onContainer) / <alpha-value>)',
          },
          tertiary: {
            main: 'rgb(var(--color-tertiary-main) / <alpha-value>)',
            light: 'rgb(var(--color-tertiary-light) / <alpha-value>)',
            dark: 'rgb(var(--color-tertiary-dark) / <alpha-value>)',
            container: 'rgb(var(--color-tertiary-container) / <alpha-value>)',
            onContainer: 'rgb(var(--color-tertiary-onContainer) / <alpha-value>)',
          },
          surface: {
            dim: 'rgb(var(--color-surface-dim) / <alpha-value>)',
            main: 'rgb(var(--color-surface-main) / <alpha-value>)',
            bright: 'rgb(var(--color-surface-bright) / <alpha-value>)',
            containerLowest: 'rgb(var(--color-surface-containerLowest) / <alpha-value>)',
            containerLow: 'rgb(var(--color-surface-containerLow) / <alpha-value>)',
            container: 'rgb(var(--color-surface-container) / <alpha-value>)',
            containerHigh: 'rgb(var(--color-surface-containerHigh) / <alpha-value>)',
            containerHighest: 'rgb(var(--color-surface-containerHighest) / <alpha-value>)',
          },
          error: {
            main: 'rgb(var(--color-error-main) / <alpha-value>)',
            light: 'rgb(var(--color-error-light) / <alpha-value>)',
            dark: 'rgb(var(--color-error-dark) / <alpha-value>)',
            container: 'rgb(var(--color-error-container) / <alpha-value>)',
            onContainer: 'rgb(var(--color-error-onContainer) / <alpha-value>)',
          },
          on: {
            primary: 'rgb(var(--color-on-primary) / <alpha-value>)',
            secondary: 'rgb(var(--color-on-secondary) / <alpha-value>)',
            tertiary: 'rgb(var(--color-on-tertiary) / <alpha-value>)',
            surface: 'rgb(var(--color-on-surface) / <alpha-value>)',
            surfaceVariant: 'rgb(var(--color-on-surfaceVariant) / <alpha-value>)',
            error: 'rgb(var(--color-on-error) / <alpha-value>)',
            background: 'rgb(var(--color-on-background) / <alpha-value>)',
          },
          outline: {
            main: 'rgb(var(--color-outline-main) / <alpha-value>)',
            variant: 'rgb(var(--color-outline-variant) / <alpha-value>)',
          },
        },
      },
      fontFamily: {
        sans: ['GoogleSansFlex', 'sans-serif'],
      },
      borderRadius: expressiveShape.corner,
      spacing: expressiveSpacing,
      boxShadow: {
        'elevation-1': expressiveElevation.level1,
        'elevation-2': expressiveElevation.level2,
        'elevation-3': expressiveElevation.level3,
        'elevation-4': expressiveElevation.level4,
        'elevation-5': expressiveElevation.level5,
      },
      transitionTimingFunction: {
        'emphasized': 'cubic-bezier(0.2, 0, 0, 1)',
        'emphasized-decelerate': 'cubic-bezier(0.05, 0.7, 0.1, 1)',
        'emphasized-accelerate': 'cubic-bezier(0.3, 0, 0.8, 0.15)',
      },
    },
  },
  plugins: [],
}
export default config
