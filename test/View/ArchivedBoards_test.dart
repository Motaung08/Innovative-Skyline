import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/ArchivedBoards.dart';
import 'package:postgrad_tracker/View/Home.dart';
import 'package:postgrad_tracker/main.dart';
import '../Models_test.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group('All pages should be accessed!!!', () {
    testWidgets('All input feild and button widgets should be on screen',
            (WidgetTester tester) async {
          await tester.pumpWidget(makeWidgetTestable(ArchivedBoards()));
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
    testWidgets('Archive', (WidgetTester tester) async {
      ArchivedBoards archivedBoards = new ArchivedBoards();
      User aUser = new User();
      aUser.email = 'Default@Students.wits.ac.za';
      aUser.password = '123456';
      user.email = 'Default@Students.wits.ac.za';
      user.userTypeID = 1;
      student.studentNo = '1713445';
      personNo = '1713445';
//      http.Client httpClient=new http.Client();
      http.Client httpClient = new MockClient();
      await tester.pumpWidget(makeWidgetTestable(archivedBoards));
      final noBoardsView = find.byKey(Key('noBoardsView'));
      expect(noBoardsView, findsOneWidget);

      final homeView = find.byKey(Key('archScaffold'));
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

      await archivedBoards.initializeDisplay(httpClient);

      await tester.pumpWidget(makeWidgetTestable(archivedBoards));



    });

    testWidgets('View Profile', (WidgetTester tester) async {
      ArchivedBoards archivedBoards = new ArchivedBoards();
      await tester.pumpWidget(makeWidgetTestable(archivedBoards));

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
      ArchivedBoards archivedBoards = new ArchivedBoards();
      await tester.pumpWidget(makeWidgetTestable(archivedBoards));

      final locateDrawer = find.byTooltip('Open navigation menu');
      expect(locateDrawer, findsOneWidget);

      await tester.tap(locateDrawer);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final active=find.byKey(Key('ActiveBoardsInput'));
      expect(active, findsOneWidget);

      await tester.tap(active);

    });

    testWidgets('Sign out', (WidgetTester tester) async {
      ArchivedBoards archivedBoards = new ArchivedBoards();
      await tester.pumpWidget(makeWidgetTestable(archivedBoards));

      final locateDrawer = find.byTooltip('Open navigation menu');
      expect(locateDrawer, findsOneWidget);

      await tester.tap(locateDrawer);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      final signOut=find.byKey(Key('signOutDrawerButton'));
      expect(signOut, findsOneWidget);

      await tester.tap(signOut);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();

      expect(degrees, isEmpty);
      expect(studentTypes, isEmpty);
      expect(listArchDynamic, isEmpty );
      expect(user.email, isNull);
      expect(supervisor.email , isNull);
      expect(student.email , isNull);
      expect(homePage.startDate,isNull );


    });

  });
}
