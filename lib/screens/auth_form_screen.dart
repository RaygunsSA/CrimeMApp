import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth.dart';
class AuthFormScreen extends StatefulWidget {
  // AuthFormScreen(this.submitFn);

  // final void Function(
  //   String email,
  //   String password,
  //   String userName,
  //   bool isLogin,
  //   ) submitFn;  

  static const routeName = '/auth-form';
  @override
  _AuthFormScreenState createState() => _AuthFormScreenState();
}

class _AuthFormScreenState extends State<AuthFormScreen> {
  //final AuthService _auth = AuthService();
  final _auth =FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  var isLogin =true;
  String _userEmail ='';
  String _userName ='';
  String _userPassword ='';
  BuildContext ctx;

    void _submitAuthForm(
  )async{
        AuthResult authResult;

   //try{
      setState((){
        isLoading =true;
      });
      if (isLogin){
        print('is Login Selected');
         authResult= await _auth.signInWithEmailAndPassword(
            email:_userEmail,
           password:_userPassword,

            );
              print('the userEmail is $_userEmail');
              print('the UserPassword is $_userPassword');
      } else{
        print ('is Login ! selected');
        authResult= await _auth.createUserWithEmailAndPassword(
           email:_userEmail,
          password:_userPassword,
          );
                print('the userEmail is $_userEmail');
              print('the UserPassword is $_userPassword');
         await  Firestore.instance
          .collection('user')
          .document(authResult.user.uid)
          .setData({
             'username': _userName,
             'email': _userEmail,
        });
      }  

   }

  void _trySubmit(){
    print('try Submit tagged');
    final isValid =_formKey.currentState.validate();

    if (isValid){
      _formKey.currentState.save();
      // widget.submitFn(
      //   _userEmail,
      //   _userPassword,
      //   _userName,
      //   isLogin
      // );
    }
    print('server Connected');
    FocusScope.of(context).unfocus();
    _submitAuthForm(

    );
    
  }
   


  //  on PlatformException catch (err){
  //    print('Try failed2');
  //    var message = 'An error occured, Please check your Credentials';

  //    if (err.message != null){
  //     message = err.message;
  //  }
    // Scaffold.of(ctx).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //     backgroundColor: Theme.of(ctx).errorColor,
    //     );
    //   );
  //  }catch (err){
  //    print('Datch error printing');
  //    print (err);
  //  }
    
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body:Center(
        child: Card(
          margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding( 
                padding:EdgeInsets.all(16),
                child: Form(
                  key:_formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        key: ValueKey('email'),
                        validator: (value){
                          if (value.isEmpty || !value.contains('@')){
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email addressA6',
                        ),
                        onSaved: (value){
                          _userEmail = value;
                        },
                      ),
                      if (!isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          validator: (value){
                            if (value.isEmpty || value.length <4){
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                            onSaved: (value){
                            _userName = value;

                          },                    
                        ),
                      TextFormField(
                        key: ValueKey('password'),
                        validator: (value){
                          if (value. isEmpty || value.length < 7){
                            return 'Password must be 7 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText:'Password'),
                          obscureText: true, 
                          onSaved: (value){
                          _userPassword = value;
                        },      
                      ),
                      SizedBox(height:12),
                     if (isLoading) CircularProgressIndicator(),
                    if (!isLoading) RaisedButton(
                        child: Text(isLogin ?'Login': 'Signup'),
                        onPressed:_trySubmit,
                      ),
                    if (!isLoading)  FlatButton(
                        child: Text(isLogin ?'Create new account': 'Sign in with Existing account'),
                        onPressed: (){
                          setState(() {
                             isLogin =!isLogin;
                          });
                          print('switch between create and Login');
                        },
                      )
                  ],),
                ),
                ),
            ),
        )
      )
     );  
  }
}