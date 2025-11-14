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
        primary: expressiveColors.primary.main,
        secondary: expressiveColors.secondary.main,
        // Material 3 Expressive colors
        m3: {
          primary: expressiveColors.primary,
          secondary: expressiveColors.secondary,
          tertiary: expressiveColors.tertiary,
          surface: expressiveColors.surface,
          error: expressiveColors.error,
          on: expressiveColors.on,
          outline: expressiveColors.outline,
        },
      },
      fontFamily: {
        sans: ['RobotoFlex', 'sans-serif'],
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
