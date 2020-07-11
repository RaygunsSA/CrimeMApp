import 'package:crime_map_three/models/crime_description.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  DateTime _userPickedDate;
  TimeOfDay _userPickedTime;

  Future<void> _userSelectedDate() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null || pickedDate == DateTime.now()) {
        return;
      }
      _userSelectedTime();
      setState(() {
        _userPickedDate = pickedDate;
      });
  
      print(_userPickedDate);
      print(_userPickedTime);
    });
  }

  Future<void> _userSelectedTime() async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _userPickedTime = pickedTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FlatButton.icon(
            onPressed: _userSelectedDate,
            label: Text(_userPickedDate == null
                ? DateFormat('dd-MMMM-yyyy' "   " 'H:mm').format(DateTime.now())
                : DateFormat('dd-MMMM-yyyy').format(_userPickedDate),
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.calendar_today))
      ],
    );
  }
}
