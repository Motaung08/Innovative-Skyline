import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/main.dart';

Widget makeWidgetTestable(Widget widget) {
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle, child: widget),
  );
}

class MockClient extends Mock implements http.Client {}

void main() {
  group('All pages should be accessed!!!', () {
    testWidgets('All input feild and button widgets should be on screen',
        (WidgetTester tester) async {
//      Board board = new Board();
//      await tester.pumpWidget(makeWidgetTestable(board));
//      final iconEditBoard = find.byKey(Key("icon"));

//      expect(iconEditBoard, findsOneWidget);
//      await tester.press(iconEditBoard);
    });
    Board item = new Board();
    User user = new User();
    Project_Board testBoard = new Project_Board();

//    test('All inputs assigned values', () {
//      expect(item.key, null);
//      expect(item.proj_board, null);
//      expect(user.userTypeID, null);
//      //expect(user.studentNo, null);
//      expect(testBoard.Project_Title, null);
//      expect(testBoard.ProjectID, null);
//      expect(testBoard.Project_Description, null);
//      expect(testBoard.Project_StartDate, null);
//      expect(testBoard.Project_EndDate, null);
//      expect(testBoard.key, null);
//    });

//    test('getter and setter functions', () {
//      // user.studentNo= '1431795';
//      testBoard.Project_Title = 'SD_Project';
//      testBoard.ProjectID = 1;
//      testBoard.Project_Description = 'Software development';
////      testBoard.Project_StartDate=02052020 as DateTime;
////      testBoard.Project_EndDate = '30112020';
//      // ignore: unnecessary_statements
//      testBoard.key;
//
//      expect(testBoard.key, null);
//
//      //expect(user.studentNo, '1431795');
//      expect(testBoard.Project_Title, 'SD_Project');
//      expect(testBoard.ProjectID, 1);
//      expect(testBoard.Project_Description, 'Software development');
////      expect(testBoard.Project_StartDate,'02-05-2020');
////      expect(testBoard.Project_EndDate, '30-11-2020');
//    });


  });
  group('Initial board loading', (){
    Board testBoardPage = new Board();
    Project_Board tBoard =new Project_Board();
    testWidgets('Initialize', (WidgetTester tester) async {
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
      Project_BoardController project_boardController=new Project_BoardController();
      List allBoards=await project_boardController.ReadBoards(1, personNo, client);
      if(allBoards!=null){
        if(allBoards[0]!=null){
          user.boards=allBoards[0];
          tBoard=user.boards.where((element) => element.ProjectID==55).first;
          testBoardPage.proj_board = tBoard;
        }
        if(allBoards[1]!=0){
          user.archivedBoards=allBoards[1];
        }
      }


      data = {
        'ProjectID': tBoard.ProjectID.toString(),
      };
      when(client.post('http://10.100.15.38/ReadLists.php', body: data))
          .thenAnswer((_) async => http.Response(
              '[{"ListID":"5","ProjectID":"55","List_Title":"Default List!"},{"ListID":"6","ProjectID":"55","List_Title":"Test 2"},{"ListID":"256","ProjectID":"55","List_Title":"tbd"},{"ListID":"266","ProjectID":"55","List_Title":"new"},{"ListID":"268","ProjectID":"55","List_Title":"new"},{"ListID":"270","ProjectID":"55","List_Title":"3"},{"ListID":"271","ProjectID":"55","List_Title":"4"},{"ListID":"272","ProjectID":"55","List_Title":"b"}]'
      ,200));

       data={
        'ListID' : 5.toString(),
      };

      when(client.post('http://10.100.15.38/ReadTasks.php', body: data))
          .thenAnswer((_) async => http.Response(
        '[{"TaskID":"3","ListID":"5","Task_Title":"First Task associated test.","Task_Description":"This is one of the first tasks.","Task_AddedBy":"","Task_StatusID":"4","Task_Date_added":"2020-05-25 14:05:52","Task_Date_Due":"2020-05-25 00:00:00"},{"TaskID":"4","ListID":"5","Task_Title":"Length test task.","Task_Description":"","Task_AddedBy":"","Task_StatusID":"1","Task_Date_added":"2020-06-05 13:27:20","Task_Date_Due":null},{"TaskID":"299","ListID":"5","Task_Title":"abc","Task_Description":null,"Task_AddedBy":"1713445","Task_StatusID":"1","Task_Date_added":"2020-06-10 13:01:02","Task_Date_Due":null},{"TaskID":"300","ListID":"5","Task_Title":"d","Task_Description":null,"Task_AddedBy":"1713445","Task_StatusID":"3","Task_Date_added":"2020-06-05 13:32:38","Task_Date_Due":null},{"TaskID":"304","ListID":"5","Task_Title":"e","Task_Description":null,"Task_AddedBy":"1713445","Task_StatusID":"1","Task_Date_added":"2020-06-05 00:00:00","Task_Date_Due":null},{"TaskID":"305","ListID":"5","Task_Title":"f","Task_Description":null,"Task_AddedBy":"1713445","Task_StatusID":"1","Task_Date_added":"2020-06-05 00:00:00","Task_Date_Due":null},{"TaskID":"306","ListID":"5","Task_Title":"g","Task_Description":null,"Task_AddedBy":"1713445","Task_StatusID":"1","Task_Date_added":"2020-06-05 00:00:00","Task_Date_Due":null},{"TaskID":"307","ListID":"5","Task_Title":"e","Task_Description":null,"Task_AddedBy":"1713445","Task_StatusID":"1","Task_Date_added":"2020-06-05 00:00:00","Task_Date_Due":null}]'
         ,200));
      boardClient = client;
      await tester.pump();
//      print("Our project ID is ... "+testBoardPage.proj_board.ProjectID.toString());
      await testBoardPage.populateListDisplay(testBoardPage.proj_board.ProjectID, client);
      await tester.pumpWidget(makeWidgetTestable(testBoardPage));

      final plusButton = find.byKey(Key('plusButton'));
      expect(plusButton, findsOneWidget);
    });
  });
}
