import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  bool isChecked = false;
  MyCheckBox({this.isChecked});
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  void _onChanged(bool value) {
    setState(() => widget.isChecked = value);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isChecked,
      onChanged: _onChanged,
    );
  }
}
