import 'dart:async';
import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yolohealth/MyCheckBox.dart';
import 'GlobalState.dart';
import 'DateTimePicker.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  final List<String> _allKiosk = <String>[
    'Kiosk 100',
    'Kiosk 101',
    'Kiosk 102',
    'Kiosk 103'
  ];
  String _currentKiosk = 'Aditya';

  String _getFromDate = '';
  String _getToDate = '';

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _message;

  @override
  void initState() {
    print("BBBBBBBBBBBBBBBBBBBBBBBBB ");
    _dropDownMenuItems = getDropDownMenuItems();
    _currentKiosk = _dropDownMenuItems[0].value;
    print(
        "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC " + _dropDownMenuItems[0].value);
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> itemsList = List();
    for (String kiosk in _allKiosk) {
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA " + kiosk);
      GlobalState.instance.set(kiosk, false);
      itemsList.add(
        DropdownMenuItem<String>(
          value: kiosk,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                kiosk,
              ),
              SizedBox(width: 10),
              MyCheckBox(
                kiosk,
              )
            ],
          ),
        ),
      );
    }
    return itemsList;
  }

  void changedDropDownItem(String selectedKiosk) {
    print("Selected Kiosk $selectedKiosk");
    int count = 0;
    setState(() {
      count = GlobalState.instance.counter();
      _message = 'Kiosk : ' + count.toString();
      print(_message);
    });
//    setState(() {
//      _currentKiosk = selectedKiosk;
//    });
  }

  @override
  Widget build(BuildContext context) {
    final goButton = new RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.black,
      color: Colors.blue,
      onPressed: null,
      child: Text("GO"),
    );

    final fromDate = new _DateTimePicker(
      labelText: 'From',
      selectedDate: _fromDate,
      selectDate: (DateTime date) {
        setState(() {
          _fromDate = date;
          _getFromDate = date.toString();
          print('From Date : ' + _getFromDate);
        });
      },
    );

    final toDate = new _DateTimePicker(
      labelText: 'To',
      selectedDate: _toDate,
      selectDate: (DateTime date) {
        setState(() {
          _toDate = date;
          _getToDate = date.toString();
          print('To Date : ' + _getToDate);
        });
      },
    );

    final space = const SizedBox(height: 58.0);

    final kioskList = new InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Select Kiosk',
        hintText: 'Choose a Kiosk',
        contentPadding: EdgeInsets.zero,
      ),
      isEmpty: _currentKiosk == null,
      child: DropdownButton<String>(
          value: _currentKiosk,
          onChanged: changedDropDownItem,
          items: getDropDownMenuItems()),
    );

    final _body = new DropdownButtonHideUnderline(
      child: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[fromDate, toDate, space, kioskList, goButton],
        ),
      ),
    );

    return Scaffold(
      body: _body,
    );
  }
}
