import 'package:comeon/home_page.dart';
import 'package:comeon/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('[WT] HomePage', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
          child: const HomePage(),
        ),
      ),
    );

    final micButton = find.byKey(const Key('mic'));
    final emptyRecordingText = find.text('Aucun enregistrement');

    expect(micButton, findsOneWidget);
    expect(emptyRecordingText, findsOneWidget);
  });
}
