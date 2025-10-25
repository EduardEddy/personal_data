import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_data/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('should show loading indicator initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should have correct app bar title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.pump();

      expect(find.text('Datos Personales'), findsOneWidget);
    });

    testWidgets('should show create profile button when no user exists', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Crear Perfil'), findsOneWidget);
    });

    testWidgets('should display welcome message when no user is loaded', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('¡Bienvenido!'), findsOneWidget);
      expect(find.text('Comienza creando tu perfil personal'), findsOneWidget);
    });
  });
}
