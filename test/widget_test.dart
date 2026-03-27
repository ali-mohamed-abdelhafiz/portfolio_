import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:portfolio/main.dart';
import 'package:portfolio/theme/theme_provider.dart';

void main() {
  testWidgets('Portfolio app renders basic shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PortfolioApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
