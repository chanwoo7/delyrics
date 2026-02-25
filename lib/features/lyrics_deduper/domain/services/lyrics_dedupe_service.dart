import '../models/dedupe_result.dart';

class LyricsDedupeService {
  /// 입력 텍스트에서 줄 단위 중복을 제거한다.
  ///
  /// 비교 기준: 줄 내부의 모든 공백 문자를 제거한 문자열.
  /// 출력: 첫 등장한 줄의 앞뒤 공백만 제거한 원문.
  DedupeResult deduplicate(String input) {
    if (input.trim().isEmpty) {
      return const DedupeResult.empty();
    }

    final lines = input.split('\n');
    final seen = <String>{};
    final resultLines = <String>[];
    int totalNonEmptyLines = 0;

    for (final line in lines) {
      final trimmed = line.trim();

      // 빈 줄은 무시
      if (trimmed.isEmpty) continue;

      totalNonEmptyLines++;

      // 비교용 키: 모든 공백 문자 제거
      final key = _normalizeForComparison(trimmed);

      if (!seen.contains(key)) {
        seen.add(key);
        resultLines.add(trimmed);
      }
    }

    return DedupeResult(
      outputText: resultLines.join('\n'),
      inputLineCount: totalNonEmptyLines,
      outputLineCount: resultLines.length,
      removedDuplicateCount: totalNonEmptyLines - resultLines.length,
    );
  }

  /// 비교를 위해 모든 공백 문자를 제거한 문자열을 반환한다.
  String _normalizeForComparison(String line) {
    return line.replaceAll(RegExp(r'\s+'), '');
  }
}
