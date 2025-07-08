import { createTheme } from '@mui/material/styles';

const lightTheme = createTheme({
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
    h1: { fontFamily: '"Times New Roman", serif' },
    h2: { fontFamily: '"Times New Roman", serif' },
    h3: { fontFamily: '"Times New Roman", serif' },
    h4: { fontFamily: '"Times New Roman", serif' },
    h5: { fontFamily: '"Times New Roman", serif' },
    h6: { fontFamily: '"Times New Roman", serif' },
    subtitle1: { fontFamily: '"Times New Roman", serif' },
    subtitle2: { fontFamily: '"Times New Roman", serif' },
    body1: { fontFamily: '"Noto Sans", sans-serif' },
    body2: { fontFamily: '"Noto Sans", sans-serif' },
    button: { fontFamily: '"Noto Sans", sans-serif' },
    caption: { fontFamily: '"Noto Sans", sans-serif' },
    overline: { fontFamily: '"Noto Sans", sans-serif' },
  },
});

const darkTheme = createTheme({
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