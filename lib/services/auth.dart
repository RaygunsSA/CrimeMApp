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

  //register with email & PW

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