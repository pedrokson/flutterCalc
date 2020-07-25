import 'package:flutter/material.dart';

/// Classe que representa um botão da calculadora
class CalcButton extends StatelessWidget {
  /// nome do botão escrito na tecla
  final String _nome;

  /// callback acionada ao se apertar no botão
  final Function(String) _pressionarBotaoCallback;

  CalcButton(this._nome, this._pressionarBotaoCallback);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FlatButton(
          color: Colors.blue,
          onPressed: () => {_pressionarBotaoCallback(_nome)},
          child: Center(
              child: Text(
            _nome,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          )),
        ),
        flex: 1);
  }
}
