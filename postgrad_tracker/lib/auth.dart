import 'package:firebase_auth/firebase_auth.dart';
import 'package:postgrad_tracker/User.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  User _fromFromFirebaseUser(FirebaseUser user){
    return user != null ? User(UID: user.uid) : null;
  }

  //sign up with email and password


  //sign in with email and password


  //sign out
}