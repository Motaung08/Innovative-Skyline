import 'package:flutter/material.dart';
import 'package:postgrad_tracker/main.dart';



class ViewSupProfilePage extends StatefulWidget {
//final User user;
  static String validate(String a){
    if(a==null){
      return 'null';
    }
    else {
      return a;
    }
  }
  //const ViewSupProfilePage({Key key, this.user}) : super(key: key);
  @override
  _ViewSupProfilePageState createState() => _ViewSupProfilePageState();
}

String msg = '';

class _ViewSupProfilePageState extends State<ViewSupProfilePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String validate(String a) {
    if (a == null) {
      return 'null';
    }
    else {
      return a;
    }
  }

  @override
  Widget build(BuildContext context) {
   // supervisorController.GetSupDetails();
    setState(() {

    });
    //final FullName = supervisor.fName + " " + supervisor.lName;

    final supervisorProfile = Container(
        child: Column(children: <Widget>[
          Text("Profile:  \n",
              key: Key('ProfileText'),
              //textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
          Text("Name: " + ViewSupProfilePage.validate(supervisor.fName)+" "+ViewSupProfilePage.validate(supervisor.lName) + "\n",
              //textAlign: TextAlign.center,
              key: Key('NameText'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Text("Staff Number: " + ViewSupProfilePage.validate(supervisor.staffNo) + "\n",
              //textAlign: TextAlign.start,
              key: Key('StaffNumberText'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Text("Email: " + ViewSupProfilePage.validate(supervisor.email) + "\n",
              textAlign: TextAlign.center,
              key: Key('EmailText'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Text("Office Phone: " + ViewSupProfilePage.validate(supervisor.office) + "\n",
              textAlign: TextAlign.start,
              key: Key('OfficePhoneText'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18))
        ]));

    return Scaffold(
      body: Center(
          child: Row(children: <Widget>[
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[SizedBox(child: supervisorProfile)],
                ),
              ),
            ),
        ],
      )),
    );
  }
}
