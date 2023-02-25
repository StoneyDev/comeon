import 'package:comeon/recorder/recorder_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
        child: const Icon(Icons.mic_rounded),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RecorderPage(),
          ),
        ),
      ),
    );
  }
}
