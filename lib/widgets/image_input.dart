//This widget enables the user to take pictures of the crime
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;                                   //currently a file on the device but update to post online


  Future<void> _takePicture() async{
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,                    // if we want to use existing file, choose ImageSource.gallery
      maxWidth: 600,
    );    
    if (imageFile == null){
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });      
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');     
    widget.onSelectImage(savedImage);

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
           height: 100,
           decoration: BoxDecoration(border: Border.all(
             width:1,
             color: Colors.blueGrey,
            )
           ),
          child: _storedImage != null ? Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
           ) : Text(
             'No Image Taken',
              textAlign: TextAlign.center,
              ), 
          alignment: Alignment.center,
          ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Colors.blue,
            //textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          )
        ),
      ],
      
    );
  }
}