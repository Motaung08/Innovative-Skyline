import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Controller/DegreeController.dart';
import 'package:postgrad_tracker/Controller/ListController.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/StudentTypeController.dart';
import 'package:postgrad_tracker/Controller/SupervisorController.dart';
import 'package:postgrad_tracker/Controller/TaskController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/AssignmentType.dart';
import 'package:postgrad_tracker/Model/DegreeType.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/StudentType.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/TaskStatus.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'package:postgrad_tracker/View/Home.dart';
import 'package:postgrad_tracker/View/Login.dart';
import 'package:postgrad_tracker/View/profile/student/ViewStudentProfile.dart';
import 'package:postgrad_tracker/View/profile/supervisor/ViewSupProfile.dart';
import 'package:postgrad_tracker/View/register/StudentRegister.dart';
import 'package:postgrad_tracker/View/register/StudentSuperVisorRegister.dart';
import 'package:postgrad_tracker/View/register/SupervisorRegister.dart';
import 'package:postgrad_tracker/View/resetpassword.dart';
import 'package:responsive_framework/responsive_framework.dart';



//String boardTitle = '';
User user=new User();

Supervisor supervisor=new Supervisor();
Student student=new Student();

List<DegreeType> degrees=List();
List<StudentType> studentTypes=List();
List<TaskStatus> taskStatuses=List();
List<AssignmentType>assignmentTypes=List();

// ignore: non_constant_identifier_names
//Project_Board project_board=new Project_Board();
ListCard listCard=new ListCard();


StudentController studentController=new StudentController();
SupervisorController supervisorController=new SupervisorController();
UserController userController=new UserController();
DegreeController degreeController=new DegreeController();
StudentTypeController studentTypeController=new StudentTypeController();

// ignore: non_constant_identifier_names
//Project_BoardController project_boardController=new Project_BoardController();
ListController listController=new ListController();
TaskController taskController=new TaskController();

//ProjectBoardView
HomePage homePage=new HomePage();
Board boardPage=new Board();



String personNo="";




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //boardPage.populateListDisplay(55);

    return MaterialApp(
//      builder: (context, widget) => ResponsiveWrapper.builder(
//        BouncingScrollWrapper.builder(context, widget),
//        maxWidth: 1200,
//        minWidth: 450,
//        defaultScale: true,
//        breakpoints: [
//          ResponsiveBreakpoint.resize(450, name: MOBILE),
//          ResponsiveBreakpoint.autoScale(800, name: TABLET),
//          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
//          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
//          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
//        ],
//
//      ),

      title: 'Postgraduate Tracker',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        //'/': (context) => new LoginPage(),
        '/Login': (context) => new LoginPage(),
        '/Home': (context) => homePage,
        //'/Home': (context) => new HomePage(email: student.email, userType: user.userTypeID),
        '/StudProfile': (BuildContext context) => new ViewStudentProfilePage(),
//        new ViewStudentProfilePage(user: user,),
        '/SupProfile': (BuildContext context) => new ViewSupProfilePage(),
        '/RegisterChoice': (context) => new StudentSupChoicePage(),
        '/StudentRegister': (context) => new StudentRegisterPage(),
        '/SupervisorRegister': (context) => new SupervisorRegisterPage(),

        '/Board': (context) =>  boardPage,
        '/ResetPassword': (context) => new ResetPasswordView(),


      },
      //home: LoginPage(),
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    );
  }
}
