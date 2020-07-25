import 'package:flutter/material.dart';
import 'package:flutterCalc/components/calc_button.dart';

void main() {
  runApp(CalcApp());
}

class CalcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'FlutterCalc'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Container(
                  color: Colors.red,
                  child: Container(
                      padding: EdgeInsets.only(bottom: 20, right: 20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Placeholder',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      )),
                ),
                flex: 6),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CalcButton('7'),
                    CalcButton('8'),
                    CalcButton('9'),
                    CalcButton('x'),
                  ],
                ),
                flex: 2),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CalcButton('4'),
                    CalcButton('5'),
                    CalcButton('6'),
                    CalcButton('-'),
                  ],
                ),
                flex: 2),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CalcButton('1'),
                    CalcButton('2'),
                    CalcButton('3'),
                    CalcButton('+'),
                  ],
                ),
                flex: 2),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CalcButton('-'),
                    CalcButton('0'),
                    CalcButton('-'),
                    CalcButton('='),
                  ],
                ),
                flex: 2)
          ],
        ),
      ),
    );
  }
}
