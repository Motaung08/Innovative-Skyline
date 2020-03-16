import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Login.dart';
import 'package:postgrad_tracker/auth.dart';
import 'package:postgrad_tracker/wrapper.dart';
import 'package:provider/provider.dart';
import 'user.dart';
//import 'package:firebase/firebase.dart' as fb;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        //value: AuthService().user,
        child: MaterialApp(
          title: 'Postgraduate Tracker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: LoginPage(),
          home: LoginPage(),
        )
    );
  }
}

