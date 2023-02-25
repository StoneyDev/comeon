import 'package:comeon/recorder/views/player_views.dart';
import 'package:comeon/recorder/views/timer_views.dart';
import 'package:comeon/view_model/record_view_model.dart';
import 'package:comeon/view_model/timer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecorderPage extends StatelessWidget {
  const RecorderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerViewModel>(create: (_) => TimerViewModel()),
        ChangeNotifierProvider<RecordViewModel>(create: (_) => RecordViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [
              // Displays the recording time
              TimerViews(),

              SizedBox(height: 20),

              // Control recording
              PlayerViews(),
            ],
          ),
        ),
      ),
    );
  }
}
