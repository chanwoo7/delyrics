import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'features/delyrics/presentation/pages/home_page.dart';

class ThemeModeNotifier extends InheritedWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggle;

  const ThemeModeNotifier({
    super.key,
    required this.themeMode,
    required this.onToggle,
    required super.child,
  });

  static ThemeModeNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeModeNotifier>()!;
  }

  @override
  bool updateShouldNotify(ThemeModeNotifier oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}

class LocaleNotifier extends InheritedWidget {
  final Locale? locale; // null = system default
  final VoidCallback onToggle;

  const LocaleNotifier({
    super.key,
    required this.locale,
    required this.onToggle,
    required super.child,
  });

  static LocaleNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleNotifier>()!;
  }

  @override
  bool updateShouldNotify(LocaleNotifier oldWidget) {
    return locale != oldWidget.locale;
  }
}

class DelyricsApp extends StatefulWidget {
  const DelyricsApp({super.key});

  @override
  State<DelyricsApp> createState() => _DelyricsAppState();
}

class _DelyricsAppState extends State<DelyricsApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale; // null = follow system

  void _toggleThemeMode() {
    setState(() {
      switch (_themeMode) {
        case ThemeMode.system:
          _themeMode = ThemeMode.light;
        case ThemeMode.light:
          _themeMode = ThemeMode.dark;
        case ThemeMode.dark:
          _themeMode = ThemeMode.system;
      }
    });
  }

  void _toggleLocale() {
    setState(() {
      if (_locale == null) {
        _locale = const Locale('en');
      } else if (_locale!.languageCode == 'en') {
        _locale = const Locale('ko');
      } else {
        _locale = null; // back to system
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeModeNotifier(
      themeMode: _themeMode,
      onToggle: _toggleThemeMode,
      child: LocaleNotifier(
        locale: _locale,
        onToggle: _toggleLocale,
        child: MaterialApp(
          title: 'Delyrics',
          debugShowCheckedModeBanner: false,
          locale: _locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          localeResolutionCallback: (systemLocale, supportedLocales) {
            if (systemLocale != null &&
                systemLocale.languageCode == 'ko') {
              return const Locale('ko');
            }
            return const Locale('en');
          },
          themeMode: _themeMode,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          home: const HomePage(),
        ),
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF3B7DD8),
        onPrimary: Colors.white,
        secondary: Color(0xFF5B9BD5),
        onSecondary: Colors.white,
        surface: Color(0xFFEEF2F7),
        onSurface: Color(0xFF1E2A3A),
        outline: Color(0xFFCDD5DF),
      ),
      fontFamily: '.AppleSystemUIFont',
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E2A3A),
          letterSpacing: -0.3,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1E2A3A),
          height: 1.6,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF7A8A9E),
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF141A24),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF5B9BD5),
        onPrimary: Colors.white,
        secondary: Color(0xFF7AB3E0),
        onSecondary: Colors.white,
        surface: Color(0xFF1C2533),
        onSurface: Color(0xFFDDE4EE),
        outline: Color(0xFF2E3A4C),
      ),
      fontFamily: '.AppleSystemUIFont',
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFFDDE4EE),
          letterSpacing: -0.3,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFFDDE4EE),
          height: 1.6,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF7A8A9E),
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
