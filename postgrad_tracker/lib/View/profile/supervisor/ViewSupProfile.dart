import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;



class ViewSupProfilePage extends StatefulWidget {
final User user;

  const ViewSupProfilePage({Key key, this.user}) : super(key: key);
  @override
  _ViewSupProfilePageState createState() => _ViewSupProfilePageState();
}

String msg = '';

class _ViewSupProfilePageState extends State<ViewSupProfilePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future<List> _viewSupDetails() async {
    //print('let us deduce details...');
    final response = await http.post(
        "https://witsinnovativeskyline.000webhostapp.com/viewSupProfile.php",
        body: {
          "Email": user.email,
        });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      //print("Nada");
      setState(() {
        msg = " Error :( ";
      });
    } else {
      //print("Assigning...");
      setState(() {
        supervisor.fName = datauser[0]['Sup_FName'];
        supervisor.lName = datauser[0]['Sup_LName'];
        supervisor.staffNo = datauser[0]['StaffNo'];
        supervisor.office = datauser[0]['Sup_OfficePhone'];
        supervisor.email = user.email;
      });
    }
    //print(response.body);
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    _viewSupDetails();
    final FullName = supervisor.fName + " " + supervisor.lName;

    final studentProfile = Container(
        //elevation: 5.0,
        //borderRadius: BorderRadius.circular(30.0),

        child: Column(children: <Widget>[
      Text("Profile:  \n",
          //textAlign: TextAlign.center,
          style: style.copyWith(
              color: Color(0xff009999),
              fontWeight: FontWeight.bold,
              fontSize: 24)),
      Text("Name: " + FullName + "\n",
          //textAlign: TextAlign.center,
          style: style.copyWith(
              color: Color(0xff009999),
              fontWeight: FontWeight.bold,
              fontSize: 18)),
      Text("Staff Number: " + supervisor.staffNo + "\n",
          //textAlign: TextAlign.start,
          style: style.copyWith(
              color: Color(0xff009999),
              fontWeight: FontWeight.bold,
              fontSize: 18)),
      Text("Email: " + supervisor.email + "\n",
          textAlign: TextAlign.center,
          style: style.copyWith(
              color: Color(0xff009999),
              fontWeight: FontWeight.bold,
              fontSize: 18)),
      Text("Office Phone: " + supervisor.office + "\n",
          textAlign: TextAlign.start,
          style: style.copyWith(
              color: Color(0xff009999),
              fontWeight: FontWeight.bold,
              fontSize: 18))
    ]));

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
                children: <Widget>[SizedBox(child: studentProfile)],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
