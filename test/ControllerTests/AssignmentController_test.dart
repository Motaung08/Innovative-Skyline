import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/AssignmentController.dart';


class MockAssignmentController extends AssignmentController implements Mock{}

void main() {

  group("assignment", (){
    test('Assignment created for valid supervisor', () async {
      AssignmentController mockAssignmentController=new MockAssignmentController();


        String expectedResponse = "Association created!";
        //String unexpected = "";
        //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
        expect(await mockAssignmentController.createAssignment(2, 'A00', 103, 1), expectedResponse);


    });
    test('Assignment read for valid supervisor', () async {
      AssignmentController mockAssignmentController=new MockAssignmentController();


      //String expectedResponse = "Association created!";
      //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
      expect(await mockAssignmentController.ReadAssignment(2, 'A00', 103), isInstanceOf<List>());


    });
    test('Assignment deleted for valid supervisor', () async {
      AssignmentController mockAssignmentController=new MockAssignmentController();


      //String expectedResponse = "Association created!";
      //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
      expect(await mockAssignmentController.DeleteAssignment(2, 'A00', 103), "Association DELETED!");

    });


  });

}