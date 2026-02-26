<p align="center">
  <img src="img/app-icon.png" width="128" alt="Delyrics icon">
</p>

<h1 align="center">Delyrics - Lyrics Deduplicator</h1>

<p align="center">
  <a href="https://github.com/chanwoo7/delyrics/releases/latest"><img src="https://img.shields.io/github/v/release/chanwoo7/delyrics" alt="Release"></a>
  <a href="https://github.com/chanwoo7/delyrics/releases"><img src="https://img.shields.io/github/downloads/chanwoo7/delyrics/total" alt="Downloads"></a>
  <img src="https://img.shields.io/badge/platform-macOS-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Flutter-Desktop-02569B?logo=flutter" alt="Flutter">
</p>

<p align="center">English | <a href="README.ko.md">한국어</a></p>

<p align="center">A simple macOS desktop app that removes duplicate lines from lyrics.</p>

<p align="center">Paste multi-line lyrics, and the app scans each line top to bottom —<br>removing lines that have already appeared while keeping the first occurrence.</p>

## Run

```bash
flutter run -d macos
```

## Build for macOS

```bash
flutter build macos
```

The built app is located at `build/macos/Build/Products/Release/`.

## Usage

1. Paste lyrics into the input area.
2. Click the **Convert** button or press `⌘ + Enter`.
3. The deduplicated result appears in the output area below.
4. Click **Copy Result** to copy to clipboard.
5. Click **Reset** to clear both input and output.

## Shortcuts

| Shortcut | Action |
|----------|--------|
| `⌘ + Enter` | Run deduplication |
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
- `⌘ + Enter` shortcut for quick conversion
- One-click copy to clipboard

## Tech Stack

- Flutter (Desktop) / Dart
- macOS only

## Test

```bash
flutter test
```
