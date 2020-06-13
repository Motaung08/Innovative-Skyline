import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/DateTime.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Home.dart';
import 'package:postgrad_tracker/main.dart';
import '../Models_test.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client{}

void main(){
  group('All pages should be accessed!!!', ()
  {
    testWidgets('All input feild and button widgets should be on screen', (
        WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(HomePage()));
    });

    testWidgets('All pages should be accessed!!!', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Supervisor()));
    });

    testWidgets('All pages should be accessed!!!', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Student()));
    });

    testWidgets('All pages should be accessed!!!', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Project_Board()));
    });

    testWidgets('All pages should be accessed!!!', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(HomePage()));
    });

    testWidgets('find widget by key', (WidgetTester tester) async {
      final key = Key('key');
      // await tester.pumpWidget(DynamicWidget(key: key, aboard: aboard));
      await tester.pumpWidget(MaterialApp(key: key, home: Container()));

      expect(find.byKey(key), findsOneWidget);
    });


  });



  group('Initialize',(){
    testWidgets('CreateBoard', (WidgetTester tester) async {
      HomePage testHomePage=new HomePage();
      User aUser = new User();
      aUser.email='Default@Students.wits.ac.za';
      aUser.password='123456';
      user.email='Default@Students.wits.ac.za';
      user.userTypeID=1;
      student.studentNo='1713445';
      personNo='1713445';
//      http.Client httpClient=new http.Client();
      http.Client httpClient=new MockClient();
      await tester.pumpWidget(makeWidgetTestable(testHomePage));
      final noBoardsView=find.byKey(Key('noBoardsView'));
      expect(noBoardsView, findsOneWidget);
      final plusButton=find.byKey(Key('plusButton'));
      expect(plusButton, findsOneWidget);
      final homeView =find.byKey(Key('HomeScaffold'));
      expect(homeView,findsOneWidget);

      await tester.tap(plusButton);
      var data={
        'UserTypeID' : 1.toString(),
        'StudentNo' : personNo.toLowerCase(),
        'StaffNo' : personNo.toLowerCase()
      };
      when(httpClient.post('http://10.100.15.38/ReadBoards.php',body: data))
          .thenAnswer((_) async => http.Response('[{"ProjectID":"55","Project_Title":"Default test board","Project_Description":"This board is a default board created for testing purposes. It should not be deleted.","Project_StartDate":null,"Project_EndDate":null,"BoardActive":"1","AccessLevelID":"4","AssignmentActive":"1"},{"ProjectID":"63","Project_Title":"Created by a sup","Project_Description":null,"Project_StartDate":null,"Project_EndDate":null,"BoardActive":"1","AccessLevelID":"1","AssignmentActive":"1"}]', 200));
      //expect(await testHomePage.initializeDisplay(httpClient),Future);
//      final createBoardAlert=find.byKey(Key('CreateBoardAlertAlert'));



      //testHomePage.initializeDisplay();

      final dynamicBoards=find.byKey(Key('dynamicText'));
      //expect(dynamicBoards,findsOneWidget);





      //expect(, findsOneWidget);
    });

  });



}