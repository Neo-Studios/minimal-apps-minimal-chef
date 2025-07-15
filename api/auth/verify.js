import { kv } from '@vercel/kv';

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { code } = req.body;

  if (!code) {
    return res.status(400).json({ error: 'Verification code required' });
  }

  try {
    const verificationData = await kv.get(`verification:${code}`);
    if (!verificationData) {
      return res.status(400).json({ error: 'Invalid or expired code' });
    }

    const { email, type } = verificationData;
    const userData = await kv.get(`user:${email}`);

    if (!userData) {
      return res.status(400).json({ error: 'User not found' });
    }

    if (type === 'register') {
      userData.verified = true;
      await kv.set(`user:${email}`, userData);
    }

    await kv.del(`verification:${code}`);

    const { hash, ...userResponse } = userData;
    res.status(200).json({ 
      message: 'Verification successful',
      user: userResponse
    });
  } catch (error) {
    console.error('Verification error:', error);
    res.status(500).json({ error: 'Verification failed' });
  }
}