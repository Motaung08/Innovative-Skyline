import 'dart:ui';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:postgrad_tracker/SupervisorRegister.dart';
import 'StudentRegister.dart';

class ViewProfilePage extends StatefulWidget {
  ViewProfilePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    final Name="test";

    final studentProfile = Container(
      //elevation: 5.0,
      //borderRadius: BorderRadius.circular(30.0),


      child: Column(

          children: <Widget>[
//                StreamBuilder(
//                  stream: Firestore.instance.collection('Student').snapshots(),
//                  builder: (context, snapshot){
//                    if (!snapshot.hasData) return const Text('Loading...');
//                    return Text("Name"+snapshot.data.documents[index]);
//                  },
//                ),
                Text("Profile:  \n",
                    //textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 24)
                ),


              Text(
                  "Name: "+Name+"\n",
                  //textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              ),
              Text(
                  "Student Number: "+"\n",
                  //textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              ),
        Text(
                  "Email:"+"\n",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              ),
              Text(
                  "Degree:"+"\n",
                  textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              ),
              Text(
                  "Date Registered:"+"\n",
                  textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              )
        ]
      )
    );



    return Scaffold(
      body: Center(
          child: Row(
            children: <Widget>[
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      SizedBox(child: studentProfile)
                    ],
                ),
              ),
            ),
          ],
      )),
    );
  }
}
