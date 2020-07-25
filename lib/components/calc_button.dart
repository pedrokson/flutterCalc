import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String _nome;

  CalcButton(this._nome);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          color: Colors.black38,
          child: Center(
              child: Text(
            _nome,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          )),
        ),
        flex: 1);
  }
}
