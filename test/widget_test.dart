// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tulip/main.dart';
import 'package:tulip/widget/email_field.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('shows error when email is empty', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EmailField()));
    expect(find.text('Please enter an email address'), findsNothing);

    await tester.enterText(find.byType(TextFormField), '');
    await tester.pump();

    expect(find.text('Please enter an email address'), findsOneWidget);
  });

  testWidgets('shows error when email is invalid', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EmailField()));
    expect(find.text('Invalid email address'), findsNothing);

    await tester.enterText(find.byType(TextFormField), 'invalid@email');
    await tester.pump();

    expect(find.text('Invalid email address'), findsOneWidget);
  });

  testWidgets('does not show error when email is valid', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EmailField()));
    expect(find.text('Invalid email address'), findsNothing);

    await tester.enterText(find.byType(TextFormField), 'valid@example.com');
    await tester.pump();

    expect(find.text('Invalid email address'), findsNothing);
  });

  testWidgets('does not show error when email is valid', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EmailField()));
    await tester.pump(); // 触发第一次渲染
    expect(find.text('Invalid email address'), findsNothing);
    await tester.enterText(find.byType(TextFormField), 'valid@example.com');
    await tester.pump();

    expect(find.text('Invalid email address'), findsNothing);
  });
}





