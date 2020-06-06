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

  group('Test Student User',()
  {
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
//
//    testUser.email='
//    testUser.password="password";
//    testUser.userTypeID=2;

    Student testStudent = new Student();
    testStudent.email = '16512@student.wits.ac.za';
    testStudent.studentNo = "16512";
    testStudent.fName = "Test";
    testStudent.lName = "Student";
    testStudent.degreeID = 1;
    testStudent.registrationDate = DateTime.now();
    testStudent.studentTypeID = 1;


    test('StudentLogin', () async {
      UserController userController = new UserController();
      StudentController studentController = new StudentController();


      User studUser = new User();
      studUser.email = testStudent.email;
      studUser.userTypeID = testStudent.studentTypeID;
      studUser.password = "password";

      expect(await userController.userRegistration(studUser,
          url: "https://lamp.ms.wits.ac.za/~s1611821/register_user.php",
          url2: "https://lamp.ms.wits.ac.za/~s1611821/register_student.php"),
          "User Registered Successfully");
//      expect(await userController.login(studUser.email, studUser.password,
//          url: "https://lamp.ms.wits.ac.za/~s1611821/login.php"), true);
//      expect(await userController.userDeRegistration(studUser),
//          "Student removed successfully.");
    });
  });

//    test('User exists',() async{
//      UserController userController=new UserController();
//      expect(await userController.userExists(testUser.email,url:"https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"), true);
//    });
//
//
//    test('Get User',() async{
//      UserController userController=new UserController();
//      expect(await userController.getUser(testUser.email,url:"https://lamp.ms.wits.ac.za/~s1611821/register_user.php"), isNotNull);
//    });
//
//    test('Reset Password',() async{
//      UserController userController=new UserController();
//      expect(await userController.ResetPassword(testUser.email,"NewExamplePassword",url:"https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php"), "Successfully updated password!");
//    });
//
//    test('Reset Password invalid user',() async{
//      UserController userController=new UserController();
//      expect(await userController.ResetPassword("invalid","NewExamplePassword",url:"https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php"), "No user found :(");
//    });
//
//    test('Test student type user deregistration', () async{
//      UserController userController = new UserController();
//
//      expect(await userController.userDeRegistration(testUser,url:"https://lamp.ms.wits.ac.za/~s1611821/deregister_user.php"), "Student removed successfully.");
//
//    });
//
//    test('StudentLogin for invalid email',() async{
//      UserController userController=new UserController();
//      expect(await userController.login(testUser.email, testUser.password,url:"https://lamp.ms.wits.ac.za/~s1611821/login.php"),false);
//    });
//  });
//
//
//
//
//
//  group('Test Supervisor user', (){
//
//    User testSupUser = new User();
//    testSupUser.email = 'testSup@wits.ac.za';
//    testSupUser.password = 'supPass';
//    testSupUser.userTypeID =2;
//
//    Supervisor testSupervisor=new Supervisor();
//
//    testSupervisor.email=testSupUser.email;
//    testSupervisor.staffNo="UniqueStaffNo123456b";
//    testSupervisor.fName="Tshepang";
//    testSupervisor.lName="Motaung";
//    testSupervisor.office="+134";
//
//    /*
//    Functions to test:
//
//    -userRegistration
//    -userDeRegistration
//    -login
//    -ReadUsers
//    -userExists
//    -getUser
//    -ResetPassword
//     */
//
//    User testUser=new User();
//
//    testUser.email='1657114@student.wits.ac.za';
//    testUser.password="password";
//    testUser.userTypeID=2;
//
//
//    test('Supervisor Login',() async{
//      UserController userController=new UserController();
//      SupervisorController supervisorController=new SupervisorController();
//      expect(await supervisorController.registration(testSupervisor,testUser,url:'https://lamp.ms.wits.ac.za/~s1611821/Register_Supervisor.php'), "Supervisor successfully registered!");
//      expect(await userController.login(testUser.email, testUser.password,url:"https://lamp.ms.wits.ac.za/~s1611821/login.php"),true);
//    });
//
//    test('User exists',() async{
//      UserController userController=new UserController();
//      expect(await userController.userExists(testUser.email), true);
//    });
//
//
//    test('Get User',() async{
//      UserController userController=new UserController();
//      expect(await userController.getUser(testUser.email,url:"https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"), isNotNull);
//    });
//
//    test('Reset Password',() async{
//      UserController userController=new UserController();
//      print(testUser.email);
//      expect(await userController.ResetPassword("tman@gmail.com","password",url:"https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php"), "Successfully updated password!");
//    });
//
//    test('Test supervisor type user deregistration', () async{
//      UserController userController = new UserController();
//
//      expect(await userController.userDeRegistration(testUser,url:"https://lamp.ms.wits.ac.za/~s1611821/deregister_user.php"), "Supervisor removed successfully.");
//
//    });
//
//    test('Supervisor Login for invalid email',() async{
//      UserController userController=new UserController();
//      expect(await userController.login(testUser.email, testUser.password,url:"https://lamp.ms.wits.ac.za/~s1611821/login.php"),false);
//    });
//
//
//
//  });
//  test('Read users', (){
//    UserController userController=new UserController();
//    expect(userController.ReadUsers(), isNotNull);
//  });
}