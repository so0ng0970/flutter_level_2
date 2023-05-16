import 'package:flutter/material.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}
