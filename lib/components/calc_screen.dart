import 'package:flutter/material.dart';

class CalcScreen extends StatelessWidget {
  final String _resultadoParcial;
  final int _total;

  CalcScreen(this._resultadoParcial, this._total);

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
                    _total.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ))
            ],
          ),
        ),
        flex: 6);
  }
}
