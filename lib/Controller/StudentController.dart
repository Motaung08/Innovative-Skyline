import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';

import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';

// ignore: must_be_immutable
class StudentController extends StatefulWidget {

  /*
  The purpose of this method is to retrieve the attributes of a specified
  Student instance in the database based on a passed in email address.
   */
  Future<Student> fetchStudent(String email) async {
    Student aStudent=new Student();
    final response = await http.post(
        "https://witsinnovativeskyline.000webhostapp.com/viewStudentProfile.php",
        body: {
          "Email": email,
        });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      print("Nada");
      //setState(() {
      //msg = " Error :( ";
      // });
    } else {
      print("Assigning...");
      print(datauser);

      aStudent.fName = datauser[0]['Student_FirstName'];
      aStudent.lName = datauser[0]['Student_LastName'];
      aStudent.studentNo = datauser[0]['StudentNo'];
      aStudent.degreeID = int.parse(datauser[0]['Degree_ID']);
      aStudent.registrationDate=DateTime.parse(datauser[0]['Student_RegistrationDate']);
      aStudent.email=datauser[0]['Student_Email'];
      aStudent.studentTypeID=int.parse(datauser[0]['StudentTypeID']);
    }

    return aStudent;
  }


  /*
  The purpose of this method is to assign the student attributes of a user
  and subsequently load the project boards which are associated.
   */
  Future setStudentUser(String email) async {
    student= await fetchStudent(email);
    user.boards.clear();
    Project_BoardController project_boardController=new Project_BoardController();
    user.boards=await project_boardController.ReadBoards(user.userTypeID,student.studentNo);
  }




  /*
    The purpose of this method is to take in a student object and a user object
     (created when the user selects register under the student registration
     page) and subsequently creates instances in the Student Table and User
     Table respectively. This method ensures that a duplicate email address is
     not used.

     NOTE: Should add a check that the student number is also unique
     as the database requires a unique student number!

     NOTE: Should subsequently log the new user in if the registration is
     successful.
   */
  Future<String> studentRegistration(Student studentA, User userA) async {
    student.register=false;
    bool success=false;
    String userSuccess="";
    String registrationSuccess="";
    userSuccess= await userController.userRegistration(userA);
    if (userSuccess=="Email Already Exists, Please Try Again With New Email Address..!"){
      registrationSuccess=userSuccess;
    }else{
      // SERVER API URL
      var url =
//          'http://146.141.21.17/register_student.php';
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
        registrationSuccess="";
      }
    }

    return registrationSuccess;

  }


  @override
  _StudentControllerState createState() => _StudentControllerState();
}

class _StudentControllerState extends State<StudentController> {



  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
