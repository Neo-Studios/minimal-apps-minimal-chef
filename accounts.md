Here is how the account system wll work:
1. **User Registration**: Users can create an account by providing a username and email. 
2. **Email Verification**: After registration, users will receive an email with a verification link to confirm their email address.
3. They type in that code and it logs them in and it make a session on their device. Once expired they are required to login in again
4. **Login**: Users can log in using their username or email and a code will be emailed everytime. It is passwordless and all data from a user is stored under their email address. and stored _against_ a hash that is randomly generated when the user registers.
5. **Session Management**: The session will be stored in the browser's local storage or session storage.
Example:
User1 = user1@example.com = 35gd5d5e55a6d56a6e66f6g755e6e83
user2 = user2@example.com = 45hd5d5e55a6d56a6e66f6g755e6e84
the hash does not change after registration and login can happen on any device.
All data is stored in vercel database (use what ever type is aproppirote )