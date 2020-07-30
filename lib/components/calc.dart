import 'package:flutter/material.dart';
import 'package:flutterCalc/components/calc_button_row.dart';
import 'package:flutterCalc/components/calc_screen.dart';

import 'package:flutterCalc/constants.dart' as Constants;

/// Classe que representa a calculadora e seu funcionamento
class Calc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  /// Operação pressionada
  String _operacaoSelecionada = '';

  /// Primeiro valor informado
  double _primeiroNumero = 0;

  /// Valor atual na tela
  double _total = 0;

  /// Visualização do primeiro valor informado e operação selecionada
  String _resultadoParcial = '';

  /// Visualização do valor total
  String _resultadoFinal = '0';

  bool _modoCientifico = false;

  /// Callback passada para os botões que retorna o botão pressionado
  /// no atributo [nome]
  void pressionarBotao(String nome) {
    if (Constants.NUMEROS.contains(nome)) {
      if (_total != 0) {
        if (_resultadoFinal.endsWith('.')) {
          _atualizarTotal(
              double.parse(_removerZerosADireita(_total, true) + nome));
        } else {
          _atualizarTotal(double.parse(_removerZerosADireita(_total) + nome));
        }
      } else {
        _atualizarTotal(double.parse(nome));
      }
    } else if (Constants.OPERACOES.contains(nome)) {
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
          _adicionarPonto();
          break;
        case 'π':

          /// TODO: Implementar geração de pi
          break;
        case 'e':

          /// TODO: Implementar e
          break;
        case '1/x':

          /// TODO: Implementar operação de inversão
          break;
        case '√x':

          /// TODO: Implementar raiz quadrada
          break;
        case 'x!':

          /// TODO: Implementar fatorial
          break;
        default:
          _adicionarDigito(nome);
          break;
      }
    } else {
      switch (nome) {
        case 'switch':
          setState(() {
            _modoCientifico = !_modoCientifico;
          });
          break;
        default:
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
  String _removerZerosADireita(double n, [bool manterPonto = false]) {
    String valorStr = n.toStringAsFixed(7);
    int i = valorStr.length - 1;
    while (valorStr[i] == '0') {
      i--;
    }
    if (valorStr[i] == '.' && !manterPonto) {
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

  /// Adiciona um ponto caso o número no visor não possua um
  void _adicionarPonto() {
    _atualizarTotal(_total, true);
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
  void _atualizarTotal([double n = 0, bool manterPonto = false]) {
    setState(() {
      _total = n;
      _resultadoFinal = _removerZerosADireita(n, manterPonto);
    });
  }

  List<Widget> _gerarBotoes() {
    List<Widget> botoes = List();
    botoes.addAll([
      CalcScreen(_resultadoParcial, _resultadoFinal),
      Divider(color: Colors.black)
    ]);
    if (_modoCientifico) {
      botoes.addAll([
        CalcButtonRow(['x!', 'C', '<-', '%', '/'], this.pressionarBotao),
        CalcButtonRow(['√x', '7', '8', '9', 'x'], this.pressionarBotao),
        CalcButtonRow(['1/x', '4', '5', '6', '-'], this.pressionarBotao),
        CalcButtonRow(['π', '1', '2', '3', '+'], this.pressionarBotao),
        CalcButtonRow(['switch', 'e', '0', '.', '='], this.pressionarBotao)
      ]);
    } else {
      botoes.addAll([
        CalcButtonRow(['C', '<-', '%', '/'], this.pressionarBotao),
        CalcButtonRow(['7', '8', '9', 'x'], this.pressionarBotao),
        CalcButtonRow(['4', '5', '6', '-'], this.pressionarBotao),
        CalcButtonRow(['1', '2', '3', '+'], this.pressionarBotao),
        CalcButtonRow(['switch', '0', '.', '='], this.pressionarBotao)
      ]);
    }
    return botoes;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _gerarBotoes(),
      ),
    );
  }
}
