
import 'package:flutter/material.dart';

class SelectCrimeDropD extends StatefulWidget {
  SelectCrimeDropD(String crimeType);

  @override
  _SelectCrimeDropDState createState() => _SelectCrimeDropDState();
}

class _SelectCrimeDropDState extends State<SelectCrimeDropD> {

    String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
       return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  
  }
}

