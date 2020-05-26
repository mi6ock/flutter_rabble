import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple QR Scan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: ChildWidget(),
    );
  }
}

class ChildWidget extends StatelessWidget {
  OverlayState overlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            _insertOverlay(context);
          },
          child: Text("overlay!"),
        )
      ],
    );
  }

  void _insertOverlay(BuildContext context) {
    overlay = Overlay.of(context);
    return overlay.insert(
      OverlayEntry(builder: (context) {
        return SizedBox.expand(
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => overlay.re,
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
        );
      }),
    );
  }
}
