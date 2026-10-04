import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/core/animation/app_animations.dart';
import 'package:venture/core/theme/app_colors.dart';
import 'package:venture/core/theme/app_theme.dart';
import 'package:venture/shared/widgets/glass_card.dart';
import 'package:venture/shared/widgets/responsive_layout.dart';

void main() {
  group('Design System & UI Primitives', () {
    testWidgets('AppTheme configures dark mode correctly', (tester) async {
      final theme = AppTheme.darkTheme;
      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, AppColors.background);
    });

    testWidgets('GlassCard renders child and responds to tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: GlassCard(
              onTap: () => tapped = true,
              child: const Text('Glass Card Test'),
            ),
          ),
        ),
      );

      expect(find.text('Glass Card Test'), findsOneWidget);
      await tester.tap(find.text('Glass Card Test'));
      expect(tapped, isTrue);
    });

    testWidgets('AnimatedNumberTicker formats and displays number', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedNumberTicker(
              value: 1000.0,
              formatter: (v) => '\$${v.toInt()}',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('\$1000'), findsOneWidget);
    });

    testWidgets('ResponsiveLayout adapts across mobile, tablet, desktop viewports', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(400, 800)),
            child: ResponsiveLayout(
              mobile: Text('Mobile View'),
              tablet: Text('Tablet View'),
              desktop: Text('Desktop View'),
            ),
          ),
        ),
      );
      expect(find.text('Mobile View'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(800, 800)),
            child: ResponsiveLayout(
              mobile: Text('Mobile View'),
              tablet: Text('Tablet View'),
              desktop: Text('Desktop View'),
            ),
          ),
        ),
      );
      expect(find.text('Tablet View'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 800)),
            child: ResponsiveLayout(
              mobile: Text('Mobile View'),
              tablet: Text('Tablet View'),
              desktop: Text('Desktop View'),
            ),
          ),
        ),
      );
      expect(find.text('Desktop View'), findsOneWidget);
    });
  });
}
