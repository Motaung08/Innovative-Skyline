import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';
import 'ListController_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../Student_register_test.dart';

void main() {
  group('Student tests', () {
    test('fetchStudent', () async {
      StudentController studentController=new StudentController();

      expect(await studentController.fetchStudent('1713445@students.wits.ac.za'), isInstanceOf<Student>());
    });

    test('setStudentUser', () async {
      StudentController studentController=new StudentController();
      await studentController.setStudentUser('1713445@students.wits.ac.za');
      expect(student!=null, true);
    });

    test('studentRegistration', () async {
          User testUser=new User();

          testUser.email='testStudentInReg@students.wits.ac.za';
          testUser.password="testPassword";
          testUser.userTypeID=1;

          Student testStudent=new Student();
          testStudent.email=testUser.email;
          testStudent.studentNo="UniqueStudNo123";
          testStudent.fName="Test";
          testStudent.lName="Student";
          testStudent.degreeID=1;
          testStudent.registrationDate=DateTime.now();
          testStudent.studentTypeID=1;

          //testStudent.studentTypeID
      StudentController studentController=new StudentController();

      expect(await studentController.studentRegistration(testStudent,testUser), "Student Register Success");
      UserController userController=new UserController();
      await userController.userDeRegistration(testUser);

    });

  });

}
