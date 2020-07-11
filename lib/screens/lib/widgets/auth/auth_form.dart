import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail ='';
  String _userName ='';
  String _userPassword  ='';
  

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(isValid){ 
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address'
                    ),
                    validator: (value){
                      if(value.isEmpty || !value.contains('@')){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(
                      labelText: 'Username'),
                    validator: (value){
                      if(value.isEmpty || value.length < 4){
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                       onSaved: (value){
                      _userName = value;
                    },                    
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: 'Password'),
                    obscureText: true,  
                    validator: (value){
                      if (value.isEmpty || value.length <7)
                      {
                        return 'Password must be more than 6 characters long' ;
                      }
                      return null;  
                    },
                       onSaved: (value){
                      _userPassword = value;
                    },                    
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading)
                      CircularProgressIndicator(),
                  if (!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin? 'login': 'Signup'),
                    onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin? 'Create new account': 'Already have an account'),
                      onPressed:(){
                        setState(() {
                        _isLogin =!_isLogin;                          
                        });
                      }   
                    )
                ],
              ),
            ),
            ),
          ),
        ), 
     );
  }
}