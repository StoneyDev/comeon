import 'package:comeon/view_model/timer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerViews extends StatelessWidget {
  const TimerViews({super.key});

  @override
  Widget build(BuildContext context) {
    final timerWatch = context.watch<TimerViewModel>();

    return Text(
      '${timerWatch.hours}:${timerWatch.minutes}:${timerWatch.seconds}',
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}
