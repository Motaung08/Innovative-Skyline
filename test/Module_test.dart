import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postgrad_tracker/Model/Assignment.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:postgrad_tracker/Model/PostGradType.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/Task.dart';
import 'package:postgrad_tracker/Model/TaskStatus.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/Model/UserType.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle,child: widget),
  );
}


void main() {
  group('All Models should be accessed', ()
  {
    testWidgets('Test Listcard', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(ListCard()));

    });

    testWidgets('Test Assignment', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Assignment()));
    });

    testWidgets('Test PostGradType', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(PostGradType()));
    });

    testWidgets('Test PostGradType', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Project_Board()));
    });

    testWidgets('Test PostGradType', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Student()));
    });

    testWidgets('Test PostGradType', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Supervisor()));
    });

    testWidgets('Test PostGradType', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Task()));
    });

    testWidgets('Test PostGradType', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(TaskStatus()));
    });

    testWidgets('Test PostGradType', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(User()));
    });

    testWidgets('Test PostGradType', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(UserType()));
    });


  });
}