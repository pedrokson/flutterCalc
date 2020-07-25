import 'package:flutter/material.dart';
import 'package:flutterCalc/components/button_row.dart';

void main() {
  runApp(CalcApp());
}

class CalcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calc',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat'),
      home: HomePage(title: 'Flutter Calculator'),
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
  int _primeiroNumero = 0;
  String _operacoes = "Cx+-=/";
  String _operacaoSelecionada = "";

  String _resultadoParcial = "";
  int _total = 0;

  /// Callback passada para os botões que retorna o botão pressionado
  /// no atributo [nome]
  void pressionarBotao(String nome) {
    if (!_operacoes.contains(nome)) {
      setState(() {
        if (_total != 0) {
          /// Se já houver número digitado, concatena o novo número a ele
          _total = int.parse(_total.toString() + nome);
        } else {
          _total = int.parse(nome);
        }
      });
    } else {
      if (nome == 'C') {
        setState(() {
          _total = 0;
          _resultadoParcial = "";
          _operacaoSelecionada = "";
        });
      } else {
        if (nome == '=') {
          setState(() {
            _total = _calcularResultadoOperacao(
                _primeiroNumero, _total, _operacaoSelecionada);
            _resultadoParcial = "";
            _operacaoSelecionada = "";
          });
        } else {
          _primeiroNumero = _total;
          _operacaoSelecionada = nome;
          setState(() {
            _resultadoParcial =
                _primeiroNumero.toString() + _operacaoSelecionada;
          });
        }
      }
    }
  }

  /// Realiza o cálculo da [operacao] passada tomando [num1] como primeiro
  /// termo e [num2] como segundo termo
  int _calcularResultadoOperacao(int num1, int num2, String operacao) {
    if (operacao == '+') {
      return num1 + num2;
    } else if (operacao == '-') {
      return num1 - num2;
    } else if (operacao == 'x') {
      return num1 * num2;
    } else {
      return num1 ~/ num2;
    }
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
                  color: Colors.white30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(bottom: 20, right: 20),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            _resultadoParcial,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          )),
                      Container(
                          padding: EdgeInsets.only(bottom: 20, right: 20),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            _total.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50),
                          ))
                    ],
                  ),
                ),
                flex: 6),
            Divider(color: Colors.black),
            ButtonRow(['7', '8', '9', '/'], this.pressionarBotao),
            ButtonRow(['4', '5', '6', 'x'], this.pressionarBotao),
            ButtonRow(['1', '2', '3', '-'], this.pressionarBotao),
            ButtonRow(['C', '0', '=', '+'], this.pressionarBotao),
          ],
        ),
      ),
    );
  }
}
