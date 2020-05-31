import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/SupervisorController.dart';
import 'package:postgrad_tracker/Controller/TaskStatusController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';

class MockUserController extends Mock implements UserController{}
void main(){

  group('Test Student User',(){
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

    User testUser=new User();

    testUser.email='testStudent@students.wits.ac.za';
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


    test('StudentLogin',() async{
      UserController userController=new UserController();
      StudentController studentController=new StudentController();
      expect(await studentController.studentRegistration(testStudent,testUser), "Student Register Success");
      expect(await userController.login(testUser.email, testUser.password),true);
    });

    test('User exists',() async{
      UserController userController=new UserController();
      expect(await userController.userExists(testUser.email), true);
    });


    test('Get User',() async{
      UserController userController=new UserController();
      expect(await userController.getUser(testUser.email), isNotNull);
    });

    test('Reset Password',() async{
      UserController userController=new UserController();
      expect(await userController.ResetPassword(testUser.email,"NewExamplePassword"), "Successfully updated password!");
    });

    test('Test student type user deregistration', () async{
      UserController userController = new UserController();

      expect(await userController.userDeRegistration(testUser), "Student removed successfully.");

    });

    test('StudentLogin for invalid email',() async{
      UserController userController=new UserController();
      expect(await userController.login(testUser.email, testUser.password),false);
    });
  });
  group('Test User', (){



    //---

    User testSupUser = new User();
    testSupUser.email = 'testSup@wits.ac.za';
    testSupUser.password = 'supPass';
    testSupUser.userTypeID =2;

    Supervisor testSupervisor=new Supervisor();

    testSupervisor.email=testSupUser.email;
    testSupervisor.staffNo="UniqueStaffNo123456";
    testSupervisor.fName="Tshepang";
    testSupervisor.lName="Motaung";
    testSupervisor.office="+134";

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

    User testUser=new User();

    testUser.email='testSup@wits.ac.za';
    testUser.password="testPassword";
    testUser.userTypeID=2;


    test('Supervisor Login',() async{
      UserController userController=new UserController();
      SupervisorController supervisorController=new SupervisorController();
      expect(await supervisorController.registration(testSupervisor,testUser), "Supervisor successfully registered!");
      expect(await userController.login(testUser.email, testUser.password),true);
    });

    test('User exists',() async{
      UserController userController=new UserController();
      expect(await userController.userExists(testUser.email), true);
    });


    test('Get User',() async{
      UserController userController=new UserController();
      expect(await userController.getUser(testUser.email), isNotNull);
    });

    test('Reset Password',() async{
      UserController userController=new UserController();
      expect(await userController.ResetPassword(testUser.email,"NewExamplePassword"), "Successfully updated password!");
    });

    test('Test supervisor type user deregistration', () async{
      UserController userController = new UserController();

      expect(await userController.userDeRegistration(testUser), "Supervisor removed successfully.");

    });

    test('Supervisor Login for invalid email',() async{
      UserController userController=new UserController();
      expect(await userController.login(testUser.email, testUser.password),false);
    });



  });
  test('Read users', (){
    UserController userController=new UserController();
    expect(userController.ReadUsers(), isNotNull);
  });
}