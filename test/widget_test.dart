import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:delyrics/app.dart';

void main() {
  testWidgets('앱이 정상적으로 렌더링된다', (WidgetTester tester) async {
    await tester.pumpWidget(const DelyricsApp());
    await tester.pumpAndSettle();

    expect(find.text('Delyrics'), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);
    expect(find.text('Copy Result'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);
  });

  testWidgets('변환 버튼 클릭 시 결과가 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const DelyricsApp());
    await tester.pumpAndSettle();

    final inputField = find.byType(TextField);
    await tester.enterText(inputField, 'first line\nsecond line\nfirst line');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    expect(find.textContaining('first line'), findsWidgets);
    expect(find.textContaining('second line'), findsWidgets);
  });

  testWidgets('초기화 버튼 클릭 시 입력/출력이 비워진다', (WidgetTester tester) async {
    await tester.pumpWidget(const DelyricsApp());
    await tester.pumpAndSettle();

    final inputField = find.byType(TextField);
    await tester.enterText(inputField, 'test lyrics');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    await tester.tap(find.text('Reset'));
    await tester.pump();

    final textField = tester.widget<TextField>(inputField);
    expect(textField.controller!.text, isEmpty);
  });
}
