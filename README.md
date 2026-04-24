# Swear Counter

A simple React application to count how many times a streamer says a swear word.

## Features

- **🔥 Real-time Shared Counters**: All users see the same count and updates happen instantly across all connected browsers (powered by Firebase)
- **Multiple Counters**: Track different categories of swears/events separately
- **Fully Configurable**: Customize everything via `config.json`:
  - App title and theme colors
  - Number and type of counters
  - Emojis and labels
  - Show/hide statistics
  - Enable/disable shared mode
- **Persistent Storage**: Counts are saved (localStorage for local mode, Firebase for shared mode)
- **Session Tracking**: Track current session separately from all-time totals
- **Statistics**:
  - Total count across all counters
  - Session count
  - Session duration
  - Rate per minute
- **Easy Customization**: No code changes needed - just edit `config.json`
- **Free Hosting**: Works perfectly with GitHub Pages

## Configuration

The app is configured via `config.json`. You can customize:

- **App title** and browser tab name
- **Theme colors** (primary, secondary, accent, danger)
- **Multiple counters** with custom:
  - Labels (e.g., "Mild Swears", "Extreme Swears")
  - Emojis (🤬, 😤, 💀, etc.)
  - Colors for each counter
- **Settings** to show/hide statistics, enable/disable confirmations, etc.

**Quick Example:**
```json
{
  "appTitle": "Stream Rage Meter",
  "counters": [
    {
      "id": "deaths",
      "label": "Deaths",
      "emoji": "💀",
      "color": "#ff4444"
    }
  ]
}
```

See [CONFIG.md](CONFIG.md) for full documentation and examples.

## Shared Counters (Real-time Sync)

Enable **shared counters** so all users see the same count in real-time:

1. **Set up Firebase** (free, takes 5 minutes) - follow [FIREBASE-SETUP.md](FIREBASE-SETUP.md)
2. **Update config.json** with your Firebase credentials
3. **Deploy** - all users will see synchronized counts!

When enabled:
- ✅ Anyone who clicks +1 updates the count for **everyone**
- ✅ Changes appear **instantly** across all browsers
- ✅ Perfect for live streams where viewers track together
- ✅ Works with GitHub Pages deployment

To disable shared mode and use local-only counters:
```json
{
  "settings": {
    "sharedCounters": false
  }
}
```

## How to Use

Since the app loads `config.json`, you need to run a local web server (browsers block loading local JSON files for security reasons).

### Option 1: Using the Start Script (Easiest)

```bash
./start-server.sh
```

Then open http://localhost:8000 in your browser.

### Option 2: Manual Server Start

Using Python (built-in on macOS/Linux):
```bash
python3 -m http.server 8000
```

Or using Node.js:
```bash
npx http-server -p 8000
```

Then open http://localhost:8000 in your browser.

### Option 3: Deployed Version

Once deployed to GitHub Pages, the app will work directly without needing a local server.

The app will load your configuration from `config.json` and display your custom counters.

## Deployment

This project is configured to automatically deploy to GitHub Pages when code is merged to the main branch.

### Setup Instructions

1. **Create a GitHub repository** and push this code:
   ```bash
   git add .
   git commit -m "Initial commit: Swear counter app"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

2. **Enable GitHub Pages**:
   - Go to your repository settings
   - Navigate to "Pages" (under "Code and automation")
   - Under "Build and deployment", set:
     - Source: "GitHub Actions"

3. **Automatic Deployment**:
   - The GitHub Actions workflow will automatically deploy on every push to main
   - Your site will be available at: `https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/`

4. **Manual Deployment** (optional):
   - Go to the "Actions" tab in your repository
   - Select "Deploy to GitHub Pages"
   - Click "Run workflow"

## Technologies

- React 18 (via CDN)
- Vanilla CSS
- LocalStorage for persistence
- GitHub Actions for CI/CD
- GitHub Pages for hosting
