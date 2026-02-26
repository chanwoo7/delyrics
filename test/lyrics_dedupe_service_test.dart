import 'package:flutter_test/flutter_test.dart';
import 'package:delyrics/features/delyrics/domain/services/lyrics_dedupe_service.dart';

void main() {
  late LyricsDedupeService service;

  setUp(() {
    service = LyricsDedupeService();
  });

  group('LyricsDedupeService', () {
    test('완전 동일한 줄 중복 제거', () {
      const input = '가나다\n라마바\n가나다';
      final result = service.deduplicate(input);

      expect(result.outputText, '가나다\n라마바');
      expect(result.inputLineCount, 3);
      expect(result.outputLineCount, 2);
      expect(result.removedDuplicateCount, 1);
    });

    test('공백만 다른 줄 중복 제거', () {
      const input = '오직 내 삶에 오직 내 맘에 그가 주인 되셨네\n오직 내삶에 오직 내 맘에 그가 주인되셨네';
      final result = service.deduplicate(input);

      expect(result.outputText, '오직 내 삶에 오직 내 맘에 그가 주인 되셨네');
      expect(result.outputLineCount, 1);
      expect(result.removedDuplicateCount, 1);
    });

    test('앞뒤 공백이 있는 경우 정상 처리', () {
      const input = '  가나다  \n가나다';
      final result = service.deduplicate(input);

      expect(result.outputText, '가나다');
      expect(result.outputLineCount, 1);
      expect(result.removedDuplicateCount, 1);
    });

    test('빈 줄 제거', () {
      const input = '가나다\n\n\n라마바';
      final result = service.deduplicate(input);

      expect(result.outputText, '가나다\n라마바');
      expect(result.inputLineCount, 2);
      expect(result.outputLineCount, 2);
      expect(result.removedDuplicateCount, 0);
    });

    test('순서 보존 확인', () {
      const input = '다\n나\n가\n나\n다';
      final result = service.deduplicate(input);

      expect(result.outputText, '다\n나\n가');
      expect(result.outputLineCount, 3);
    });

    test('입력이 비어 있을 때 빈 결과 반환', () {
      final result = service.deduplicate('');

      expect(result.outputText, '');
      expect(result.inputLineCount, 0);
      expect(result.outputLineCount, 0);
      expect(result.removedDuplicateCount, 0);
    });

    test('공백만 있는 입력', () {
      final result = service.deduplicate('   \n  \n\t\n  ');

      expect(result.outputText, '');
      expect(result.inputLineCount, 0);
      expect(result.outputLineCount, 0);
    });

    test('첫 등장 원문의 앞뒤 공백만 제거한 형태를 유지', () {
      const input = '  오직 내 삶에  \n오직내삶에';
      final result = service.deduplicate(input);

      // 첫 등장 원문의 trim된 형태 (내부 공백은 유지)
      expect(result.outputText, '오직 내 삶에');
    });

    test('techspec 예시 입출력', () {
      const input = '''주 안에서 내 영혼 다시 태어나
이전 것은 지나고 새롭게 됐네
죄로 물든 내 모습 예수와 함께 죽고
부활 생명 내 안에 새로운 삶이 열렸네
너희가 나를 택한 것이 아니요
내가 너희를 택하여 세웠나니
오직 내 안에 오직 내 속에 그리스도가 사네
오직 내 삶에 오직 내 맘에 그가 주인 되셨네
죄로 물든 내 모습 예수와 함께 죽고
부활 생명 내 안에 새로운 삶이 열렸네
너희가 나를 택한 것이 아니요
내가 너희를 택하여 세웠나니
오직 내 안에 오직 내 속에 그리스도가 사네
오직 내삶에 오직 내 맘에 그가 주인되셨네
내 생명 그 안에 그의 생명 내 안에
나의 삶이 이전과 같을 수 없네
내 생명 그 안에 그의 생명 내 안에
나의 삶이 이전과 같을 수 없네
오직 내 안에 오직 내 속에 그리스도가 사네
오직 내 삶에 오직 내 맘에 그가 주인 되셨네''';

      const expectedOutput = '''주 안에서 내 영혼 다시 태어나
이전 것은 지나고 새롭게 됐네
죄로 물든 내 모습 예수와 함께 죽고
부활 생명 내 안에 새로운 삶이 열렸네
너희가 나를 택한 것이 아니요
내가 너희를 택하여 세웠나니
오직 내 안에 오직 내 속에 그리스도가 사네
오직 내 삶에 오직 내 맘에 그가 주인 되셨네
내 생명 그 안에 그의 생명 내 안에
나의 삶이 이전과 같을 수 없네''';

      final result = service.deduplicate(input);

      expect(result.outputText, expectedOutput);
      expect(result.inputLineCount, 20);
      expect(result.outputLineCount, 10);
      expect(result.removedDuplicateCount, 10);
    });

    test('탭 문자가 포함된 경우 중복 처리', () {
      const input = '가\t나\t다\n가 나 다';
      final result = service.deduplicate(input);

      expect(result.outputLineCount, 1);
      expect(result.removedDuplicateCount, 1);
    });
  });
}
