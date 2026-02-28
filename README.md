<p align="center">
  <img src="img/app-icon.png" width="128" alt="Delyrics icon">
</p>

<h1 align="center">Delyrics - Lyrics Deduplicator</h1>

<p align="center">
  <a href="https://github.com/chanwoo7/delyrics/releases/latest"><img src="https://img.shields.io/github/v/release/chanwoo7/delyrics" alt="Release"></a>
  <a href="https://github.com/chanwoo7/delyrics/releases"><img src="https://img.shields.io/github/downloads/chanwoo7/delyrics/total" alt="Downloads"></a>
  <img src="https://img.shields.io/badge/platform-macOS%20|%20Windows%20|%20Linux-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Flutter-Desktop-02569B?logo=flutter" alt="Flutter">
</p>

<p align="center">English | <a href="README.ko.md">한국어</a></p>

<p align="center">A simple desktop app that removes duplicate lines from lyrics.</p>

<p align="center">Paste multi-line lyrics, and the app scans each line top to bottom —<br>removing lines that have already appeared while keeping the first occurrence.</p>

## Why Delyrics?

Song lyrics from music platforms often repeat the same lines — choruses, hooks, and refrains appear multiple times throughout the text. When you need **only the unique lines** (e.g., for presentation slides, subtitle files, or lyric booklets), manually finding and removing duplicates is tedious and error-prone.

Delyrics was built to solve this in one click: paste the full lyrics, hit Convert, and get a clean copy with every duplicate line removed — while preserving the original order and formatting.

**Common use cases:**
- Preparing worship song slides (PPT/Keynote) from raw lyrics
- Creating lyric booklets or printed setlists
- Cleaning up subtitle or karaoke files
- Extracting unique lines for translation or analysis

## Install

### macOS

1. Download `Delyrics.dmg` from the [latest release](https://github.com/chanwoo7/delyrics/releases/latest).
2. Open the DMG and drag `Delyrics.app` to the **Applications** folder.
3. On first launch, macOS may show an "unidentified developer" warning. To open:
   - Right-click the app → **Open** → click **Open** in the dialog, or
   - Go to **System Settings > Privacy & Security** and click **Open Anyway**.

### Windows

1. Download `Delyrics-windows.zip` from the [latest release](https://github.com/chanwoo7/delyrics/releases/latest).
2. Extract the zip and run `delyrics.exe`.

### Linux

1. Download the Linux build from the [latest release](https://github.com/chanwoo7/delyrics/releases/latest).
2. Extract and run the `delyrics` executable.

## Run

```bash
# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

## Build

```bash
# macOS
flutter build macos

# Windows
flutter build windows

# Linux
flutter build linux
```

The built app is located at:
- macOS: `build/macos/Build/Products/Release/`
- Windows: `build/windows/x64/runner/Release/`
- Linux: `build/linux/x64/release/bundle/`

## Usage

1. Paste lyrics into the input area.
2. Click the **Convert** button or press `⌘/Ctrl + Enter`.
3. The deduplicated result appears in the output area.
4. Click **Copy Result** to copy to clipboard.
5. Click **Reset** to clear both input and output.

## Shortcuts

| Shortcut | Action |
|----------|--------|
| `⌘/Ctrl + Enter` | Run deduplication |
| `Enter` | Line break (does not trigger conversion) |

## Deduplication Rule

Two lines are considered duplicates if they produce the **same string after removing all whitespace characters** (spaces, tabs, leading/trailing whitespace).

Example: the following two lines are treated as duplicates.
```
Every moment of yours I wish it were me
Every momentof yours I wishit were me
```

The output preserves the original form of the first occurrence (only trimming leading/trailing whitespace).

## Features

- Line-by-line deduplication with whitespace-normalized comparison
- Dark / Light / System theme modes
- English / Korean / System language support
- `⌘/Ctrl + Enter` shortcut for quick conversion
- One-click copy to clipboard
- Drag & drop or open `.txt` / `.lrc` files
- Duplicate line highlighting in input

## Tech Stack

- Flutter (Desktop) / Dart
- macOS, Windows, Linux

## Test

```bash
flutter test
```
