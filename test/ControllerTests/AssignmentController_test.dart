import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/AssignmentController.dart';
import 'package:postgrad_tracker/Model/Assignment.dart';


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
        expect(await assignmentController.createAssignment(2, 'A00', 103, 1,
            url:"https://lamp.ms.wits.ac.za/~s1611821/createAssignment.php"), expectedResponse);

    });
    test('Assignment read for valid supervisor', () async {
      AssignmentController assignmentController=new AssignmentController();


      //String expectedResponse = "Association created!";
      //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
      expect(await assignmentController.ReadAssignment(2, 'A00', 103,
          url:"https://lamp.ms.wits.ac.za/~s1611821/ReadAssignment.php"), isInstanceOf<List>());


    });
    test("function call",() async {
      AssignmentController assignmentController=new AssignmentController();
      List testOut = await assignmentController.ReadBoardAssignments(103,url:'https://lamp.ms.wits.ac.za/~s1611821/ReadBoardAssignments.php',url2: "https://lamp.ms.wits.ac.za/~s1611821/viewStudentStudNo.php",url3: "https://lamp.ms.wits.ac.za/~s1611821/viewSupStaffNo.php");
      expect(testOut,isNotEmpty);
    });


//    test('ReadBoards Assignment', () async {
//      AssignmentController assignmentController = new AssignmentController();
//
//      expect(await assignmentController.ReadBoardAssignments(2,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoardAssignments.php"),
//      isInstanceOf<List>());
//    });


//    test('Shared Boards', () async{
//      AssignmentController sharedBoards = new AssignmentController();
////      sharedBoards.
//      expect(await sharedBoards.ReadBoardAssignments(2,url: "https://lamp.ms.wits.ac.za/~s1611821/ReadBoardAssignments.php"), 'Board shared! ');
//
//    });

    test('Assignment deleted for valid supervisor', () async {
      AssignmentController assignmentController=new AssignmentController();

      //String expectedResponse = "Association created!";
      //when(mockAssignmentController.createAssignment(2, 'A00', 55, 1)).thenAnswer((_) async => expectedResponse);
      expect(await assignmentController.DeleteAssignment(2, 'A00', 103,
          url:"https://lamp.ms.wits.ac.za/~s1611821/DeleteAssignment.php"), "Association DELETED!");

    });




  });

  group("Rad Board assignments",(){

  });

}