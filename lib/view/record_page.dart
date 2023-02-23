import 'package:comeon/view_model/record__view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecordViewModel(),
      child: Consumer<RecordViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: [
              // Message state recording
              if (value.isRecording) const Text("L'enregistrement a commencé"),
              if (value.isPausing) const Text("L'enregistrement est en pause"),
              if (!value.isRecording && !value.isPausing) const Text("L'enregistrement a été enregistré ici"),

              // Start or pause the recording
              ElevatedButton(
                onPressed: value.isRecording ? value.pauseRecording : value.startRecording,
                child: Icon(value.isRecording ? Icons.pause_rounded : Icons.play_arrow_rounded),
              ),

              // Stop and save recording
              ElevatedButton(
                onPressed: value.stopRecording,
                child: const Icon(Icons.stop_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
