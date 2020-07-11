import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FlatButton.icon(
            label: Text(
                DateFormat('dd-MMMM-yyyy' "   " 'H:mm').format(DateTime.now())),
            onPressed: () {},
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.calendar_today))
      ],
    );
  }
}
