# Configuration Guide

The swear counter app uses `config.json` to customize its appearance and behavior.

## Configuration File Structure

```json
{
  "appTitle": "Your App Title",
  "theme": { ... },
  "counters": [ ... ],
  "settings": { ... }
}
```

## Options

### App Title

```json
"appTitle": "Swear Counter"
```

The title displayed at the top of the app and in the browser tab.

### Theme

Control the color scheme of your app:

```json
"theme": {
  "primaryColor": "#667eea",    // Main gradient color (top)
  "secondaryColor": "#764ba2",  // Main gradient color (bottom)
  "accentColor": "#f093fb",     // Decrement button color
  "dangerColor": "#ff6b6b"      // Reset button color
}
```

All colors should be in hex format (e.g., `#667eea`).

### Counters

Define multiple counters to track different categories:

```json
"counters": [
  {
    "id": "general",           // Unique identifier (used for storage)
    "label": "General Swears", // Display name
    "emoji": "🤬",             // Emoji icon
    "color": "#667eea",        // Counter color (hex)
    "initialCount": 0          // Starting count (optional, defaults to 0)
  },
  {
    "id": "mild",
    "label": "Mild Swears",
    "emoji": "😤",
    "color": "#4ecdc4",
    "initialCount": 5          // Can set to any number
  }
]
```

**Important:**
- `id` must be unique for each counter
- `initialCount` is optional and defaults to 0 if not specified
- If `persistData` is enabled and a saved count exists, it takes precedence over `initialCount`
- Changing an `id` will reset that counter's saved data
- You can have as many counters as you want

### Settings

Control app behavior:

```json
"settings": {
  "overlayMode": false,         // Enable transparent OBS overlay mode
  "showSessionStats": true,     // Show session statistics
  "showTotalStats": true,       // Show total count across all counters
  "showRate": true,             // Show swears per minute rate
  "confirmReset": true,         // Ask for confirmation before resetting
  "persistData": true,          // Save counts to localStorage
  "sharedCounters": false,      // Enable Firebase real-time sync
  "firebaseConfig": { ... },    // Firebase configuration (see FIREBASE-SETUP.md)
  "counterSessionId": "default" // Session ID for shared counters
}
```

**Setting Details:**

- **overlayMode**: When `true`, enables transparent background and hides buttons - perfect for OBS browser source overlays. See [OBS-SETUP.md](OBS-SETUP.md).
- **showSessionStats/showTotalStats/showRate**: Control which statistics are displayed.
- **confirmReset**: Ask for confirmation before resetting counters (recommended: `true`).
- **persistData**: Save counts to browser storage (localStorage or Firebase).
- **sharedCounters**: Enable real-time synchronization across all users via Firebase. Requires `firebaseConfig` to be set. See [FIREBASE-SETUP.md](FIREBASE-SETUP.md).
- **counterSessionId**: Isolates counter data by session ID. Change this to create separate counter instances (e.g., different streams, different days).

## Example Configurations

### Single Counter (Simple)

```json
{
  "appTitle": "Swear Counter",
  "theme": {
    "primaryColor": "#667eea",
    "secondaryColor": "#764ba2",
    "accentColor": "#f093fb",
    "dangerColor": "#ff6b6b"
  },
  "counters": [
    {
      "id": "swears",
      "label": "Swear Count",
      "emoji": "🤬",
      "color": "#667eea"
    }
  ],
  "settings": {
    "showSessionStats": true,
    "showTotalStats": true,
    "showRate": true,
    "confirmReset": true,
    "persistData": true
  }
}
```

### Game Stream Counter

```json
{
  "appTitle": "Stream Rage Meter",
  "theme": {
    "primaryColor": "#9146ff",
    "secondaryColor": "#772ce8",
    "accentColor": "#00f593",
    "dangerColor": "#ff4444"
  },
  "counters": [
    {
      "id": "deaths",
      "label": "Deaths",
      "emoji": "💀",
      "color": "#ff4444"
    },
    {
      "id": "rages",
      "label": "Rage Moments",
      "emoji": "😡",
      "color": "#ff8800"
    },
    {
      "id": "laughs",
      "label": "Good Vibes",
      "emoji": "😂",
      "color": "#00f593"
    }
  ],
  "settings": {
    "showSessionStats": true,
    "showTotalStats": true,
    "showRate": true,
    "confirmReset": true,
    "persistData": true
  }
}
```

### Minimalist (No Stats)

```json
{
  "appTitle": "Counter",
  "theme": {
    "primaryColor": "#2c3e50",
    "secondaryColor": "#34495e",
    "accentColor": "#95a5a6",
    "dangerColor": "#e74c3c"
  },
  "counters": [
    {
      "id": "count",
      "label": "Count",
      "emoji": "📊",
      "color": "#3498db"
    }
  ],
  "settings": {
    "showSessionStats": false,
    "showTotalStats": false,
    "showRate": false,
    "confirmReset": true,
    "persistData": true
  }
}
```

### With Initial Counts (Pre-populated)

Useful for migrating data, testing, or continuing from a previous count:

```json
{
  "appTitle": "Previous Stream Stats",
  "theme": {
    "primaryColor": "#667eea",
    "secondaryColor": "#764ba2",
    "accentColor": "#f093fb",
    "dangerColor": "#ff6b6b"
  },
  "counters": [
    {
      "id": "general",
      "label": "General Swears",
      "emoji": "🤬",
      "color": "#667eea",
      "initialCount": 42
    },
    {
      "id": "mild",
      "label": "Mild Swears",
      "emoji": "😤",
      "color": "#4ecdc4",
      "initialCount": 15
    },
    {
      "id": "extreme",
      "label": "Extreme Swears",
      "emoji": "💀",
      "color": "#ff6b6b",
      "initialCount": 7
    }
  ],
  "settings": {
    "showSessionStats": true,
    "showTotalStats": true,
    "showRate": true,
    "confirmReset": true,
    "persistData": false
  }
}
```

**Note:** With `persistData: false`, the counters will reset to `initialCount` on each reload.

## Tips

1. **Test Your Colors**: Use a color picker tool to find hex codes that work well together
2. **Emoji Support**: Most modern emojis work, but test in your target browser
3. **Backup Your Config**: Save a copy before making major changes
4. **Clear Storage**: If you change counter IDs, clear localStorage to avoid confusion:
   ```javascript
   // In browser console:
   localStorage.clear()
   ```

## Common Issues

### Config Not Loading
- Ensure `config.json` is in the same directory as `index.html`
- Check for JSON syntax errors (use a JSON validator)
- Check browser console for error messages

### Colors Not Showing
- Verify hex colors start with `#`
- Ensure all colors are valid 6-digit hex codes

### Counts Resetting
- Check that `persistData` is set to `true`
- Verify you haven't changed the counter `id`
- Check browser localStorage isn't being cleared
