import 'package:flutter/material.dart';
import 'package:flutter_content_placeholder/flutter_content_placeholder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContentPlaceholder.block(
        width: 100,
        height: 100,
        rightSpacing: 10,
        context: context,
      ),
    );
  }
}
