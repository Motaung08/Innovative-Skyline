import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;


void main() {
  group('Student tests', () {
    Student aStudent = new Student();
    aStudent.email = 'aStudentUnique123@students.wits.ac.za';
    aStudent.studentNo = '09887';

    User testUser = new User();
    testUser.email = '123TestStudentUnique@students.wits.ac.za';
    testUser.password = "testPassword";
    testUser.userTypeID = 1;

    Student testStudent = new Student();
    testStudent.email = testUser.email;
    testStudent.studentNo = "123TestUnique";
    testStudent.fName = "Test";
    testStudent.lName = "Student";
    testStudent.degreeID = 1;
    testStudent.registrationDate = DateTime.now();
    testStudent.studentTypeID = 1;

    test('studentRegistration', () async {
      StudentController studentController = new StudentController();
      expect(
          await studentController.studentRegistration(testStudent, testUser,
              url1: 'https://lamp.ms.wits.ac.za/~s1611821/register_student.php',
              url2: "https://lamp.ms.wits.ac.za/~s1611821/register_user.php"),
          "Student Register Success");
      await userController.userDeRegistration(testUser,
          url: "https://lamp.ms.wits.ac.za/~s1611821/deregister_user.php");
    });

    test('fetchStudent', () async {
      testStudent.email = '1713445@students.wits.ac.za';
      //testStudent.studentNo='1713445';
      StudentController studentController = new StudentController();
      http.Client client=new http.Client();
      expect(
          await studentController.fetchStudent(
              testStudent.email, null, client,
              urlViewStudentProfile:
                  'https://lamp.ms.wits.ac.za/~s1611821/viewStudentProfile.php',
              urlViewStudentStudNo:
                  'https://lamp.ms.wits.ac.za/~s1611821/viewStudentStudNo.php'),
          isNotNull);
      //var j=await userController.userDeRegistration(testUser,url:"https://lamp.ms.wits.ac.za/~s1611821/deregister_user.php");
    });

    test('setStudentUser', () async {
      testStudent.email='1713445@students.wits.ac.za';
      StudentController studentController = new StudentController();
      http.Client client=new http.Client();
      await studentController.setStudentUser(testStudent.email, client,
          urlViewStudentProfile:
              "https://lamp.ms.wits.ac.za/~s1611821/viewStudentProfile.php",
          urlReadBoards: "https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
      expect(student != null, true);
//
    });

  });
}
