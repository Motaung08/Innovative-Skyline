import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Home.dart';
import 'package:postgrad_tracker/main.dart';
import '../ControllerTests/TaskController_test.dart';
import '../Models_test.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group('All pages should be accessed!!!', () {
    testWidgets('All input feild and button widgets should be on screen',
        (WidgetTester tester) async {
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

  group('Initialize', () {
    testWidgets('CreateBoard', (WidgetTester tester) async {
      HomePage testHomePage = new HomePage();
      User aUser = new User();
      aUser.email = 'Default@Students.wits.ac.za';
      aUser.password = '123456';
      user.email = 'Default@Students.wits.ac.za';
      user.userTypeID = 1;
      student.studentNo = '1713445';
      personNo = '1713445';
//      http.Client httpClient=new http.Client();
      http.Client httpClient = new MockClient();
      await tester.pumpWidget(makeWidgetTestable(testHomePage));
      final noBoardsView = find.byKey(Key('noBoardsView'));
      expect(noBoardsView, findsOneWidget);
      final plusButton = find.byKey(Key('plusButton'));
      expect(plusButton, findsOneWidget);

      final homeView = find.byKey(testHomePage.scaffoldKey);
      expect(homeView, findsOneWidget);

      var data = {
        'UserTypeID': 1.toString(),
        'StudentNo': personNo.toLowerCase(),
        'StaffNo': personNo.toLowerCase()
      };
      when(httpClient.post('http://10.100.15.38/ReadBoards.php', body: data))
          .thenAnswer((_) async => http.Response(
              '[{"ProjectID":"55","Project_Title":"Default test board","Project_Description":"This board is a default board created for testing purposes. It should not be deleted.","Project_StartDate":null,"Project_EndDate":null,"BoardActive":"1","AccessLevelID":"4","AssignmentActive":"1"},{"ProjectID":"63","Project_Title":"Created by a sup","Project_Description":null,"Project_StartDate":null,"Project_EndDate":null,"BoardActive":"1","AccessLevelID":"1","AssignmentActive":"1"}]',
              200));

       data = {
        'Project_Title': "Test Title",
        'Project_Description' : "",
        'Project_StartDate' : null,
        'Project_EndDate' : null,
        'StudentNo' : '123456789'.toLowerCase(),
        'StaffNo' : '123456789'.toLowerCase(),
        'userType' : 1.toString()
      };


      when(httpClient.post('http://10.100.15.38/createBoard.php', body: jsonEncode(data)))
          .thenAnswer((_) async => http.Response("Board AND Association created!",200));

      await testHomePage.initializeDisplay(httpClient);

      await tester.pumpWidget(makeWidgetTestable(testHomePage));

      final dynamicBoards = find.byKey(Key('DynamicView'));
//      expect(dynamicBoards,findsOneWidget);

      expect(testHomePage.isCreateOpen, false);
      await tester.tap(plusButton);
      await tester.pump();
      expect(testHomePage.isCreateOpen, true);

      final titleInout = find.byKey(Key('titleTextInput'));
      expect(titleInout, findsOneWidget);
      //

      final descripTextInput = find.byKey(Key('descripTextInput'));
      expect(descripTextInput, findsOneWidget);

      expect(testHomePage.startDate, isNull);
      final startDateInput = find.byKey(Key('startDateInput'));
      expect(startDateInput, findsOneWidget);
      await tester.tap(startDateInput);
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();
      expect(testHomePage.startDate, isNotNull);

      expect(testHomePage.endDate, isNull);
      final endDateInput = find.byKey(Key('endDateInput'));
      expect(endDateInput, findsOneWidget);
      await tester.tap(endDateInput);
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();
      expect(testHomePage.endDate, isNotNull);

      final createButton = find.byKey(Key('createBoardInput'));
      await tester.tap(createButton);
      await tester.pump();
      expect(find.text('Enter Board Title'), findsOneWidget);

      await tester.pump();
      await tester.enterText(titleInout, "Testing Board Title");
      await tester.pump();

      await tester.press(plusButton);


//      await tester.tap(createButton);
//      await tester.pump();
//      expect(find.text('Enter Board Title'), findsNothing);


    });

    testWidgets('View Profile', (WidgetTester tester) async {
      HomePage testHomePage = new HomePage();
      await tester.pumpWidget(makeWidgetTestable(testHomePage));

      final locateDrawer = find.byTooltip('Open navigation menu');
      expect(locateDrawer, findsOneWidget);

      await tester.tap(locateDrawer);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      user.userTypeID=1;
      final profile=find.byKey(Key('profileButton'));
      expect(profile, findsOneWidget);

      await tester.tap(profile);

    });

    testWidgets('View Archived', (WidgetTester tester) async {
      HomePage testHomePage = new HomePage();
      await tester.pumpWidget(makeWidgetTestable(testHomePage));

      final locateDrawer = find.byTooltip('Open navigation menu');
      expect(locateDrawer, findsOneWidget);

      await tester.tap(locateDrawer);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final archived=find.byKey(Key('archivedButton'));
      expect(archived, findsOneWidget);
      final client = new MockClient();
      personNo='1713445';
      var data = {
        'UserTypeID': 1.toString(),
        'StudentNo': personNo.toLowerCase(),
        'StaffNo': personNo.toLowerCase()
      };
      when(client.post('http://10.100.15.38/ReadBoards.php', body: data))
          .thenAnswer((_) async => http.Response(
          '[{"ProjectID":"55","Project_Title":"Default test board","Project_Description":"This board is a default board created for testing purposes. It should not be deleted.","Project_StartDate":null,"Project_EndDate":null,"BoardActive":"1","AccessLevelID":"4","AssignmentActive":"1"},{"ProjectID":"63","Project_Title":"Created by a sup","Project_Description":null,"Project_StartDate":null,"Project_EndDate":null,"BoardActive":"1","AccessLevelID":"1","AssignmentActive":"1"},{"ProjectID":"707","Project_Title":"a","Project_Description":"","Project_StartDate":null,"Project_EndDate":null,"BoardActive":"1","AccessLevelID":"4","AssignmentActive":"1"},{"ProjectID":"708","Project_Title":"b","Project_Description":"","Project_StartDate":null,"Project_EndDate":null,"BoardActive":"1","AccessLevelID":"4","AssignmentActive":"0"}]'
          ,200));
      createClient=client;
      await tester.tap(archived);

    });

    testWidgets('Sign out', (WidgetTester tester) async {
            HomePage testHomePage = new HomePage();
      await tester.pumpWidget(makeWidgetTestable(testHomePage));

      final locateDrawer = find.byTooltip('Open navigation menu');
      expect(locateDrawer, findsOneWidget);

      await tester.tap(locateDrawer);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final signOut=find.byKey(Key('signOutDrawerButton'));
      expect(signOut, findsOneWidget);

      await tester.tap(signOut);

      expect(degrees, isEmpty);
      expect(studentTypes, isEmpty);
      expect(listDynamic, isEmpty );
      expect(user.email, isNull);
      expect(supervisor.email , isNull);
      expect(student.email , isNull);
      expect(homePage.startDate,isNull );


    });

  });
}
