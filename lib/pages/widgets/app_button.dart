import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class AppButton extends StatelessWidget {
  var login;
  Function funcao;
  bool _showProg = false;
  AppButton(this.login, this.funcao, this._showProg);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
          color: colorButton,
          child: _showProg == false
              ? Text(
                  login,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
          onPressed: () => funcao),
    );
  }
}
