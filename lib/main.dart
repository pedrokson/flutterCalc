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
          ? _atualizarTotal(double.parse(_removerZerosADireita(_total) + nome))
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
                _removerZerosADireita(_primeiroNumero) + _operacaoSelecionada;
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

  /// Remove zeros à direita de um determinado valor [n]
  /// (ex.: 1.50000 retorna 1.5, 2.581000 retorna 2.581)
  String _removerZerosADireita(double n) {
    String valorStr = n.toStringAsFixed(7);
    int i = valorStr.length - 1;
    while (valorStr[i] == '0') {
      i--;
    }
    if (valorStr[i] == '.') {
      i--;
    }
    return valorStr.substring(0, i + 1);
  }

  /// Atualiza valores de total e resultado final para
  /// um determinado valor [n]
  void _atualizarTotal([double n = 0]) {
    setState(() {
      _total = n;
      _resultadoFinal = _removerZerosADireita(n);
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
