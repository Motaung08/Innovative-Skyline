import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';

void main() {
List<Project_Board> testBoards=[];
  Project_Board data =new Project_Board();
  data.Project_Title="Test Board created during testing";

group('CRUD Testing Student', (){
  test('Create board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.createBoard(data,1,'0930',url:"https://lamp.ms.wits.ac.za/~s1611821/createBoard.php"), "Board AND Association created!");
  });
  test('read board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.ReadBoards(1,'0930',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php"), isInstanceOf<List<Project_Board>>());
  });
  test('update board',() async{
    Project_BoardController projectController=new Project_BoardController();
    //testBoards=await projectController.ReadBoards(1,'0930',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    data.Project_Title="Updated Title";
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.updateBoard(data,url:"https://lamp.ms.wits.ac.za/~s1611821/updateBoard.php"), "Board updated successfully");
  });
  test('delete board',() async{
    Project_BoardController projectController=new Project_BoardController();
    //testBoards=await projectController.ReadBoards(1,'0930',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.deleteBoard(data.ProjectID,url:"https://lamp.ms.wits.ac.za/~s1611821/deleteBoard.php"), "Board DELETED!");
  });

});
group('CRUD Testing Supervisor', (){
  test('Create board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.createBoard(data,2,'A00',url:"https://lamp.ms.wits.ac.za/~s1611821/createBoard.php"), "Board AND Association created!");
  });
  test('read board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.ReadBoards(2,'A00',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php"), isInstanceOf<List<Project_Board>>());
  });
  test('update board',() async{
    Project_BoardController projectController=new Project_BoardController();
    //testBoards=await projectController.ReadBoards(2,'A00',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    data.Project_Title="Updated Title";
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.updateBoard(data,url:"https://lamp.ms.wits.ac.za/~s1611821/updateBoard.php"), "Board updated successfully");
  });
  test('delete board',() async{
    Project_BoardController projectController=new Project_BoardController();
    //testBoards=await projectController.ReadBoards(2,'A00',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.deleteBoard(data.ProjectID,url:"https://lamp.ms.wits.ac.za/~s1611821/deleteBoard.php"), "Board DELETED!");
  });

});
group('CRUD Testing Student with dates', (){
  data.Project_StartDate=DateTime.now();
  data.Project_EndDate=DateTime.now();
  test('Create board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.createBoard(data,2,'A00',url:"https://lamp.ms.wits.ac.za/~s1611821/createBoard.php"), "Board AND Association created!");
  });
  test('read board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.ReadBoards(2,'A00',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php"), isInstanceOf<List<Project_Board>>());
  });
  test('update board',() async{
    Project_BoardController projectController=new Project_BoardController();
    //testBoards=await projectController.ReadBoards(2,'A00',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    data.Project_Title="Updated Title";
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.updateBoard(data,url:"https://lamp.ms.wits.ac.za/~s1611821/updateBoard.php"), "Board updated successfully");
  });
  test('delete board',() async{
    Project_BoardController projectController=new Project_BoardController();
    //testBoards=await projectController.ReadBoards(2,'A00',url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.deleteBoard(data.ProjectID,url:"https://lamp.ms.wits.ac.za/~s1611821/deleteBoard.php"), "Board DELETED!");
  });

});




}