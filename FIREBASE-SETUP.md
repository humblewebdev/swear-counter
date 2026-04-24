# Firebase Setup Guide

This guide will help you set up Firebase Realtime Database to enable shared counters across all users.

## Why Firebase?

With Firebase enabled:
- ✅ **All users see the same count** in real-time
- ✅ **Instant updates** when anyone clicks +1
- ✅ **Free tier** is generous (100 simultaneous connections, 1GB storage)
- ✅ **No backend server needed** - works with static GitHub Pages deployment

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or "Create a project"
3. Enter a project name (e.g., "swear-counter")
4. Disable Google Analytics (optional, not needed for this app)
5. Click "Create project"

## Step 2: Enable Realtime Database

1. In your Firebase project, click "Realtime Database" in the left sidebar
2. Click "Create Database"
3. Choose a location (select closest to your users)
4. **Start in test mode** (we'll secure it in Step 4)
5. Click "Enable"

## Step 3: Get Your Firebase Configuration

1. In Firebase Console, click the gear icon (⚙️) > "Project settings"
2. Scroll down to "Your apps"
3. Click the web icon (`</>`) to add a web app
4. Give it a nickname (e.g., "Swear Counter Web")
5. **Don't** check "Firebase Hosting" (we're using GitHub Pages)
6. Click "Register app"
7. Copy the `firebaseConfig` object

It will look like this:
```javascript
const firebaseConfig = {
  apiKey: "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  authDomain: "your-project-id.firebaseapp.com",
  databaseURL: "https://your-project-id-default-rtdb.firebaseio.com",
  projectId: "your-project-id",
  storageBucket: "your-project-id.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:abcdef123456"
};
```

## Step 4: Update config.json

Open `config.json` and replace the placeholder Firebase config:

```json
{
  "settings": {
    "sharedCounters": true,
    "firebaseConfig": {
      "apiKey": "YOUR_ACTUAL_API_KEY",
      "authDomain": "your-project-id.firebaseapp.com",
      "databaseURL": "https://your-project-id-default-rtdb.firebaseio.com",
      "projectId": "your-project-id",
      "storageBucket": "your-project-id.appspot.com",
      "messagingSenderId": "YOUR_SENDER_ID",
      "appId": "YOUR_APP_ID"
    },
    "counterSessionId": "default"
  }
}
```

**Note on `counterSessionId`:**
- Use `"default"` for a single shared counter
- Use different IDs (e.g., `"stream-2024-04-24"`) to create separate counter sessions
- All users with the same session ID will see the same counts

## Step 5: Secure Your Database (Important!)

By default, test mode allows anyone to read/write for 30 days. Let's secure it:

1. Go to Firebase Console > Realtime Database > Rules
2. Replace the rules with:

```json
{
  "rules": {
    "sessions": {
      "$sessionId": {
        "counters": {
          ".read": true,
          ".write": true
        }
      }
    }
  }
}
```

This allows anyone to read and write counters. For production, you might want to add authentication or rate limiting.

**Optional: Add rate limiting to prevent spam:**

```json
{
  "rules": {
    "sessions": {
      "$sessionId": {
        "counters": {
          "$counterId": {
            ".read": true,
            ".write": "newData.val() >= 0 && newData.val() <= 999999"
          }
        }
      }
    }
  }
}
```

3. Click "Publish"

## Step 6: Test It

1. Start your local server:
   ```bash
   ./start-server.sh
   ```

2. Open http://localhost:8000 in two different browser windows (or one regular + one incognito)

3. Click "+1" in one window - you should see the count update in **both windows** instantly!

## Using Different Sessions

You can create separate counter sessions by changing `counterSessionId` in `config.json`:

```json
"counterSessionId": "stream-2024-04-24"
```

Each session ID creates an isolated set of counters. This is useful for:
- Different streams or events
- Testing vs production
- Multiple streamers using the same deployment

## Troubleshooting

### "Failed to load configuration" error
- Make sure you're running a local server (not opening file:// directly)
- Check that config.json is valid JSON

### Counters not syncing
- Check browser console for errors
- Verify your Firebase config is correct
- Ensure Realtime Database is enabled in Firebase Console
- Check database rules allow read/write access

### Firebase initialization failed
- Verify all Firebase config values are correct (no placeholders)
- Check that `databaseURL` includes your project ID
- Make sure Realtime Database (not Firestore) is enabled

### Counts reset on page load
- Check that `sharedCounters: true` in config.json
- Verify Firebase initialized successfully (check browser console)
- Ensure database rules allow reading data

## Disabling Shared Counters

To go back to local-only counters:

```json
{
  "settings": {
    "sharedCounters": false,
    "persistData": true
  }
}
```

The app will automatically use localStorage instead of Firebase.

## Cost

Firebase Realtime Database free tier includes:
- **1 GB stored**: More than enough for counters
- **10 GB/month downloaded**: Plenty for this use case
- **100 simultaneous connections**: ~100 concurrent users

For most use cases, you'll never exceed the free tier. [See pricing](https://firebase.google.com/pricing)

## Security Notes

⚠️ **Your Firebase API key is public** - this is normal and expected for web apps. The security comes from database rules, not hiding the API key.

⚠️ **Test mode expires in 30 days** - make sure to set up proper rules (Step 5) before the test period ends.

## Next Steps

Once Firebase is set up and working:
1. Deploy to GitHub Pages - Firebase works the same way
2. Share the URL with your community
3. Everyone will see synchronized counts in real-time!
