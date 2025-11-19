---
title: "Backend"
---

The Zest backend is built on Firebase.

## Services

*   **Authentication:** Firebase Authentication is used to manage user accounts.
*   **Database:** Firestore is used as the primary database for storing recipes, meal plans, and other user data.
*   **Storage:** Firebase Storage is used to store recipe images and other user-generated content.

## Offline Support

Firestore's local persistence is enabled on all platforms to provide a seamless offline experience.

## Security

Firebase Security Rules are used to secure the data in Firestore and Firebase Storage. These rules are defined in the `firestore.rules` and `storage.rules` files.
