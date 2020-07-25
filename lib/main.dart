import 'package:flutter/material.dart';
import 'package:flutterCalc/components/button_row.dart';

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
  int _total = 0;

  /// Callback passada para os botões que retorna o botão pressionado
  /// no atributo [nome].
  void pressionarBotao(String nome) {
    print(nome);
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
                        _total.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      )),
                ),
                flex: 6),
            ButtonRow(['7', '8', '9', 'x'], this.pressionarBotao),
            ButtonRow(['4', '5', '6', '-'], this.pressionarBotao),
            ButtonRow(['1', '2', '3', '+'], this.pressionarBotao),
            ButtonRow(['C', '0', '.', '='], this.pressionarBotao),
          ],
        ),
      ),
    );
  }
}
