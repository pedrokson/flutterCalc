import 'package:flutter/material.dart';

/// Classe que representa as duas telas que permitem a visualização dos resultados
/// das operações
class CalcScreen extends StatelessWidget {
  final String _resultadoParcial;
  final String _resultadoFinal;

  CalcScreen(this._resultadoParcial, this._resultadoFinal);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  )),
              Container(
                  padding: EdgeInsets.only(bottom: 20, right: 20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _resultadoFinal,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ))
            ],
          ),
        ),
        flex: 6);
  }
}
