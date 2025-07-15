import { put, list } from '@vercel/blob';
import crypto from 'crypto';
import nodemailer from 'nodemailer';

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { username, email } = req.body;

  if (!username || !email) {
    return res.status(400).json({ error: 'Username and email required' });
  }

  try {
    const { blobs } = await list({ prefix: `user-${email.replace('@', '-at-')}` });
    if (blobs.length > 0) {
      return res.status(400).json({ error: 'User already exists' });
    }

    const userHash = crypto.randomBytes(16).toString('hex');
    const verificationCode = Math.floor(100000 + Math.random() * 900000).toString();

    const userData = {
      username,
      email,
      hash: userHash,
      verified: false,
      createdAt: new Date().toISOString()
    };

    await put(`user-${email.replace('@', '-at-')}.json`, JSON.stringify(userData), { access: 'public' });
    await put(`verification-${verificationCode}.json`, JSON.stringify({ email, type: 'register', expires: Date.now() + 600000 }), { access: 'public' });

    const transporter = nodemailer.createTransporter({
      host: 'smtp.mailfence.com',
      port: 587,
      secure: false,
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
      }
    });

    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: email,
      subject: 'Minimal Chef - Verify Your Account',
      html: `
        <h2>Welcome to Minimal Chef!</h2>
        <p>Your verification code is: <strong>${verificationCode}</strong></p>
        <p>This code expires in 10 minutes.</p>
      `
    });

    res.status(200).json({ message: 'Registration successful' });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Registration failed' });
  }
}