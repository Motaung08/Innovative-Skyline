import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/View/Board.dart';


void main(){

  Project_Board item = new Project_Board();
  Board proj_board= new Board();

  group('Board tags', () {
    test('all fields should be null', (){
      expect(item.ProjectID, null);
      expect(item.Project_Title, null);
      expect(item.Project_Description, null);
      expect(item.Project_StartDate, null);
      expect(item.Project_EndDate, null);
      expect(proj_board.key, null);
    });

    test('ProjectID should be assigned a value', () {
      item.ProjectID= 1;
      expect(item.ProjectID, 1);
    });

    test('ProjectTitle', (){
      item.Project_Title= "Software Design";
      expect(item.Project_Title,"Software Design");
    });

    test('Project Description', () {
      item.Project_Description = "Build Application";
      expect(item.Project_Description, "Build Application");
    });

//     test('Project Start Date', () {
//       item.Project_StartDate= "02-02-2007" as DateTime;
//       expect(item.Project_StartDate, "02-02-2007");
//     });

//     test('Project End Date', () {
//       item.Project_EndDate = "30-11-2007" as DateTime;
//       expect(item.Project_EndDate, "30-11-2007");
//     });

    test('Project Board', (){
      proj_board.key;
    });
  });
}


