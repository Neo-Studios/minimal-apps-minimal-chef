# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability in  Chef, please report it responsibly.

### How to Report

**DO NOT** open a public issue for security vulnerabilities.

Instead, please email security concerns to: [your-security-email@example.com]

Include in your report:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### What to Expect

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 1 week
- **Fix Timeline**: Depends on severity
  - Critical: 1-7 days
  - High: 1-2 weeks
  - Medium: 2-4 weeks
  - Low: Next release cycle

### Security Best Practices

When using Zest, please follow these security best practices:

1. **Firebase Configuration**:
   - Never commit `firebase_options.dart` to version control
   - Keep `google-services.json` and `GoogleService-Info.plist` private
   - Use environment-specific Firebase projects

2. **API Keys**:
   - Store sensitive keys in `.env` (excluded from git)
   - Never hardcode credentials in source code

3. **Authentication**:
   - Use strong authentication methods
   - Keep Firebase Auth rules up to date
   - Review Firestore security rules regularly

4. **Data Privacy**:
   - User data is stored in Firebase Firestore
   - Image URLs can be stored as external links (no Firebase Storage used)
   - Review Firebase privacy settings

## Known Security Considerations

### Firestore Rules

Current rules ensure:Minimal

- Users can only read/write their own data
- Authentication required for all operations
- User ID validation on create/update operations

### Dependencies

- Regularly update Flutter and package dependencies
- Monitor for security advisories
- Run `flutter pub outdated` periodically

## Security Updates

Security updates will be released as patch versions (e.g., 0.1.1) and documented in CHANGELOG.md.

## Disclosure Policy

- Security issues will be disclosed after a fix is available
- Credit will be given to reporters (unless anonymity requested)
- CVE IDs will be requested for significant vulnerabilities
