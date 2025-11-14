/**
 * Material 3 Expressive Design System
 * Based on https://m3.material.io/blog/building-with-m3-expressive
 */

export const expressiveColors = {
  // Primary palette - Mediterranean Blue
  primary: {
    main: '#0077BE',      // Deep Mediterranean blue
    light: '#3399D6',     // Light azure
    dark: '#005A94',      // Deep ocean blue
    container: '#D6EFFF', // Light sky blue
    onContainer: '#001F33',
  },
  // Secondary palette - Aegean Turquoise
  secondary: {
    main: '#00A8CC',      // Turquoise
    light: '#33BFDB',     // Light turquoise
    dark: '#0088A8',      // Deep turquoise
    container: '#D6F5FF', // Pale turquoise
    onContainer: '#003340',
  },
  // Tertiary palette - Santorini White/Gold
  tertiary: {
    main: '#FFB84D',      // Golden sand
    light: '#FFCA70',     // Light gold
    dark: '#E69A2E',      // Deep gold
    container: '#FFF4E0', // Cream
    onContainer: '#4D3300',
  },
  // Surface colors - Mediterranean whites and creams
  surface: {
    dim: '#E8F4F8',       // Soft blue-grey
    main: '#F5FAFE',      // Crisp white with blue tint
    bright: '#FFFFFF',    // Pure white
    containerLowest: '#FFFFFF',
    containerLow: '#F0F9FF', // Very light blue
    container: '#E6F4FF',    // Light blue
    containerHigh: '#D6EFFF', // Medium light blue
    containerHighest: '#C2E7FF', // Stronger blue tint
  },
  // Error colors
  error: {
    main: '#BA1A1A',
    light: '#FF5449',
    dark: '#93000A',
    container: '#FFDAD6',
    onContainer: '#410002',
  },
  // On colors
  on: {
    primary: '#FFFFFF',
    secondary: '#FFFFFF',
    tertiary: '#FFFFFF',
    surface: '#1C1B1F',
    surfaceVariant: '#49454F',
    error: '#FFFFFF',
    background: '#1C1B1F',
  },
  // Outline
  outline: {
    main: '#79747E',
    variant: '#CAC4D0',
  },
}

export const expressiveColorsDark = {
  primary: {
    main: '#5CB3FF',      // Bright Mediterranean blue
    light: '#8FCCFF',     // Light sky blue
    dark: '#3399D6',      // Medium blue
    container: '#001F33', // Deep navy
    onContainer: '#D6EFFF',
  },
  secondary: {
    main: '#4DD4F5',      // Bright turquoise
    light: '#7DE3FF',     // Light cyan
    dark: '#00A8CC',      // Deep turquoise
    container: '#003340', // Deep teal
    onContainer: '#D6F5FF',
  },
  tertiary: {
    main: '#FFD699',      // Light gold
    light: '#FFE5B8',     // Pale gold
    dark: '#FFB84D',      // Medium gold
    container: '#4D3300', // Deep brown
    onContainer: '#FFF4E0',
  },
  surface: {
    dim: '#0A1929',       // Deep navy night
    main: '#0D2137',      // Navy blue
    bright: '#1A3A52',    // Lighter navy
    containerLowest: '#061220',
    containerLow: '#0D2137',
    container: '#14293D',    // Medium navy
    containerHigh: '#1E3A52', // Lighter navy
    containerHighest: '#2A4A66', // Blue-grey
  },
  error: {
    main: '#FFB4AB',
    light: '#FFDAD6',
    dark: '#93000A',
    container: '#93000A',
    onContainer: '#FFDAD6',
  },
  on: {
    primary: '#4D3200',
    secondary: '#003D4D',
    tertiary: '#1B5E20',
    surface: '#E6E1E5',
    surfaceVariant: '#CAC4D0',
    error: '#690005',
    background: '#E6E1E5',
  },
  outline: {
    main: '#938F99',
    variant: '#49454F',
  },
}

// Expressive typography scale
export const expressiveTypography = {
  display: {
    large: {
      fontSize: '57px',
      lineHeight: '64px',
      fontWeight: 400,
      letterSpacing: '-0.25px',
    },
    medium: {
      fontSize: '45px',
      lineHeight: '52px',
      fontWeight: 400,
      letterSpacing: '0px',
    },
    small: {
      fontSize: '36px',
      lineHeight: '44px',
      fontWeight: 400,
      letterSpacing: '0px',
    },
  },
  headline: {
    large: {
      fontSize: '32px',
      lineHeight: '40px',
      fontWeight: 400,
      letterSpacing: '0px',
    },
    medium: {
      fontSize: '28px',
      lineHeight: '36px',
      fontWeight: 400,
      letterSpacing: '0px',
    },
    small: {
      fontSize: '24px',
      lineHeight: '32px',
      fontWeight: 400,
      letterSpacing: '0px',
    },
  },
  title: {
    large: {
      fontSize: '22px',
      lineHeight: '28px',
      fontWeight: 500,
      letterSpacing: '0px',
    },
    medium: {
      fontSize: '16px',
      lineHeight: '24px',
      fontWeight: 500,
      letterSpacing: '0.15px',
    },
    small: {
      fontSize: '14px',
      lineHeight: '20px',
      fontWeight: 500,
      letterSpacing: '0.1px',
    },
  },
  body: {
    large: {
      fontSize: '16px',
      lineHeight: '24px',
      fontWeight: 400,
      letterSpacing: '0.5px',
    },
    medium: {
      fontSize: '14px',
      lineHeight: '20px',
      fontWeight: 400,
      letterSpacing: '0.25px',
    },
    small: {
      fontSize: '12px',
      lineHeight: '16px',
      fontWeight: 400,
      letterSpacing: '0.4px',
    },
  },
  label: {
    large: {
      fontSize: '14px',
      lineHeight: '20px',
      fontWeight: 500,
      letterSpacing: '0.1px',
    },
    medium: {
      fontSize: '12px',
      lineHeight: '16px',
      fontWeight: 500,
      letterSpacing: '0.5px',
    },
    small: {
      fontSize: '11px',
      lineHeight: '16px',
      fontWeight: 500,
      letterSpacing: '0.5px',
    },
  },
}

// Expressive elevation and shadows
export const expressiveElevation = {
  level0: 'none',
  level1: '0px 1px 2px rgba(0, 0, 0, 0.3), 0px 1px 3px 1px rgba(0, 0, 0, 0.15)',
  level2: '0px 1px 2px rgba(0, 0, 0, 0.3), 0px 2px 6px 2px rgba(0, 0, 0, 0.15)',
  level3: '0px 4px 8px 3px rgba(0, 0, 0, 0.15), 0px 1px 3px rgba(0, 0, 0, 0.3)',
  level4: '0px 6px 10px 4px rgba(0, 0, 0, 0.15), 0px 2px 3px rgba(0, 0, 0, 0.3)',
  level5: '0px 8px 12px 6px rgba(0, 0, 0, 0.15), 0px 4px 4px rgba(0, 0, 0, 0.3)',
}

// Expressive motion - enhanced easing curves
export const expressiveMotion = {
  duration: {
    short1: '50ms',
    short2: '100ms',
    short3: '150ms',
    short4: '200ms',
    medium1: '250ms',
    medium2: '300ms',
    medium3: '350ms',
    medium4: '400ms',
    long1: '450ms',
    long2: '500ms',
    long3: '550ms',
    long4: '600ms',
    extraLong1: '700ms',
    extraLong2: '800ms',
    extraLong3: '900ms',
    extraLong4: '1000ms',
  },
  easing: {
    // Expressive easing curves
    emphasized: 'cubic-bezier(0.2, 0, 0, 1)',
    emphasizedDecelerate: 'cubic-bezier(0.05, 0.7, 0.1, 1)',
    emphasizedAccelerate: 'cubic-bezier(0.3, 0, 0.8, 0.15)',
    standard: 'cubic-bezier(0.4, 0, 0.2, 1)',
    standardDecelerate: 'cubic-bezier(0, 0, 0, 1)',
    standardAccelerate: 'cubic-bezier(0.3, 0, 1, 1)',
    legacy: 'cubic-bezier(0.4, 0, 0.6, 1)',
    legacyDecelerate: 'cubic-bezier(0, 0, 0.2, 1)',
    legacyAccelerate: 'cubic-bezier(0.4, 0, 1, 1)',
  },
}

// Expressive shape system
export const expressiveShape = {
  corner: {
    none: '0px',
    extraSmall: '4px',
    small: '8px',
    medium: '12px',
    large: '16px',
    extraLarge: '28px',
    full: '9999px',
  },
}

// Expressive spacing scale
export const expressiveSpacing = {
  xs: '4px',
  sm: '8px',
  md: '12px',
  lg: '16px',
  xl: '24px',
  '2xl': '32px',
  '3xl': '48px',
  '4xl': '64px',
}
