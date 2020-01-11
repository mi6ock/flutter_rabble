import 'package:flutter/material.dart';

import 'background_image_task-9.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blumax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Dancing', primarySwatch: myColour),
      home: BackgroundImage(),
    );
  }
}

const MaterialColor myColour = const MaterialColor(
  0xFF0009FF,
  const <int, Color>{
    50: const Color(0xFF0009FF),
    100: const Color(0xFF0009FF),
    200: const Color(0xFF0009FF),
    300: const Color(0xFF0009FF),
    400: const Color(0xFF0009FF),
    500: const Color(0xFF0009FF),
    600: const Color(0xFF0009FF),
    700: const Color(0xFF0009FF),
    800: const Color(0xFF0009FF),
    900: const Color(0xFF0009FF),
  },
);
