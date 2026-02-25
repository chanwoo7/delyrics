import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lyrics_deduper/app.dart';

void main() {
  testWidgets('앱이 정상적으로 렌더링된다', (WidgetTester tester) async {
    await tester.pumpWidget(const LyricsDeduperApp());

    expect(find.text('가사 중복 제거기'), findsOneWidget);
    expect(find.text('변환'), findsOneWidget);
    expect(find.text('결과 복사'), findsOneWidget);
    expect(find.text('초기화'), findsOneWidget);
  });

  testWidgets('변환 버튼 클릭 시 결과가 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const LyricsDeduperApp());

    final inputField = find.byType(TextField);
    await tester.enterText(inputField, '첫 번째 줄\n두 번째 줄\n첫 번째 줄');
    await tester.tap(find.text('변환'));
    await tester.pump();

    expect(find.textContaining('첫 번째 줄'), findsWidgets);
    expect(find.textContaining('두 번째 줄'), findsWidgets);
  });

  testWidgets('초기화 버튼 클릭 시 입력/출력이 비워진다', (WidgetTester tester) async {
    await tester.pumpWidget(const LyricsDeduperApp());

    final inputField = find.byType(TextField);
    await tester.enterText(inputField, '테스트 가사');
    await tester.tap(find.text('변환'));
    await tester.pump();

    await tester.tap(find.text('초기화'));
    await tester.pump();

    final textField = tester.widget<TextField>(inputField);
    expect(textField.controller!.text, isEmpty);
  });
}
