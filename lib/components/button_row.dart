import 'package:flutter/material.dart';
import 'package:flutterCalc/components/calc_button.dart';

/// Classe que representa uma fileira de botões
class ButtonRow extends StatelessWidget {
  /// Lista de botões na fileira
  final List<String> _listaNomeBotoes;

  /// Callback passada para os botões que captura evento de pressionar o botão
  final Function(String) pressionarBotaoCallback;

  ButtonRow(this._listaNomeBotoes, this.pressionarBotaoCallback);

  List<Widget> _gerarBotoes() {
    List<Widget> botoes = new List();
    _listaNomeBotoes.forEach((nome) {
      if (nome == 'switch') {
        botoes.add(CalcButton(nome, pressionarBotaoCallback, true));
      } else {
        botoes.add(CalcButton(nome, pressionarBotaoCallback));
      }
    });
    return botoes;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _gerarBotoes(),
        ),
        flex: 2);
  }
}
