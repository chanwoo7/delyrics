// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Delyrics';

  @override
  String get copiedToClipboard => 'Result copied to clipboard';

  @override
  String get themeSystem => 'System theme';

  @override
  String get themeLight => 'Light mode';

  @override
  String get themeDark => 'Dark mode';

  @override
  String get convert => 'Convert';

  @override
  String get copyResult => 'Copy Result';

  @override
  String get reset => 'Reset';

  @override
  String get statusInput => 'Input';

  @override
  String get statusOutput => 'Output';

  @override
  String get statusDeduplicated => 'Deduplicated';

  @override
  String linesCount(int count) {
    return '$count lines';
  }

  @override
  String get originalLyrics => 'Original Lyrics';

  @override
  String get inputPlaceholder => 'Paste lyrics here...';

  @override
  String get deduplicatedResult => 'Deduplicated Result';

  @override
  String get outputPlaceholder => 'Converted result will appear here';

  @override
  String get localeSystem => 'System language';

  @override
  String get localeEnglish => 'English';

  @override
  String get localeKorean => 'Korean';

  @override
  String get openFile => 'Open file';

  @override
  String get unsupportedFileType => 'Only .txt and .lrc files are supported';
}
