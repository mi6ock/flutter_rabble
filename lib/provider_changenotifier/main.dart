import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      /// ChangeNotifierProviderはbuilderにChangeNotifier型強制します
      home: ChangeNotifierProvider(
        create: (_) => CounterModel(0),
        child: MyHomePage(),
      ),
    );
  }
}

class CounterModel extends ChangeNotifier {
  int counter;

  CounterModel(this.counter);

  int get value => this.counter;

  /// インクリメントし、画面の再描画をnotifyListeners()で行う
  increment() {
    counter++;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider + ChangenNotifier"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DescriptionText(),
            CounterText(),
            const SizedBox(
              height: 32,
            ),
            const IncrementButton()
          ],
        ),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('You have pushed the button this many times:');
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// 上位のWidgetで定義したCounterModelを取得
    final counter = Provider.of<CounterModel>(context);
    return Text(
      '${counter.value}',
      style: Theme.of(context).textTheme.display1,
    );
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// listen: falseにしているのは値更新時に
    /// 再描画を防ぐため。このオプションはv4.0.0で要らなった
    /// らしいが再描画されるのでセットしている
    final counter = Provider.of<CounterModel>(context, listen: false);
    return RaisedButton(
      onPressed: () => counter.increment(),
      child: Icon(Icons.add),
    );
  }
}
