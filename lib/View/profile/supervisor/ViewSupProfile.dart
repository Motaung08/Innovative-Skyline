import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/main.dart';

class viewSupervisor {
  Widget getProfile(Supervisor sup, BuildContext context,
      double textHeadingSize, double textValueSize) {
    TextStyle headingStyle = TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xff009999),
        fontWeight: FontWeight.bold,
        fontSize: textHeadingSize);

    TextStyle valueStyle = TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: textValueSize);
    return Center(
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text("Profile:  ",
                key: Key('ProfileText'),
                textAlign: TextAlign.center,
                style: headingStyle.copyWith(
                    color: Color(0xff009999),
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
//                  SizedBox(
//                    width: 20,
//                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ),
//                  SizedBox(
//                    width: 20,
//                  ),
                ],
              ),
            ),
            Text("Name: \n", style: headingStyle),
            Text(
                ViewSupProfilePage.validate(sup.fName) +
                    " " +
                    ViewSupProfilePage.validate(sup.lName) +
                    "\n",
                //textAlign: TextAlign.center,
                key: Key('NameText'),
                style: valueStyle),
            Text("Staff Number: \n", style: headingStyle),
            Text(ViewSupProfilePage.validate(sup.staffNo) + "\n",
                //textAlign: TextAlign.start,
                key: Key('StaffNumberText'),
                style: valueStyle),
            Text("Email: \n", style: headingStyle),
            Text(ViewSupProfilePage.validate(sup.email) + "\n",
                textAlign: TextAlign.center,
                key: Key('EmailText'),
                style: valueStyle),
            Text("Office Phone: \n", style: headingStyle),
            Text(ViewSupProfilePage.validate(sup.office) + "\n",
                textAlign: TextAlign.start,
                key: Key('OfficePhoneText'),
                style: valueStyle)
          ]),
    ));
  }
}

class ViewSupProfilePage extends StatefulWidget {
//final User user;
  static String validate(String a) {
    if (a == null) {
      return 'null';
    } else {
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
    } else {
      return a;
    }
  }

  @override
  Widget build(BuildContext context) {
    // supervisorController.GetSupDetails();
    setState(() {});
    //final FullName = supervisor.fName + " " + supervisor.lName;

//    final supervisorProfile = Container(
//        child: Column(children: <Widget>[
//          Text("Profile:  \n",
//              key: Key('ProfileText'),
//              //textAlign: TextAlign.center,
//              style: style.copyWith(
//                  color: Color(0xff009999),
//                  fontWeight: FontWeight.bold,
//                  fontSize: 24)),
//          Text("Name: " + ViewSupProfilePage.validate(supervisor.fName)+" "+ViewSupProfilePage.validate(supervisor.lName) + "\n",
//              //textAlign: TextAlign.center,
//              key: Key('NameText'),
//              style: style.copyWith(
//                  color: Color(0xff009999),
//                  fontWeight: FontWeight.bold,
//                  fontSize: 18)),
//          Text("Staff Number: " + ViewSupProfilePage.validate(supervisor.staffNo) + "\n",
//              //textAlign: TextAlign.start,
//              key: Key('StaffNumberText'),
//              style: style.copyWith(
//                  color: Color(0xff009999),
//                  fontWeight: FontWeight.bold,
//                  fontSize: 18)),
//          Text("Email: " + ViewSupProfilePage.validate(supervisor.email) + "\n",
//              textAlign: TextAlign.center,
//              key: Key('EmailText'),
//              style: style.copyWith(
//                  color: Color(0xff009999),
//                  fontWeight: FontWeight.bold,
//                  fontSize: 18)),
//          Text("Office Phone: " + ViewSupProfilePage.validate(supervisor.office) + "\n",
//              textAlign: TextAlign.start,
//              key: Key('OfficePhoneText'),
//              style: style.copyWith(
//                  color: Color(0xff009999),
//                  fontWeight: FontWeight.bold,
//                  fontSize: 18))
//        ]));

    return Scaffold(
      body: Center(
          child: viewSupervisor().getProfile(supervisor, context, 17, 16)),
    );
  }
}
