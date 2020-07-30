import 'package:flutter/material.dart';
import 'package:flutterCalc/components/button_row.dart';
import 'package:flutterCalc/components/calc_screen.dart';

/// Classe que representa a calculadora e seu funcionamento
class Calc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  List<String> _operacoes = ['C', '<-', '%', '/', 'x', '+', '-', '='];
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
      switch (nome) {
        case 'C':
          _limparDados();
          break;
        case '=':
          _calcularOperacao();
          break;
        case '<-':
          _removerDigito();
          break;
        case '%':
          _atualizarTotal(_total / 100);
          break;
        case '.':

          /// TODO: Implementar tratamento de pontos
          break;
        default:
          _adicionarDigito(nome);
          break;
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

  /// Adiciona o digito correspondente a [nome] na operação e no visor
  void _adicionarDigito(String nome) {
    _primeiroNumero = _total;
    _operacaoSelecionada = nome;
    _atualizarTotal();
    setState(() {
      _resultadoParcial =
          _removerZerosADireita(_primeiroNumero) + _operacaoSelecionada;
    });
  }

  /// Remove o último digito inserido no visor
  void _removerDigito() {
    String totalStr = _removerZerosADireita(_total);
    try {
      _atualizarTotal(double.parse(totalStr.substring(0, totalStr.length - 1)));
    } on FormatException {
      _atualizarTotal(0);
    }
  }

  /// Calcula o resultado da operação e exibe na tela
  void _calcularOperacao() {
    _atualizarTotal(_calcularResultadoOperacao(
        _primeiroNumero, _total, _operacaoSelecionada));
    setState(() {
      _resultadoParcial = '';
      _operacaoSelecionada = '';
    });
  }

  /// Limpa todos os dados de operação e reseta o visor
  void _limparDados() {
    setState(() {
      _total = 0;
      _resultadoFinal = "0";
      _resultadoParcial = "";
      _operacaoSelecionada = "";
    });
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CalcScreen(_resultadoParcial, _resultadoFinal),
          Divider(color: Colors.black),
          ButtonRow(['C', '<-', '%', '/'], this.pressionarBotao),
          ButtonRow(['7', '8', '9', 'x'], this.pressionarBotao),
          ButtonRow(['4', '5', '6', '-'], this.pressionarBotao),
          ButtonRow(['1', '2', '3', '+'], this.pressionarBotao),
          ButtonRow(['', '0', '.', '='], this.pressionarBotao),
        ],
      ),
    );
  }
}
