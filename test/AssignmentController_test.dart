import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/AssignmentController.dart';
import 'package:postgrad_tracker/Controller/ListController.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:postgrad_tracker/counter.dart';
import 'package:postgrad_tracker/main.dart';


import 'Models_test.dart';

class MockAssignmentController extends AssignmentController implements Mock{
//  @override
//  String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
//    String fullString;
//    assert(() {
//      fullString = toDiagnosticsNode(style: DiagnosticsTreeStyle.singleLine).toString(minLevel: minLevel);
//      return true;
//    }());
//    return fullString ?? toStringShort();
//  }
}

Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle,child: widget),
  );
}


void main() {

  group("assignment", (){
    test('Assignment created for valid supervisor', () async {
      AssignmentController mockAssignmentController=new MockAssignmentController();


        String expectedResponse = "Association created!";
        //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
        expect(await mockAssignmentController.createAssignment(2, 'A00', 103, 1), expectedResponse);


    });
    test('Assignment read for valid supervisor', () async {
      AssignmentController mockAssignmentController=new MockAssignmentController();


      String expectedResponse = "Association created!";
      //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
      expect(await mockAssignmentController.ReadAssignment(2, 'A00', 103), isInstanceOf<List>());


    });
    test('Assignment deleted for valid supervisor', () async {
      AssignmentController mockAssignmentController=new MockAssignmentController();


      String expectedResponse = "Association created!";
      //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
      expect(await mockAssignmentController.DeleteAssignment(2, 'A00', 103), "Association DELETED!");


    });


  });

//  group('widgets', (){
//        testWidgets('test container', (
//        WidgetTester tester) async {
//      await tester.pumpWidget(makeWidgetTestable(ListController()));
//    });
//  });



}