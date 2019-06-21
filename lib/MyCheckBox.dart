import 'package:flutter/material.dart';

import 'GlobalState.dart';

class MyCheckBox extends StatefulWidget {
  String kiosk;
  MyCheckBox(this.kiosk);
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: GlobalState.instance.get(widget.kiosk),
      onChanged: (bool value) {
        setState(() {
          GlobalState.instance.set(widget.kiosk, value);
        });
      },
    );
  }
}
