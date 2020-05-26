import 'package:flutter/material.dart';
import 'package:samples_rabble/slider_button/swipe_button.dart';

void main() async {
  return runApp(MaterialApp(
      home: SwipeButtonDemo(
    buttonTitle: "リファクタリング",
  )));
}

class SwipeButtonDemo extends StatelessWidget {
  final String pageRoute;
  final String buttonTitle;

  SwipeButtonDemo({Key key, this.pageRoute, this.buttonTitle})
      : super(key: key);

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SwipeButton(
                  thumb: Center(
                    child: Text(
                      "TODO",
                      style: TextStyle().copyWith(color: Colors.white),
                    ),
                  ),
                  content: Center(
                    child: Text(
                      buttonTitle,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  initialPosition: SwipePosition.SwipeLeft,
                  onChanged: (result) {
                    if (result == SwipePosition.SwipeRight) {
                      _scaffold.currentState.showSnackBar(SnackBar(
                        content: Text("TODO : リファクタリングを完了"),
                      ));
                    } else {}
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
