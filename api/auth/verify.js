import { put, list, del } from '@vercel/blob';

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { code } = req.body;

  if (!code) {
    return res.status(400).json({ error: 'Verification code required' });
  }

  try {
    const { blobs } = await list({ prefix: `verification-${code}` });
    if (blobs.length === 0) {
      return res.status(400).json({ error: 'Invalid or expired code' });
    }

    const verificationBlob = await fetch(blobs[0].url).then(r => r.json());
    if (verificationBlob.expires < Date.now()) {
      return res.status(400).json({ error: 'Code expired' });
    }

    const { email, type } = verificationBlob;
    const { blobs: userBlobs } = await list({ prefix: `user-${email.replace('@', '-at-')}` });
    
    if (userBlobs.length === 0) {
      return res.status(400).json({ error: 'User not found' });
    }

    const userData = await fetch(userBlobs[0].url).then(r => r.json());

    if (type === 'register') {
      userData.verified = true;
      await put(`user-${email.replace('@', '-at-')}.json`, JSON.stringify(userData), { access: 'public' });
    }

    await del(blobs[0].url);

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