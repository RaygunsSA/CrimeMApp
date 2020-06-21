import 'package:crimap_flutter/services/auth.dart';
import 'package:flutter/material.dart';

import '../map_screen.dart';
import '../../services/location_input.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],     
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Crime Map'),
        actions: <Widget>[
              FlatButton.icon(
               icon:Icon(Icons.more_vert),
               label: Text('Sign-In'),              //signin on appbar
               onPressed:()async{
                 dynamic result = await _auth.signInAnon();
                if (result == null){
                  print('Error Signing In');
                } else {
                  print('Signed In');
                  print(result.uid);
                }
               }
              ),
        ],
        ),
        body: Container(
            child: MapScreen(),
          )
           
    );
  }
}