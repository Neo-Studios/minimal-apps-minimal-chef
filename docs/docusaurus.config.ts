import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'Zest Documentation',
  tagline: 'Your guide to the Zest cooking app',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://zest-docs-five.vercel.app',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/',
  headTags: [
    {
      tagName: 'link',
      attributes: {
        rel: 'preconnect',
        href: 'https://fonts.googleapis.com',
      },
    },
    {
      tagName: 'link',
      attributes: {
        rel: 'preconnect',
        href: 'https://fonts.gstatic.com',
        crossorigin: 'anonymous',
      },
    },
    {
      tagName: 'link',
      attributes: {
        href: 'https://fonts.googleapis.com/css2?family=Google+Sans+Flex:wght@400;700&family=Google+Sans+Mono:wght@400;700&display=swap',
        rel: 'stylesheet',
      },
    },
  ],

  // GitHub pages deployment config.
  organizationName: 'Neo-Studios', // Usually your GitHub org/user name.
  projectName: 'zest', // Usually your repo name.

  onBrokenLinks: 'throw',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          routeBasePath: '/docs',
          editUrl:
            'https://github.com/Neo-Studios/zest/tree/main/docs/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    image: 'img/zest-social-card.jpg',
    colorMode: {
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: 'Zest',
      logo: {
        alt: 'Zest Logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'doc',
          docId: 'user/index',
          position: 'left',
          label: 'User Docs',
          sidebarId: 'userSidebar',
        },
        {
          type: 'doc',
          docId: 'developer/index',
          position: 'left',
          label: 'Developer Docs',
          sidebarId: 'developerSidebar',
        },
        {
          href: 'https://github.com/Neo-Studios/zest',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'User Docs',
              to: '/docs/user/',
            },
            {
              label: 'Developer Docs',
              to: '/docs/developer/',
            },
          ],
        },

        {
          title: 'More',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/Neo-Studios/zest',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} Neo Studios. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,
};

export default config;