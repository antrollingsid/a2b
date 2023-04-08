import 'package:a2b/screens/welcomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'a2b',
      debugShowCheckedModeBanner: false,
      //  theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //  ),
      home: WelcomePage(),
    );
  }
}
