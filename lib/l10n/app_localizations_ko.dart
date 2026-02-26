// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Delyrics';

  @override
  String get copiedToClipboard => '결과가 클립보드에 복사되었습니다';

  @override
  String get themeSystem => '시스템 설정';

  @override
  String get themeLight => '라이트 모드';

  @override
  String get themeDark => '다크 모드';

  @override
  String get convert => '변환';

  @override
  String get copyResult => '결과 복사';

  @override
  String get reset => '초기화';

  @override
  String get statusInput => '입력';

  @override
  String get statusOutput => '출력';

  @override
  String get statusDeduplicated => '중복 제거';

  @override
  String linesCount(int count) {
    return '$count줄';
  }

  @override
  String get originalLyrics => '원본 가사';

  @override
  String get inputPlaceholder => '여기에 가사를 붙여넣으세요...';

  @override
  String get deduplicatedResult => '중복 제거 결과';

  @override
  String get outputPlaceholder => '변환 결과가 여기에 표시됩니다';

  @override
  String get localeSystem => '시스템 언어';

  @override
  String get localeEnglish => 'English';

  @override
  String get localeKorean => '한국어';
}
