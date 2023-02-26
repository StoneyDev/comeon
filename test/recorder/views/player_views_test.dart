import 'package:comeon/recorder/views/player_views.dart';
import 'package:comeon/view_model/record_view_model.dart';
import 'package:comeon/view_model/timer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('[WT] Operation of the control buttons', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<TimerViewModel>(create: (_) => TimerViewModel()),
            ChangeNotifierProvider<RecordViewModel>(create: (_) => RecordViewModel()),
          ],
          child: const PlayerViews(),
        ),
      ),
    );

    final recordButton = find.byKey(const Key('startRecording'));
    final stopButton = find.byKey(const Key('stopRecording'));

    // Init
    expect(recordButton, findsOneWidget);
    expect(tester.widget<ElevatedButton>(stopButton).enabled, isFalse);

    // TODO: Test recording button
    // Starting recording
    // await tester.tap(recordButton);
    // await tester.pumpAndSettle();

    // expect(tester.widget<ElevatedButton>(recordButton).child, const Icon(Icons.pause_rounded));
    // expect(tester.widget<ElevatedButton>(stopButton).enabled, isTrue);
  });
}
