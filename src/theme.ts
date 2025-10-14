import { createTheme, Theme } from '@mui/material/styles';

const lightTheme: Theme = createTheme({
  palette: {
    mode: 'light',
    primary: {
      main: '#203141',
    },
    background: {
      default: '#EADDCB',
      paper: '#F5F0E8',
    },
    text: {
      primary: '#203141',
    },
  },
  typography: {
    fontFamily: '"Inter", sans-serif',
    h1: { fontFamily: '"Inter", sans-serif' },
    h2: { fontFamily: '"Inter", sans-serif' },
    h3: { fontFamily: '"Inter", sans-serif' },
    h4: { fontFamily: '"Inter", sans-serif' },
    h5: { fontFamily: '"Inter", sans-serif' },
    h6: { fontFamily: '"Inter", sans-serif' },
    subtitle1: { fontFamily: '"Inter", sans-serif' },
    subtitle2: { fontFamily: '"Inter", sans-serif' },
    body1: { fontFamily: '"Inter", sans-serif' },
    body2: { fontFamily: '"Inter", sans-serif' },
    button: { fontFamily: '"Inter", sans-serif' },
    caption: { fontFamily: '"Inter", sans-serif' },
    overline: { fontFamily: '"Inter", sans-serif' },
  },
});

const darkTheme: Theme = createTheme({
  palette: {
    mode: 'dark',
    primary: {
      main: '#EADDCB',
    },
    background: {
      default: '#203141',
      paper: '#2A3F52',
    },
    text: {
      primary: '#EADDCB',
    },
  },
  typography: lightTheme.typography,
});

export { lightTheme, darkTheme };