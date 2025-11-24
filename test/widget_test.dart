// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/app/app.dart';
import 'package:todo/ui/pages/todos_view.dart';

void main() {
  // Setup before each test
  setUp(() {});

  // Teardown after each test
  tearDown(() {
    GetIt.I.reset();
  });

  test('TodoApp.configureDependencies() runs without throwing', () {
    expect(() => TodoApp.configureDependencies(), returnsNormally);
  });

  testWidgets('TodoApp widget builds', (WidgetTester tester) async {
    await _runApp(tester);
    expect(find.byType(TodoApp), findsOneWidget);
  });

  testWidgets('Login - empty login and password', (WidgetTester tester) async {
    await _runApp(tester);
    final Finder loginField = find.bySemanticsLabel('Login');
    expect(loginField, findsOneWidget);
    final Finder passwordField = find.bySemanticsLabel('Password');
    expect(passwordField, findsOneWidget);

    final buttonFinder = find.text('Log In');
    expect(buttonFinder, findsOneWidget);
    await tester.tap(buttonFinder);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Please inform your login'), findsOneWidget);
    expect(find.text('Please inform your password'), findsOneWidget);
  });

  testWidgets('Login - empty password', (WidgetTester tester) async {
    await _runApp(tester);
    final Finder loginField = find.bySemanticsLabel('Login');
    expect(loginField, findsOneWidget);
    final Finder passwordField = find.bySemanticsLabel('Password');
    expect(passwordField, findsOneWidget);

    await tester.enterText(loginField, 'user');
    await tester.pump();
    expect(find.text('user'), findsOneWidget);

    final buttonFinder = find.text('Log In');
    expect(buttonFinder, findsOneWidget);
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Please inform your login'), findsNothing);
    expect(find.text('Please inform your password'), findsOneWidget);
  });

  testWidgets('Login - valid information', (WidgetTester tester) async {
    await _runApp(tester);
    expect(find.byType(TodosView), findsNothing);

    final Finder loginField = find.bySemanticsLabel('Login');
    expect(loginField, findsOneWidget);
    final Finder passwordField = find.bySemanticsLabel('Password');
    expect(passwordField, findsOneWidget);
    final buttonFinder = find.text('Log In');
    expect(buttonFinder, findsOneWidget);

    await tester.enterText(loginField, 'user');
    await tester.pump();
    expect(find.text('user'), findsOneWidget);

    await tester.enterText(passwordField, 'secret');
    await tester.pump();
    expect(find.text('secret'), findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Please inform your login'), findsNothing);
    expect(find.text('Please inform your password'), findsNothing);
    expect(find.byType(TodosView), findsOneWidget);
  });
}

//dont repeat yourself!
Future<void> _runApp(WidgetTester tester) async {
  TodoApp.configureDependencies();
  await tester.pumpWidget(TickerMode(enabled: false, child: const TodoApp()));
  await tester.pumpAndSettle();
}
