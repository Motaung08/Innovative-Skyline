import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';

class StudentController extends StatefulWidget {

  String msg = '';
  Future<List> GetStudDetails() async {
    //print('let us deduce details...'+user.email);

    final response = await http.post(
        "https://witsinnovativeskyline.000webhostapp.com/viewStudentProfile.php",
        body: {
          "Email": user.email,
        });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      print("Nada");
      //setState(() {
      msg = " Error :( ";
      // });
    } else {
      print("Assigning...");
      print(datauser);

      student.fName = datauser[0]['Student_FirstName'];
      student.lName = datauser[0]['Student_LastName'];
      student.studentNo = datauser[0]['StudentNo'];
      print('currently ... student no: '+ student.studentNo);
      student.degreeID = int.parse(datauser[0]['Degree_ID']);
      student.registrationDate=DateTime.parse(datauser[0]['Student_RegistrationDate']);
      //print('currently ... date: '+ student.registrationDate.toString());
      student.email=user.email;


    }
    //print(response.body);

    return datauser;
  }


  Future<String> studentRegistration(Student studentA, User userA) async {
    student.register=false;
    bool success=false;
    await userController.userRegistration(userA);

    // SERVER API URL
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/register_student.php';

    // Store all data with Param Name.
    var data = {
      'email': studentA.email,
      'StudentNo': studentA.studentNo,
      'Student_FName': studentA.fName,
      'Student_LName': studentA.lName,
      'DegreeType': studentA.degreeID.toString(),
      'RegistrationDate': (studentA.registrationDate).toString(),
      'StudentTypeID':studentA.studentTypeID.toString()
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);


    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      success = true;
      student.fName=studentA.fName;
      student.lName=studentA.lName;
      student.email=studentA.email;
      student.studentTypeID=studentA.studentTypeID;
      student.studentNo=studentA.studentNo;
      student.registrationDate=studentA.registrationDate;
      student.degreeID=studentA.degreeID;

    }


    if (user.register==true && success==true){
      student.register=true;
    }
    return message;

  }

  @override
  _StudentControllerState createState() => _StudentControllerState();
}

class _StudentControllerState extends State<StudentController> {



  @override
  Widget build(BuildContext context) {
//    setState(() {
//
//    });
    return Container();
  }
}
