import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/core/theme/theme_cubit.dart';
import 'package:portfolio/core/di/injection.dart' as di;

void main() {
  setUpAll(() {
    di.init();
  });

  testWidgets('Portfolio app renders basic shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => di.sl<ThemeCubit>(),
        child: const PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PortfolioApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
