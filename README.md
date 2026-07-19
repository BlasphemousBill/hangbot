# Hangbot — 8-Bit

An offline-capable word game: 1800 words across 9 categories, a rescue-or-scrap
robot, and an EDM soundtrack synthesized live in the browser (no audio files).

Installable to a phone home screen as a PWA.

## Files

| File | What it is |
|---|---|
| `index.html` | The entire game — markup, styles, word list, music engine |
| `manifest.webmanifest` | App name, icons, colors, standalone display |
| `sw.js` | Service worker; caches everything for offline play |
| `icon-*.png`, `apple-touch-icon.png`, `favicon-32.png` | App icons (pixel robot) |
| `serve.sh` | Local web server for installing onto a phone |

## Play on this Mac

Double-click `index.html`. Works with no server and no network.

Note: opened this way (`file://`) the browser will not register a service
worker, so there is no installed-app mode — just the game in a tab. That's a
browser security rule, not a bug.

## Install on your phone

### Option A — over Wi-Fi (fastest, Mac must stay on)

```bash
./serve.sh
```

It prints a `http://192.168.x.x:8080/` address. On your phone, same Wi-Fi:

- **iPhone** — open it in **Safari** (not Chrome), tap **Share** → **Add to
  Home Screen**. It launches full-screen with no browser chrome.
- **Android** — open it in **Chrome**, tap **⋮** → **Install app**.

The icon and full-screen mode work over plain http. Offline caching does *not*
— service workers require https — so the Mac needs to keep serving.

### Option B — real offline app (recommended)

Put these files on any static https host, then install from that URL. The
service worker caches the whole game on first load, after which it runs with no
network at all — airplane mode, no laptop.

Free options that take a drag-and-drop folder: Netlify Drop, Cloudflare Pages,
GitHub Pages, Vercel.

## After changing index.html

Bump the cache name in `sw.js` so installed phones pick up the new version:

```js
const CACHE = "hangbot-v3";   // was v1
```

Without this, phones keep serving the old cached copy.

## Phone-specific behavior

- Safe-area padding so the board clears notches and home indicators
- 44px minimum tap targets on touch screens
- No double-tap zoom, no pull-to-refresh, no text selection or tap highlights
- Layout stacks to one column under 860px with the game on top, so the board
  and keyboard are usable without scrolling
- A separate landscape layout shrinks the board to keep the keyboard on screen
- Music pauses when you background the app and resumes when you return
- Audio needs one tap to start — browsers block autoplay

## Want a real App Store build?

This is a PWA, so it installs without a store. To ship to the App Store or Play
Store, wrap it with [Capacitor](https://capacitorjs.com): `npm i @capacitor/cli`,
`npx cap init`, drop these files in `www/`, then `npx cap add ios android`. The
game code needs no changes. That path needs Xcode/Android Studio and developer
accounts.
