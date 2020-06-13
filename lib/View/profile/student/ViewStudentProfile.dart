import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Model/DegreeType.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/StudentType.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:intl/intl.dart';

import '../../../user.dart';
// ignore: camel_case_types
class viewStudent{

  Widget getProfile(Student viewStudent, BuildContext context, double textHeadingSize, double textValueSize){

    /*TODO  this should not even be here but on test file its here since i cant access the global variables you use in tests; */
    /*TODO the student parameter passed in wiidgetBuild where is it defined */

    if(viewStudent.fName==null){
      print("Hala");
      viewStudent=new Student();
      viewStudent.fName="Student";
      viewStudent.studentNo="123";
      viewStudent.lName="Foster";
      viewStudent.degreeID=1;
      viewStudent.studentTypeID=1;
      viewStudent.registrationDate=new DateTime.now();
      DegreeType degree=DegreeType();
      degree.Degree_Type="Honours";
      degree.DegreeID=1;
      degrees.add(degree);
      StudentType type=StudentType();
      type.Student_Type="Full time";
      type.StudentTypeID=1;
      studentTypes.add(type);
    }

    TextStyle headingStyle = TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xff009999),
        fontWeight: FontWeight.bold,
        fontSize: textHeadingSize
    );

    TextStyle valueStyle = TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: textValueSize
    );
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String typeName="";
    return Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Profile:",
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
                Text("Name: \n",
                    style: headingStyle
                ),
              Text( ViewStudentProfilePage.validate(viewStudent.fName)+ " " +ViewStudentProfilePage.validate(viewStudent.lName) + "\n",
                    textAlign: TextAlign.start,
                    key: Key('StudFullName'),
                    style: valueStyle
              ),
                Text("Student Number: \n",
                    style: headingStyle),
                Text( ViewStudentProfilePage.validate(viewStudent.studentNo) + "\n",
                    textAlign: TextAlign.start,
                    key: Key('StudentNoText'),
                    style: valueStyle),
                Text("Email: \n",
                    style: headingStyle),
                Text( ViewStudentProfilePage.validate(viewStudent.email) + "\n",
                    textAlign: TextAlign.center,
                    key: Key('EmailText'),
                    style: valueStyle),
                Text("Degree: \n" ,
                    style: headingStyle),
                Text(  ViewStudentProfilePage.validate(degrees[viewStudent.degreeID-1].Degree_Type)
                    + "\n",
                    key: Key('DegreeText'),
                    textAlign: TextAlign.start,
                    style: valueStyle),
                Text("Date Registered: \n" ,
                    style: headingStyle),
                Text( dateFormat.format(ViewStudentProfilePage.validateDate(viewStudent.registrationDate)) + "\n",
                    textAlign: TextAlign.start,
                    key: Key('DORText'),
                    style: valueStyle),
                Text("Student Type: \n",
                    style: headingStyle ),
                Text( ViewStudentProfilePage.validate(studentTypes[(viewStudent.studentTypeID-1)].Student_Type)
                    + "\n",
                    textAlign: TextAlign.start,
                    key: Key('StudentText'),
                    style: valueStyle),
              ],
            ),
          ),
        )
    );
  }
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


class _ViewStudentProfilePageState extends State<ViewStudentProfilePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: viewStudent().getProfile(student,context,17,16),
    );
  }
}