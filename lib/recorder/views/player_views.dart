import 'package:comeon/view_model/record_view_model.dart';
import 'package:comeon/view_model/timer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerViews extends StatelessWidget {
  const PlayerViews({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch
    final playerWatch = context.watch<RecordViewModel>();

    // Read
    final playerRead = context.read<RecordViewModel>();
    final timerRead = context.read<TimerViewModel>();

    return Row(
      children: [
        // Start or pause the recording
        Expanded(
          child: ElevatedButton(
            key: const Key('startRecording'),
            onPressed: () async {
              if (playerWatch.isRecording) {
                timerRead.pauseTimer();
                playerRead.pauseRecording();
              } else {
                await playerRead.startRecording();
                timerRead.startTimer();
              }
            },
            child: Icon(playerWatch.isRecording ? Icons.pause_rounded : Icons.play_arrow_rounded),
          ),
        ),

        const SizedBox(width: 20),

        // Stop and save recording
        Expanded(
          child: ElevatedButton(
            key: const Key('stopRecording'),
            onPressed: playerWatch.isRecording || playerWatch.isPausing
                ? () {
                    timerRead.resetTimer();
                    playerRead.stopRecording();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("L'enregistrement a bien été enregistré"),
                      ),
                    );

                    // Refresh
                    Navigator.pop(context, true);
                  }
                : null,
            child: const Icon(Icons.stop_rounded),
          ),
        ),
      ],
    );
  }
}
