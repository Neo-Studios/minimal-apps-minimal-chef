# Minimal Chef

A minimalist cooking companion app built with React and Material-UI.

>[!NOTE]
> This is the dev branch. Here you can find and preview the latest features and updates before they are merged into the main branch. As it is a developer branch, things are exprimental and may not be fully stable. Use with caution, and report any issues you encounter. For the online version click [here](https://minimal-chef-dev.vercel.app/).
## Features 

- **Recipe Management**: Browse and search your recipe collection
- **Discover**: Explore new recipes from various cuisines
- **Shopping List**: Organized grocery list with categories
- **Dark/Light Mode**: Toggle between themes
- **Responsive Design**: Works on desktop, tablet, and mobile
- **Material 3 Design**: Clean, minimalist interface

## Design Specifications

- **Light Mode**: Base color  #EADDCB
- **Dark Mode**: Base color  #203141
- **Typography**: Times New Roman for headings, Noto Sans for body text
- **Layout**: Hideable sidebar on desktop, bottom navigation on mobile
- **FAB**: Floating action button for quick actions

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/EthanCoderPenguin2012/minimal-chef.git
   cd minimal-chef
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables:
   ```bash
   cp .env.example .env
   ```
   Edit `.env` and add your Claude API key:
   ```
   REACT_APP_ANTHROPIC_API_KEY=your_actual_api_key_here
   ```

4. Start the development server:
   ```bash
   npm start
   ```

5. Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

## Deployment

This app is configured for automatic deployment to Vercel:

1. Fork this repository
2. Connect your GitHub repository to Vercel
3. Vercel will automatically deploy on every push to `main`
4. Add your `REACT_APP_ANTHROPIC_API_KEY` in Vercel's environment variables
5. Your app will be available at your Vercel domain

### Manual Deployment

To deploy manually:
```bash
npm run build
# Then upload the build folder to your hosting provider
```

## API Configuration

To use AI recipe generation, you need a Claude API key from Anthropic:
1. Sign up at [console.anthropic.com](https://console.anthropic.com)
2. Create an API key
3. Add it to your `.env` file as `REACT_APP_ANTHROPIC_API_KEY`

**Note**: For Vercel deployment, add your API key as an environment variable in your Vercel dashboard under Settings > Environment Variables.

## Features

✅ **Recipe Management**: Browse and search recipes  
✅ **Discover**: Explore international cuisines  
✅ **Shopping List**: Categorized grocery lists  
✅ **Meal Logging**: Track daily meals and calories  
✅ **AI Recipe Generation**: Claude-powered recipe creation  
✅ **Voice Chef**: Step-by-step voice instructions  
✅ **Recipe Import**: Import from URLs with serving adjustment  
✅ **Manual Recipe Creation**: Build custom recipes  
✅ **International Database**: Recipes from multiple countries  
✅ **Recipe Timer**: Multiple simultaneous cooking timers  
✅ **Nutrition Tracker**: Daily macro and calorie tracking  
✅ **Recipe Roulette**: Random recipe suggestions with filters  
✅ **Dark/Light Mode**: Theme switching  
✅ **Responsive Design**: Mobile and desktop optimized  
✅ **Analytics & Speed Insights**: Vercel performance tracking
