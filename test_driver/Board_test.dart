import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Board.dart';



Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle,child: widget),
  );
}


void main(){
  group('All pages should be accessed!!!', ()
  {

    testWidgets('All input feild and button widgets should be on screen', (
        WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Board()));

    });
//      Board item = new Board();
//    User user = new User();
//    Project_Board testBoard = new Project_Board();
//
//    test('All inputs assigned values', (){
//
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
//
//    });
//
//    test('getter and setter functions', (){
//     // user.studentNo= '1431795';
//      testBoard.Project_Title = 'SD_Project';
//      testBoard.ProjectID=1;
//      testBoard.Project_Description='Software development';
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

}
