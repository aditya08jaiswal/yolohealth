import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:async' show Future;

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed,
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
//            Icon(
//              Icons.arrow_drop_down,
//              color: Theme.of(context).brightness == Brightness.light
//                  ? Colors.grey.shade700
//                  : Colors.white70,
//            ),
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectDate,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme
        .of(context)
        .textTheme
        .title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: _InputDropdown(
            labelText: labelText,
            valueText: DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
      ],
    );
  }
}

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

  bool _isChecked = false;

  int count = 0;

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
    List<DropdownMenuItem<String>> itemsList = new List();
    for (String kiosk in _allKiosk) {
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA " + kiosk);
//      itemsList.map((kiosk) => CheckboxListTile(
//        title: Text(kiosk.toString()),
//        value: _isChecked,
//        onChanged: (val) {
//          setState(() {
//            _isChecked = val;
//          });
//        },
//      ));


      itemsList = _allKiosk.map<DropdownMenuItem<String>>((String kiosk) {
        return DropdownMenuItem<String>(
          key: GlobalKey(),
          value: kiosk,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                kiosk,
              ),
              SizedBox(width: 10),
              Checkbox(
                value: _isChecked,
                onChanged: (bool value) {
                  setState(() {
                    _isChecked = value;
                  });
                },
              ),
            ],
          ),
        );
      }).toList();


      /*itemsList.add(new DropdownMenuItem(
        value: kiosk,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              kiosk,
            ),
            SizedBox(width: 10),
//            Checkbox(
//              value: _isChecked,
//              onChanged: (bool value) {
//                setState(() {
//                  _isChecked = value;
//                });
//              },
//            ),
          ],
        ),
      ));
*/
    }
    return itemsList;
  }

  void changedDropDownItem(String selectedKiosk) {
    print("Selected Kiosk $selectedKiosk");
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
          items: getDropDownMenuItems()
      ),
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
