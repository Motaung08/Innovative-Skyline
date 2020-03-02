import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Home.dart';
import 'package:postgrad_tracker/Login.dart';
import 'package:postgrad_tracker/authenticate.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    //return either home or authenticate widget
    return LoginPage();
}
}