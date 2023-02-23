import 'package:comeon/home_page.dart';
import 'package:flutter/material.dart';

class ComeOnApp extends StatelessWidget {
  const ComeOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
