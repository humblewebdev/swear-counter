# OBS Overlay Setup Guide

Use the swear counter as a transparent overlay on your stream!

## Step 1: Enable Overlay Mode

Edit `config.json` and set:

```json
{
  "settings": {
    "overlayMode": true
  }
}
```

When overlay mode is enabled:
- ✅ **Transparent background** - only counters visible
- ✅ **Enhanced readability** - larger text with strong shadows
- ✅ **No buttons** - view-only (control from separate browser tab)
- ✅ **Dark semi-transparent cards** - readable on any background

## Step 2: Deploy or Run Locally

### Option A: Use GitHub Pages (Recommended)

1. Deploy your app to GitHub Pages following [DEPLOY.md](DEPLOY.md)
2. Your overlay URL will be: `https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/`
3. This is the cleanest option - no need to run a local server while streaming

### Option B: Run Local Server

```bash
./start-server.sh
```

Your overlay URL will be: `http://localhost:8000`

**Note:** Local server must be running during your entire stream.

## Step 3: Add Browser Source in OBS

1. Open OBS Studio
2. In your scene, click the **+** button under Sources
3. Select **Browser**
4. Name it "Swear Counter" and click OK
5. Configure the browser source:

   **URL:**
   - GitHub Pages: `https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/`
   - Local: `http://localhost:8000`

   **Width:** `800`
   **Height:** `600`

   **FPS:** `30`

   ☑️ Check **"Shutdown source when not visible"**
   ☑️ Check **"Refresh browser when scene becomes active"**

6. Click **OK**

## Step 4: Position and Resize

1. The overlay will appear in your scene
2. **Resize** - Drag corners to make it larger/smaller
3. **Position** - Drag to corner or side of screen
4. **Lock** - Right-click > Lock to prevent accidental moves

### Recommended Positions

- **Top-left corner** - Classic placement
- **Bottom-right corner** - Non-intrusive
- **Below webcam** - Integrated with facecam
- **Sidebar** - Dedicate a vertical strip

## Step 5: Control the Counter

While streaming, keep the counter URL open in a separate browser tab:

1. Open the same URL in Chrome/Firefox
2. This tab will have **buttons visible** (not in OBS overlay)
3. Click +1 when you hear a swear
4. The OBS overlay updates **instantly** via Firebase

**Tip:** Keep this control tab on a second monitor or alt-tab to it.

## Customization for Streaming

### Adjust Counter Size

In `config.json`, you can remove counters you don't need:

```json
{
  "counters": [
    {
      "id": "swears",
      "label": "Swear Count",
      "emoji": "🤬",
      "color": "#667eea",
      "initialCount": 0
    }
  ]
}
```

### Hide Statistics

To show only the counters without stats:

```json
{
  "settings": {
    "showSessionStats": false,
    "showTotalStats": false,
    "showRate": false
  }
}
```

### Change Colors

Match your stream branding:

```json
{
  "counters": [
    {
      "id": "swears",
      "label": "Swear Count",
      "emoji": "🤬",
      "color": "#ff0000"  // Your brand color
    }
  ]
}
```

## Advanced: Control Panel + Overlay

You can run two versions simultaneously:

### 1. Create `config-overlay.json`

```json
{
  "appTitle": "Swear Counter Overlay",
  "settings": {
    "overlayMode": true,
    "showSessionStats": false
  }
}
```

### 2. Create `overlay.html`

Copy `index.html` to `overlay.html` and change line that loads config:

```javascript
fetch('config-overlay.json')  // instead of 'config.json'
```

### 3. Use Different URLs

- **Control panel:** `http://localhost:8000/index.html` (buttons visible)
- **OBS overlay:** `http://localhost:8000/overlay.html` (transparent, no buttons)

## Troubleshooting

### Overlay shows white background
- Verify `overlayMode: true` in config.json
- Refresh the browser source in OBS (right-click > Refresh)

### Counters not updating in OBS
- Make sure `sharedCounters: true` in config
- Verify Firebase is set up correctly ([FIREBASE-SETUP.md](FIREBASE-SETUP.md))
- Check that both control tab and OBS use the same `counterSessionId`

### Overlay is too small/large
- Resize the browser source in OBS
- Or adjust CSS in overlay mode section of index.html

### Text not readable on stream
- Change counter colors to higher contrast
- Adjust background opacity in CSS (`.counter-card` alpha value)

### Overlay lags or stutters
- Lower FPS in browser source (try 15 FPS instead of 30)
- Reduce browser source resolution
- Check your computer's CPU usage

## Best Practices

1. **Test before going live** - Add the overlay in a test scene first
2. **Lock the source** - Prevent accidental movement during stream
3. **Use a hotkey** - Set up OBS hotkey to show/hide the overlay
4. **Monitor performance** - Browser sources can use CPU, watch your encoding stats
5. **Keep control tab open** - Don't close it during stream or counts won't update

## Alternative: Stream Deck Integration

If you have an Elgato Stream Deck:

1. Add a **Website** button
2. Set URL to your counter URL with a query parameter
3. The button can open your control panel for quick access

## Questions?

- Test the overlay in OBS before your stream
- Position it where it won't block important stream elements
- Make sure colors are visible against your game/content
- Consider making it smaller than you think - viewers see it differently than you do!

Enjoy tracking those swears live! 🤬📊
