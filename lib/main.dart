import 'package:flutter/material.dart';
import 'package:flutterCalc/components/button_row.dart';
import 'package:flutterCalc/components/calc_screen.dart';

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
  String _operacoes = 'Cx+-=/';
  String _operacaoSelecionada = '';

  double _primeiroNumero = 0;
  double _total = 0;

  String _resultadoParcial = '';
  String _resultadoFinal = '0';

  /// Callback passada para os botões que retorna o botão pressionado
  /// no atributo [nome]
  void pressionarBotao(String nome) {
    if (!_operacoes.contains(nome)) {
      _total != 0
          ? _atualizarTotal(double.parse(_tratarZeros(_total) + nome))
          : _atualizarTotal(double.parse(nome));
    } else {
      if (nome == 'C') {
        _atualizarTotal();
        setState(() {
          _resultadoParcial = "";
          _operacaoSelecionada = "";
        });
      } else {
        if (nome == '=') {
          _atualizarTotal(_calcularResultadoOperacao(
              _primeiroNumero, _total, _operacaoSelecionada));
          setState(() {
            _resultadoParcial = '';
            _operacaoSelecionada = '';
          });
        } else {
          _primeiroNumero = _total;
          _operacaoSelecionada = nome;
          _atualizarTotal();
          setState(() {
            _resultadoParcial =
                _tratarZeros(_primeiroNumero) + _operacaoSelecionada;
          });
        }
      }
    }
  }

  /// Realiza o cálculo da [operacao] passada tomando [num1] como primeiro
  /// termo e [num2] como segundo termo
  double _calcularResultadoOperacao(double num1, double num2, String operacao) {
    if (operacao == '+') {
      return num1 + num2;
    } else if (operacao == '-') {
      return num1 - num2;
    } else if (operacao == 'x') {
      return num1 * num2;
    } else {
      return num1 / num2;
    }
  }

  String _tratarZeros(double n) {
    String valorStr = n.toStringAsFixed(6);
    String antesPonto = valorStr.split('.')[0];
    String depoisPonto = valorStr.split('.')[1];
    if (depoisPonto.replaceAll('0', '').length == 0) {
      return antesPonto;
    } else {
      return valorStr;
    }
  }

  void _atualizarTotal([double n = 0]) {
    setState(() {
      _total = n;
      _resultadoFinal = _tratarZeros(n);
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
            CalcScreen(_resultadoParcial, _resultadoFinal),
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
