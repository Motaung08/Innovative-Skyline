

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:postgrad_tracker/Controller/AssignmentController.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockAssignmentController extends AssignmentController implements Mock{
  @override
  String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    String fullString;
    assert(() {
      fullString = toDiagnosticsNode(style: DiagnosticsTreeStyle.singleLine).toString(minLevel: minLevel);
      return true;
    }());
    return fullString ?? toStringShort();
  }
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
//    test('Assignment created for valid student', () async {
//      AssignmentController assignmentController=new MockAssignmentController();
//      when(assignmentController.createAssignment(1, '1713445', 55, 1)).thenAnswer((_) => Future.value("Association created!"));
//
//    });
//    test('Assignment created for invalid super', () async {
//      AssignmentController assignmentController=new MockAssignmentController();
//      when(assignmentController.createAssignment(1, 'A', 55, 1)).thenAnswer((_) => Future.value("Connected but sql fail"));
//
//      //when(assignmentController.createAssignment(1, 'A', 55, 1)).thenAnswer((_) async => Future.value(false));
//
//    });
//    test('Assignment created for invalid user type', () async {
//      AssignmentController assignmentController=new MockAssignmentController();
//      when(assignmentController.createAssignment(3, 'A00', 55, 1)).thenAnswer((_) => Future.value("Connected but sql fail"));
//
//
//    });
//    test('Assignment created for invalid board', () async {
//      AssignmentController assignmentController=new MockAssignmentController();
//      when(assignmentController.createAssignment(1, 'A00', 0, 1)).thenAnswer((_) => Future.value("Connected but sql fail"));
//      //await assignmentController.createAssignment(2, 'A00', 55, 1);
//      //expect(await assignmentController.createAssignment(2, 'A00', 0, 1), "Connected but sql fail");
//
//
//    });
  });



}