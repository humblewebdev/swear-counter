# Swear Counter

A simple React application to count how many times a streamer says a swear word.

## Features

- **+1 Swear Button**: Increment the counter when you hear a swear
- **-1 Button**: Decrement if you made a mistake
- **Reset**: Clear the counter (asks for confirmation)
- **Persistent Storage**: Count is saved in browser localStorage
- **Session Tracking**: Track swears in current session
- **Statistics**:
  - Total count (all time)
  - Session count
  - Session duration
  - Swears per minute rate

## How to Use

Simply open `index.html` in your web browser. No build process or npm installation required!

```bash
open index.html
```

Or double-click the file in your file explorer.

## Keyboard Shortcuts (Optional Enhancement)

You could add keyboard shortcuts like:
- Space bar or '+' to increment
- '-' to decrement
- 'R' to reset

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
