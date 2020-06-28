import 'package:crimap_flutter/services/auth.dart';
import 'package:flutter/material.dart';

import '../map_screen.dart';
import '../auth_form_screen.dart';
import '../../services/location_input.dart';

class SignIn extends StatefulWidget {
 
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
  ){}
 final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,     
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: Text('Crime Map4'),
        actions: <Widget>[
              FlatButton.icon(
               icon:Icon(Icons.location_searching
               ),
               color: Theme.of(context).primaryColor,
               label: Text('Sign-InB4'),
               textColor: Colors.black,              //signin on appbar
               onPressed:() {
                 print('sign inB4');
                   Navigator.of(context).pushNamed(
                     AuthFormScreen.routeName
                  
                );
              }
            )
        // ]
           //  FlatButton.icon
          //    onPressed: ()async{
          //      dynamic result = await _auth.signInAnon();
        // actions: <Widget>[
        //       FlatButton.icon(
        //        icon:Icon(Icons.more_vert),
        //        label: Text('Sign-In'),              //signin on appbar
        //       onPressed:()async{
        //         dynamic result = await _auth.signInAnon();
           //     if (result == null){
           //       print('Error Signing In');
           //     } else {
           //       print('Signed In');
             //     print(result.uid);
             //   }
         
   
          //);
          //     }
          //    )
        ],
        ),
        body: MapScreen() 
               
    );
  }
}