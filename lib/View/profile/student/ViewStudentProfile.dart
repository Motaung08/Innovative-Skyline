import 'package:flutter/material.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:intl/intl.dart';

import '../../../user.dart';
// ignore: camel_case_types
class String_Validator {

}

class ViewStudentProfilePage extends StatefulWidget {
//  final User user;
  static String validate(String a){
    if(a==null){
      return 'null';
    }
    else {
      return a;
    }
  }

  static DateTime validateDate(DateTime a){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    if(a ==null){
      return dateFormat.parse('0000-00-00');
    }
    else{
      return a;
    }
  }
//  const ViewStudentProfilePage({Key key, this.user}) : super(key: key);
  @override
  _ViewStudentProfilePageState createState() => _ViewStudentProfilePageState();
}
final User user = new User();
String msg = '';

class _ViewStudentProfilePageState extends State<ViewStudentProfilePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String typeName="";
  int degreeID =student.degreeID;
 // ignore: non_constant_identifier_names, missing_return
 int DegreeID(){
   if(degreeID!=null){
     return degreeID;
   }
 }

  @override
  Widget build(BuildContext context) {
    //  studentController.GetStudDetails();

    setState(() {

    });

    final studentProfile = Container(

        child: Column(children: <Widget>[
          Text("Profile:  \n",
              key: Key('ProfileText'),
              //textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
          Text("Name: " + ViewStudentProfilePage.validate(student.fName)+ " " +ViewStudentProfilePage.validate(student.lName) + "\n",
              //textAlign: TextAlign.center,
              key: Key('Name'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Text("Student Number: " + ViewStudentProfilePage.validate(student.studentNo) + "\n",
              //textAlign: TextAlign.start,
              key: Key('StudentNoText'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Text("Email: " + ViewStudentProfilePage.validate(student.email) + "\n",
              textAlign: TextAlign.center,
              key: Key('EmailText'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Text("Degree: " +

              ViewStudentProfilePage.validate(degrees[student.degreeID-1].Degree_Type)
              + "\n",
              key: Key('DegreeText'),
              textAlign: TextAlign.start,
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Text("Date Registered: " + dateFormat.format(ViewStudentProfilePage.validateDate(student.registrationDate)) + "\n",
              textAlign: TextAlign.start,
              key: Key('DORText'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Text("Student Type: " +
              ViewStudentProfilePage.validate(studentTypes[(student.studentTypeID-1)].Student_Type)
              + "\n",
              textAlign: TextAlign.start,
              key: Key('StudentText'),
              style: style.copyWith(
                  color: Color(0xff009999),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
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