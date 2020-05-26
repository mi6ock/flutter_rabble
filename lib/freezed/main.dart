import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:samples_rabble/freezed/hoge_state.dart';
import 'package:samples_rabble/freezed/my_state_notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<Logger>(create: (_) => ConsoleLogger()),
        StateNotifierProvider<MyStateNotifier, HogeState>(
          create: (_) => MyStateNotifier(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool rotate = true;
  AnimationController _animationController;
  Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    animation = Tween<double>(begin: 0, end: 2).animate(_animationController);

    _animationController.addListener(() {
      print(animation.value);
      setState(() {});
    });

    print(HogeState.fromJson(json.decode(_debug_data)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              context.select((HogeState value) => value.count).toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              child: Text("decrement"),
              onPressed: context.watch<MyStateNotifier>().increment,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (rotate) {
            _animationController.forward(from: 0);
            rotate = false;
          } else {
            _animationController.reverse(from: 1);
            rotate = true;
          }
        },
        tooltip: 'Increment',
        child: Transform.rotate(
          angle: animation.value,
          child: Icon(
            Icons.add,
            size: 32,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
