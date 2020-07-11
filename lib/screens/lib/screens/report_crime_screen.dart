// this is the same as "report a new crime" but for legal implications, not calling it report
//here the user can disclose all information regarding a particular crime
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:path_provider/path_provider.dart';

import '../models/crime_description.dart';
import '../providers/user_reported_crimes.dart';
import '../widgets/location_input.dart';
import '../widgets/date_input.dart';
//import '../widgets/select_crime_dropd.dart';
//import '../widgets/image_input.dart';

class ReportCrimeScreen extends StatefulWidget {
  static const routeName = '/report-crime';
  final List<CrimeDescription> crimeDescription = [
    CrimeDescription(
        id: '',
        crimeType: '',
        //location: CrimeLocation(latitude: ,longitude: )
        dateOfCrime: DateTime.now())
  ];

  @override
  _ReportCrimeScreenState createState() => _ReportCrimeScreenState();
}

class _ReportCrimeScreenState extends State<ReportCrimeScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  CrimeDescription _pickedLocation;

  // void _selectImage(File pickedImage){
  //   _pickedImage = pickedImage;
  // }

  // void _selectPlace(double lat, double lng){
  //   _pickedLocation = CrimeDescription(lo);
  // }

  void _savePlace() {
    //determines if reported crime form is submitable
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      print('Error, title controller is empty');
      return;
    }
    // Provider.of<CrimeDescription>(context, listen: false)
    //     .addPlace(_titleController.text,_pickedImage, _pickedLocation);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report a crime'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    //currently using Textfield but look into using TextformFiek

                    TextField(
                      decoration: InputDecoration(labelText: 'Description'),
                      controller: _titleController,
                    ),
                    // to change o a dropdown menu
                    LocationInput(),
                    SizedBox(
                      height: 10,
                    ),

                    DateInput(),
                    //     SizedBox(height:10,),
                  ],
                ),
              ),
            ),
          ),
          //Text('Report a crime'),
          RaisedButton.icon(
            icon: Icon(Icons.touch_app),
            label: Text('Post Report'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
