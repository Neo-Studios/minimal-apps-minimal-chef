---
layout: page
title: Getting Started
permalink: /getting-started/
---

# Getting Started

## Prerequisites

- Node.js 16+ and npm
- Git

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/EthanCoderPenguin2012/minimal-chef.git
   cd minimal-chef
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` and add your API keys:
   ```
   REACT_APP_ANTHROPIC_API_KEY=your_claude_api_key
   EMAIL_USER=your_mailfence_email
   EMAIL_PASS=your_mailfence_password
   ```

4. **Start development server**
   ```bash
   npm start
   ```

5. **Open in browser**
   Navigate to [http://localhost:3000](http://localhost:3000)

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `REACT_APP_ANTHROPIC_API_KEY` | Claude AI API key for recipe generation | Optional |
| `EMAIL_USER` | Mailfence email for authentication | Optional |
| `EMAIL_PASS` | Mailfence password | Optional |
| `BLOB_READ_WRITE_TOKEN` | Vercel Blob storage token | Optional |

## Deployment

### Vercel (Recommended)

1. Fork the repository
2. Connect to Vercel
3. Add environment variables in Vercel dashboard
4. Deploy automatically on push

### Manual Build

```bash
npm run build
# Upload build/ folder to your hosting provider
```