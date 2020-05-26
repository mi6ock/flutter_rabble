import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 30.0,
            height: 140.0,
            child: Container(
              child: AutoSizeText(
                'This string will be automatically resized to fit in two lines.',
                minFontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
