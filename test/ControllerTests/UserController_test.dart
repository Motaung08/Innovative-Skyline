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
    tester.email = 'Katester@wits.ac.za';
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

    test('Student Registration', () async {
      UserController studUserCtr = new UserController();
      StudentController studLog = new StudentController();
      
      expect(await studUserCtr.userRegistration(studUser,url:"https://lamp.ms.wits.ac.za/~s1611821/register_user.php"
      ,url2:"https://lamp.ms.wits.ac.za/~s1611821/register_student.php"), 'User Registered Successfully');

      expect(await studUserCtr.userExists(studUser.email,url: "https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"),
          true);

      expect(await studUserCtr.getUser(studUser.email,url:"https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"),
          isNotNull);

      expect(await studUserCtr.ResetPassword(studUser.email, 'password',
          url:"https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php" ), 'Successfully updated password!');

      expect(await studUserCtr.ResetPassword("invalid","NewExamplePassword",
          url:"https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php"), "No user found :(");

      expect(await studUserCtr.userDeRegistration(studUser,url:"https://lamp.ms.wits.ac.za/~s1611821/deregister_user.php")
          , 'Student removed successfully.');

    });


  });

  group('Test Supervisor user', (){

    User testSupUser = new User();
    testSupUser.email = 'testSup@wits.ac.za';
    testSupUser.password = 'supPass';
    testSupUser.userTypeID =2;

    Supervisor testSup=new Supervisor();

    testSup.email=testSupUser.email;
    testSup.staffNo="UniqueStaffNo123456b";
    testSup.fName="Tshepang";
    testSup.lName="Motaung";
    testSup.office="+134";


    User testUserSup=new User();

    testUserSup.email='tsh@wits.ac.za';
    testUserSup.password="password";
    testUserSup.userTypeID=2;

//    test('Supervisor Login',() async{
//      UserController userSupCtr=new UserController();
//      SupervisorController SupCtrl=new SupervisorController();
//
//      expect(await supervisorController.registration(testSup,testUserSup,
//          url:'https://lamp.ms.wits.ac.za/~s1611821/Register_Supervisor.php',
//          url2: "https://lamp.ms.wits.ac.za/~s1611821/register_user.php"),
//      "Supervisor successfully registered!");
//p


//    test('Get User',() async{
//      UserController userController=new UserController();
//      expect(await userController.getUser(testSupUser.email,
//          url:"https://lamp.ms.wits.ac.za/~s1611821/readUsers.php"), isNotNull);
//    });



  });





}