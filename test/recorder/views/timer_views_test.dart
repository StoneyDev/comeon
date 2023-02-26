import 'package:comeon/recorder/views/timer_views.dart';
import 'package:comeon/view_model/timer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('TimerViews displays a timer', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => TimerViewModel(),
          child: const TimerViews(),
        ),
      ),
    );

    expect(find.byKey(const Key('timer')), findsOneWidget);
  });
}
