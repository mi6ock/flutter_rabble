import 'package:flutter/material.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  var firework;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: GestureDetector(
            onTapDown: (detail) {
              setState(() {
                firework = Positioned(
                  top: detail.localPosition.dy,
                  left: detail.localPosition.dx,
                  child: PimpedButton(
                    particle: DemoParticle(),
                    pimpedWidgetBuilder:
                        (context, controller) {
                      controller.forward(from: 0.0);
                    },
                  ),
                );
              });
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(-0.5, -0.6),
                      radius: 0.15,
                      colors: <Color>[
                        const Color(0xFFEEEEEE),
                        const Color(0xFF111133),
                      ],
                      stops: <double>[0.9, 1.0],
                    ),
                  ),
                ),
                if (firework != null) firework
              ],
            ),
          ),
        ),
      ),
    );
  }
}
