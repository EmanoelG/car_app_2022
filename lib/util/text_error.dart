import 'package:flutter/material.dart';

class TextError extends StatefulWidget {
  String _msg;
  TextError(
    this._msg,
  ) : super();

  @override
  State<TextError> createState() => _TextErrorState();
}

class _TextErrorState extends State<TextError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget._msg,
        style: TextStyle(
            fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}
