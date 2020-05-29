import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';
import 'ListController_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'Student_register_test.dart';


class Post {
  dynamic data;
  Post.fromJson(this.data);
}

Future<Post> fetchPost(http.Client client) async {
  final response =
  await client.get('https://witsinnovativeskyline.000webhostapp.com/viewStudentProfile.php');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}



void main() {
  group('Student tests', () {
    test(
        'fetchStudent', () async {
      StudentController studentController=new StudentController();

      expect(await studentController.fetchStudent('1713445@students.wits.ac.za'), isInstanceOf<Student>());
    });

    test(
        'setStudentUser', () async {
      StudentController studentController=new StudentController();
      await studentController.setStudentUser('1713445@students.wits.ac.za');
      expect(student!=null, true);
    });

    test("Fetch Student", () async {
      StudentController aStudent = new StudentController();

      String email='';
      String userSuccess='';
      String registrationSuccess= "";

      if(userSuccess == "Email Already Exists, Please Try Again With New Email Address..!"){
        registrationSuccess.replaceAll(userSuccess.substring(0), userSuccess);
      }

      await aStudent.fetchStudent(email);

      User user =new User();

      if(user.register == true && userSuccess=='true'){
        student.register = true;
        registrationSuccess = '';
      }

    });
    test(
        'studentRegistration', () async {
          User testUser=new User();
          String userSuccess="";
          String registrationSuccess="";


          testUser.email='testStudent@students.wits.ac.za';
          testUser.password="testPassword";
          testUser.userTypeID=1;

          Student testStudent=new Student();
          testStudent.email=testUser.email;
          testStudent.studentNo="";
          testStudent.fName="";
          testStudent.lName="";
          testStudent.degreeID=1;
          testStudent.registrationDate=DateTime.now();

          //testStudent.studentTypeID
      StudentController studentController=new StudentController();
      await studentController.setStudentUser('1713445@students.wits.ac.za');
      expect(student!=null, true);
    });
    
    

  });

}
