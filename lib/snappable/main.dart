import 'package:flutter/material.dart';
import 'package:snappable/snappable.dart';

void main() async {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final key1 = GlobalKey<SnappableState>();
  final key2 = GlobalKey<SnappableState>();
  final key3 = GlobalKey<SnappableState>();

  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Snappable(
              key: key1,
              child: Center(
                child: Text(
                  "萩",
                ),
              ),
            ),
            Snappable(
              key: key2,
              offset: Offset(-40, 30),
              child: Center(
                child: Text(
                  "野",
                ),
              ),
            ),
            Text(
              "千",
            ),
            Snappable(
              key: key3,
              offset: Offset(40, 30),
              child: Center(
                child: Text(
                  "尋",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          key1.currentState.snap();
          value = 2;
          key2.currentState.snap();
          key3.currentState.snap();
        },
        tooltip: 'change',
        child: Icon(Icons.delete),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
