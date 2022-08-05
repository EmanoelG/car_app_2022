import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextInput extends StatefulWidget {
  var label;
  var hint;
  bool obscure;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType type;
  TextInputAction textInputAction;
  FocusNode focus;
  FocusNode nextFocus;

  AppTextInput(this.label, this.hint,
      {this.obscure = false,
      this.controller,
      this.validator,
      this.type,
      this.focus,
      this.nextFocus,
      this.textInputAction});

  @override
  _AppTextInputState createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardAppearance: Brightness.dark,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.type,
      focusNode: widget.focus,
      onFieldSubmitted: (String text) {
        if (widget.nextFocus != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        }
        ;
      },
      textInputAction: widget.textInputAction,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.red,
        ),
      ),
      obscureText: widget.obscure,
    );
    ;
  }
}
