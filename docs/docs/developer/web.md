---
title: "Web"
---

The Zest web app is built with Next.js and React.

## Tech Stack

*   **Framework:** Next.js 14 with React 18 (App Router)
*   **Language:** TypeScript
*   **Styling:** Tailwind CSS with a custom Material 3 Expressive design system.
*   **State Management:** Zustand
*   **Data Fetching:** Firebase SDK
*   **Testing:**
    *   **Unit/Integration:** Vitest and React Testing Library
    *   **E2E:** Playwright

## Getting Started

1.  Navigate to the `web` directory:
    ```bash
    cd web
    ```
2.  Install dependencies:
    ```bash
    npm install
    ```
3.  Set up Firebase:
    *   Create a `.env.local` file in the `web` directory.
    *   Add your Firebase project's credentials to the `.env.local` file. See `web/.env.example` for an example.
4.  Run the development server:
    ```bash
    npm run dev
    ```

## Building and Running for Production

*   **Create a production build:** `npm run build`
*   **Start the production server:** `npm run start`

## Testing

*   **Run unit tests:** `npm test`
*   **Run E2E tests:** `npx playwright test`
