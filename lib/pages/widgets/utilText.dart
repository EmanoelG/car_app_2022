//import 'dart:ffi';

import 'package:flutter/material.dart';

class TextUtil extends StatefulWidget {
  String text;
  double sizeLetra = 18.0;
  TextUtil(this.text, {this.sizeLetra}) : super();

  @override
  State<TextUtil> createState() => _TextUtilState();
}

class _TextUtilState extends State<TextUtil> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.sizeLetra ??= 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
