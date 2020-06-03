import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/AssignmentController.dart';


class MockAssignmentController extends Mock implements AssignmentController{
  Future<String> call();
}

void main() {

  group("assignment", (){
    test('Assignment created for valid supervisor', () async {
      AssignmentController assignmentController=new AssignmentController();
      AssignmentController mockAssignmentController= new MockAssignmentController();




//      expect(await mockAssignmentController.createAssignment(2, "A00", 103, 1), "fail");

        String expectedResponse = "Association created!";
        expect(await assignmentController.createAssignment(2, 'A00', 103, 1), expectedResponse);



    });
    test('Assignment read for valid supervisor', () async {
      AssignmentController assignmentController=new AssignmentController();


      //String expectedResponse = "Association created!";
      //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
      expect(await assignmentController.ReadAssignment(2, 'A00', 103), isInstanceOf<List>());


    });
    test('Assignment deleted for valid supervisor', () async {
      AssignmentController assignmentController=new AssignmentController();


      //String expectedResponse = "Association created!";
      //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
      expect(await assignmentController.DeleteAssignment(2, 'A00', 103), "Association DELETED!");

    });


  });

}