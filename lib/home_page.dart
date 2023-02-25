import 'package:comeon/models/recording.dart';
import 'package:comeon/recorder/recorder_page.dart';
import 'package:comeon/view_model/audio_view_model.dart';
import 'package:comeon/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel()..getRecordings(),
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // Displays recordings from the storage
                  if (value.recordings.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.recordings.length,
                        itemBuilder: (context, index) => AudioCard(
                          index: index,
                          recording: value.recordings[index],
                        ),
                      ),
                    )
                  else
                    const Text('Aucun enregistrement')
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ElevatedButton(
            child: const Icon(Icons.mic_rounded),
            onPressed: () async {
              final bool? recordingCreated = await Navigator.push(
                context,
                MaterialPageRoute<bool>(
                  builder: (context) => const RecorderPage(),
                ),
              );

              if (recordingCreated != null) {
                // Refresh list
                value.getRecordings();
              }
            },
          ),
        ),
      ),
    );
  }
}

class AudioCard extends StatelessWidget {
  final Recording recording;
  final int index;

  const AudioCard({
    required this.recording,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeRead = context.read<HomeViewModel>();

    return ChangeNotifierProvider<AudioViewModel>(
      create: (_) => AudioViewModel()..init(recording.urlPath),
      child: Consumer<AudioViewModel>(builder: (context, value, child) {
        if (value.state == AudioState.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Icon
                IconButton(
                  onPressed: value.state == AudioState.paused ? value.play : value.pause,
                  icon: Icon(
                    value.state == AudioState.playing
                        ? Icons.pause_circle_outline_rounded
                        : Icons.play_circle_outline_rounded,
                  ),
                ),

                const SizedBox(width: 20),

                // Metadata
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text('Enregistrement $index'),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Text('${recording.duration?.inSeconds}s'),

                        // Progress bar
                        Slider(
                          max: recording.duration?.inSeconds.toDouble() ?? 1,
                          value: value.position.toDouble(),
                          onChanged: (_) {},
                        )
                      ],
                    ),
                  ],
                ),

                IconButton(
                  onPressed: value.state == AudioState.playing
                      ? null
                      : () {
                          // Delete this recording
                          value.deleteRecording(recording.urlPath.path);

                          // Refresh list
                          homeRead.getRecordings();
                        },
                  icon: Icon(
                    Icons.delete,
                    color: value.state == AudioState.playing ? null : Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
