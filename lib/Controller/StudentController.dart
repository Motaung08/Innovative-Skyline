import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';

import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';

// ignore: must_be_immutable
class StudentController{

  /*
  The purpose of this method is to retrieve the attributes of a specified
  Student instance in the database based on a passed in email address.
   */
  Future<Student> fetchStudent(String email, String studNo, {url1='http://10.100.15.38/viewStudentProfile.php',
  url2="http://10.100.15.38/viewStudentStudNo.php"}) async {

    String msg='';
    Student aStudent=new Student();
    String url;
    var data;
    if(email!=null){
      email=email.toLowerCase();
      url=url1;
      data={
        "Email": email,
      };
    }
    else if(studNo!=null){
      studNo=studNo.toLowerCase();
      url=url2;
      data={
        "StudNo" : studNo
      };
    }
//
    final response = await http.post(url, body: data);
    //print(" ===========================   response "+response.body);
    var datauser = json.decode(response.body);

    if (datauser==null) {

      msg = " Error :( No such student found. ";

    } else {
      msg="Found student, assigning attributes ...";

      aStudent.fName = datauser[0]['Student_FirstName'];
      aStudent.lName = datauser[0]['Student_LastName'];
      aStudent.studentNo = datauser[0]['StudentNo'];
      aStudent.degreeID = int.parse(datauser[0]['Degree_ID']);
      aStudent.registrationDate=DateTime.parse(datauser[0]['Student_RegistrationDate']);
      aStudent.email=datauser[0]['Student_Email'];
      aStudent.studentTypeID=int.parse(datauser[0]['StudentTypeID']);
    }
    print(msg);
    return aStudent;
  }

  /*
  The purpose of this method is to assign the student attributes of a user
  and subsequently load the project boards which are associated.
   */
  Future setStudentUser(String email, {url='http://10.100.15.38/viewStudentProfile.php',url2:'http://10.100.15.38/ReadBoards.php',
    url3="http://10.100.15.38/viewStudentStudNo.php"}) async {

    student= await fetchStudent(email,null,url1: url,url2: url3);

    personNo=student.studentNo;
    user.boards.clear();
    Project_BoardController projectBoardController=new Project_BoardController();
    List<List<Project_Board>> allBoards=await projectBoardController.ReadBoards(user.userTypeID,student.studentNo,url:url2);

    print('ay : '+(allBoards.isEmpty).toString());
    if(allBoards.isEmpty==false){
      if(allBoards[0]==null){
        user.boards=null;
      }else{
        user.boards=allBoards[0];

      }
      if(allBoards[1]==null){
        user.archivedBoards=null;
      }else{
        user.archivedBoards=allBoards[1];
      }


    }else{
      user.boards=null;
      user.archivedBoards=null;
    }



  }

  /*
    The purpose of this method is to take in a student object and a user object
     (created when the user selects register under the student registration
     page) and subsequently creates instances in the Student Table and User
     Table respectively. This method ensures that a duplicate email address is
     not used.

     NOTE: Should subsequently log the new user in if the registration is
     successful.
   */
  Future<String> studentRegistration(Student studentA, User userA, {url1='http://10.100.15.38/register_student.php',
    url2='http://10.100.15.38/register_user.php'}) async {

    student.register=false;
    bool success=false;
    String userSuccess="";
    String registrationSuccess="";
    userSuccess= await userController.userRegistration(userA,url:url2,url2: url1);
    if (userSuccess=="Email Already Exists, Please Try Again With New Email Address..!"){
      registrationSuccess=userSuccess;
    }else{
      // SERVER API URL
//      var url =
//          'http://10.100.15.38/register_student.php';
//          'https://witsinnovativeskyline.000webhostapp.com/register_student.php';

      // Store all data with Param Name.
      var data = {
        'email': studentA.email.toLowerCase(),
        'StudentNo': studentA.studentNo.toLowerCase(),
        'Student_FName': studentA.fName,
        'Student_LName': studentA.lName,
        'DegreeType': studentA.degreeID.toString(),
        'RegistrationDate': (studentA.registrationDate).toString(),
        'StudentTypeID':studentA.studentTypeID.toString()
      };

      // Starting Web API Call.
      var response = await http.post(url1, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      print("MESSAGE: "+message);
      // If Web call Success than Hide the CircularProgressIndicator.
      if (message == "Student Registered Successfully") {
        success = true;
        student.fName=studentA.fName;
        student.lName=studentA.lName;
        student.email=studentA.email;
        student.studentTypeID=studentA.studentTypeID;
        student.studentNo=studentA.studentNo;
        student.registrationDate=studentA.registrationDate;
        student.degreeID=studentA.degreeID;

      }
      else if(message=="An account has already been created for this student number."){
        UserController userController=new UserController();
        userController.userDeRegistration(userA);
        success=false;
        registrationSuccess="This student number already has an associated account.";
      }
      else{
        success=false;
      }


      if (user.register==true && success==true){
        student.register=true;
        registrationSuccess="Student Register Success";
      }
    }

    return registrationSuccess;

  }


}
