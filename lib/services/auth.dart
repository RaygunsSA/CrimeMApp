import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //createb user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user !=null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(error){
      print(error.toString());
      return null;
    }
  }

  //sign in with emil & pw
Future signInWithEmailAndPassword(email, password) async {
    try{
      print('switched to Auth SIWP&E');
      AuthResult result = await _auth.signInWithEmailAndPassword( email: email, password: password );
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(error){
      print('switched to Auth SIWP&E');
      print(error.toString());
      return null;
    }
  }

  //register with email & PW
Future createUserWithEmailAndPassword(email, password) async {
    try{
      print('switched to Auth CP&E_successful');
      AuthResult result = await _auth.createUserWithEmailAndPassword( email: email, password: password );
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(error){
      print('switched to Auth CP&E_error');
      print(error.toString());
      return null;
    }
  }
  //Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(error){
      print(error.toString());
      return null;
    }
  }
}