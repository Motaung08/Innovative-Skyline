import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/SupervisorController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';


class MockUserController extends Mock implements UserController{}

void main(){
  group('Student User tests', (){

    Student tester = new Student();
    tester.email = 'UniqueTestEmail@wits.ac.za';
    tester.studentNo = '12345';
    tester.fName = 'Test';
    tester.lName = 'Pass';
    tester.studentTypeID =1;
    tester.registrationDate = DateTime.now();
    tester.degreeID =1;


    User studUser = new User();
    studUser.email = tester.email;
    studUser.password = 'test@1234';
    studUser.userTypeID =tester.studentTypeID;
    UserController studUserCtr = new UserController();
    StudentController studLog = new StudentController();
    test('Student Registration', () async {
      expect(await studUserCtr.userRegistration(studUser,url:"https://lamp.ms.wits.ac.za/~s1611821/register_user.php"
      ,url2:"https://lamp.ms.wits.ac.za/~s1611821/register_student.php"), 'User Registered Successfully');
    });
    test('userExists',() async {
      expect(await studUserCtr.userExists(studUser.email,url: "https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"),
      true);
    });
    test('getUser',() async {
      expect(await studUserCtr.getUser(studUser.email,url:"https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"),
      isNotNull);
    });
    test('ResetPassword valid',() async {
      expect(await studUserCtr.ResetPassword(studUser.email, '123456',
          url:"https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php" ), 'Successfully updated password!');
    });
    test('ResetPassword invalid',() async {
      expect(await studUserCtr.ResetPassword("invalid","NewExamplePassword",
          url:"https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php"), "No user found :(");
    });

    test('login',() async {
      expect(await studUserCtr.login('1713445@students.wits.ac.za', 'Meghan',
        urlLogin: "https://lamp.ms.wits.ac.za/~s1611821/login.php",
        urlGetTaskStatus: "https://lamp.ms.wits.ac.za/~s1611821/getTaskStatuses.php",
        urlGetAssignmentTypes: "https://lamp.ms.wits.ac.za/~s1611821/getAssignmentTypes.php",
        urlGetStudTypes: "https://lamp.ms.wits.ac.za/~s1611821/getStudentTypes.php",
        urlViewStudentProfile: "https://lamp.ms.wits.ac.za/~s1611821/viewStudentProfile.php",
        urlViewStudentStudNo: "https://lamp.ms.wits.ac.za/~s1611821/viewStudentStudNo.php",
        urlReadBoards: "https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php",
        urlViewSupProfile: "https://lamp.ms.wits.ac.za/~s1611821/viewSupProfile.php",
        url9ViewSupStaffNo: "https://lamp.ms.wits.ac.za/~s1611821/http://10.100.15.38/viewSupStaffNo.php",
        urlGetDegreeTypes: "https://lamp.ms.wits.ac.za/~s1611821/getDegreeTypes.php",

      ), true);
    });
    test('userDeRegistration',() async {
      expect(await studUserCtr.userDeRegistration(studUser,url:"https://lamp.ms.wits.ac.za/~s1611821/deregister_user.php")
      , 'Student removed successfully.');
    });


  });

  group('Test Supervisor user', ()
  {
    User testSupUser = new User();
    testSupUser.email = 'testSup@wits.ac.za';
    testSupUser.password = 'supPass';
    testSupUser.userTypeID = 2;

    Supervisor testSupervisor = new Supervisor();

    testSupervisor.email = testSupUser.email;
    testSupervisor.staffNo = "UniqueStaffNo123456b";
    testSupervisor.fName = "Tshepang";
    testSupervisor.lName = "Motaung";
    testSupervisor.office = "+134";

    /*
    Functions to test:

    -userRegistration
    -userDeRegistration
    -login
    -ReadUsers
    -userExists
    -getUser
    -ResetPassword
     */

    User testUser = new User();

    testUser.email = '1657114@student.wits.ac.za';
    testUser.password = "password";
    testUser.userTypeID = 2;


    test('Supervisor Login', () async {
      UserController userController = new UserController();
      SupervisorController supervisorController = new SupervisorController();

      //userRegistration
//      expect(await supervisorController.registration(testSupervisor, testUser,
//          url: 'https://lamp.ms.wits.ac.za/~s1611821/Register_Supervisor.php',
//          url2: 'https://lamp.ms.wits.ac.za/~s1611821/register_user.php'),
//          "Supervisor successfully registered!");

      //userLogin
//      expect(await userController.login(testUser.email, testUser.password,
//          url: "https://lamp.ms.wits.ac.za/~s1611821/login.php",
//          url2: '"https://lamp.ms.wits.ac.za/~s1611821/getTaskStatuses.php',
//          url3: 'https://lamp.ms.wits.ac.za/~s1611821/getAssignmentTypes.php',
//          url4: 'https://lamp.ms.wits.ac.za/~s1611821/getStudentTypes.php'
//      ), false);

      //userExists
      expect(await userController.userExists(testUser.email,url:"https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"), isNotNull);

      //getUser
      expect(await userController.getUser(testUser.email,url:"https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"), isNotNull);

      //userResetPassword
      expect(await userController.ResetPassword('1431795@students.wits.ac.za',"password123",url:"https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php"),
          "Successfully updated password!");

      //ReadUsers
      expect(userController.ReadUsers(url:"https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"), isNotNull);

      //userLogin with invalid username
      expect(await userController.login('1234@students.wits.ac.za', '123456',urlLogin:"https://lamp.ms.wits.ac.za/~s1611821/login.php"),false);

//      //userDeRegistration
//      expect(await userController.userDeRegistration(testUser,url:"https://lamp.ms.wits.ac.za/~s1611821/deregister_user.php"),
//          "No such user exists!");
//    });
//
    });
  });

}