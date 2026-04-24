# Manual Session Control

The swear counter now includes manual session control, allowing you to start, pause, and reset the session timer independently.

## Features

- **Manual Start/Stop** - Control when the session timer runs
- **Pause/Resume** - Pause the timer during breaks and resume later
- **Synced Across Users** - When using Firebase, all users see the same session state
- **Persistent Timing** - Session duration persists even if you reload the page
- **Visual Status** - Clear indicators showing if session is running, paused, or stopped

## How It Works

### Session States

1. **Not Started** (⏹ gray)
   - Session timer is at 0
   - Click "Start Session" to begin

2. **Running** (● green)
   - Timer is actively counting
   - Click "Pause" to pause the timer

3. **Paused** (⏸ orange)
   - Timer is stopped but retains elapsed time
   - Click "Resume" to continue counting

### Session Controls

**▶ Start Session**
- Begins the session timer from 0
- Resets session counter counts to 0
- Changes status to "Running"

**⏸ Pause**
- Stops the timer while retaining elapsed time
- Useful for breaks, intermissions, or pauses
- Session count remains unchanged

**▶ Resume**
- Continues timing from where it was paused
- All counts remain unchanged

**🔄 Reset Session**
- Stops the timer and resets to 0
- Asks for confirmation (if enabled in settings)
- Does NOT reset counter values (use "Reset All Counters" for that)

## Usage Scenarios

### Streaming

```
1. Start OBS and open the counter control panel
2. Click "Start Session" when stream goes live
3. During breaks: Click "Pause"
4. After break: Click "Resume"
5. End of stream: Click "Reset Session" to prepare for next stream
```

### Shared Viewing Party

```
1. Start session when the video/stream begins
2. All viewers see the same session duration
3. Pause during technical difficulties
4. Resume when back online
```

### Testing

```
1. Click "Start Session"
2. Test your counters
3. Click "Reset Session" to start fresh
```

## With Shared Counters (Firebase)

When `sharedCounters: true`:
- ✅ **All users see the same session state**
- ✅ When anyone clicks Start/Pause/Resume/Reset, it affects everyone
- ✅ Session duration is synchronized in real-time
- ✅ Great for coordinated viewing or streaming

### Who Should Control the Session?

- **Streamer** - Has the control panel open
- **Moderator** - Can be given access to control panel
- **Viewers** - See the overlay with current session time (read-only)

## Without Shared Counters

When `sharedCounters: false`:
- Each browser tab has its own independent session timer
- Session state stored in browser memory
- Reloading page resets session (not persistent)

## OBS Overlay Mode

When `overlayMode: true`:
- Session controls are **hidden** in the overlay
- Session duration is **visible** in stats (if enabled)
- Control the session from a separate browser tab

**Setup:**
1. Control Panel: Open `http://localhost:8000` in browser tab (buttons visible)
2. OBS Overlay: Add as Browser Source (buttons hidden)
3. Click session controls in control panel
4. OBS overlay updates automatically

## Statistics Display

The session timer affects these statistics:

**Session Duration**
- Shows elapsed time in minutes
- Updates every minute when running
- Pauses when session is paused

**Rate**
- Calculated as: Total Session Count / Session Duration
- Only shown when session duration > 0
- Example: 42 swears / 15 min = 2.8/min

## Tips

1. **Start session when you go live** - More accurate statistics
2. **Pause during breaks** - Prevents skewed rate calculations
3. **Reset between streams** - Start fresh each time
4. **Don't refresh the page** - Session state persists in Firebase but reloading can cause brief desyncs
5. **Test before streaming** - Make sure session controls work as expected

## Keyboard Shortcuts (Future Feature)

Potential additions:
- `Space` - Start/Pause session
- `R` - Reset session
- `S` - Start session

## Troubleshooting

### Session controls not syncing
- Ensure `sharedCounters: true` in config.json
- Verify Firebase is initialized (check browser console)
- All users must use the same `counterSessionId`

### Session resets on page reload
- Check that Firebase is properly configured
- Ensure `sharedCounters: true`
- Without Firebase, session state is not persistent

### Session duration not updating
- Make sure session is in "Running" state (green dot)
- Check that page isn't frozen or in background (some browsers throttle timers)

### Multiple users controlling session
- This is normal with shared counters
- Coordinate who has control, or accept that anyone can control it
- Consider: Only give control panel URL to moderators

## Configuration

No special configuration needed - session controls are always available.

To hide session duration from stats:
```json
{
  "settings": {
    "showSessionStats": false
  }
}
```

To hide rate calculation:
```json
{
  "settings": {
    "showRate": false
  }
}
```

## Privacy Note

Session state is stored in Firebase under:
```
sessions/{counterSessionId}/sessionState/
```

This includes:
- Start time (ISO timestamp)
- Paused time (seconds)
- Running status (boolean)

This data is separate from counter values and can be reset independently.
