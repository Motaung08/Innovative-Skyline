import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client{}

void main() {
List<Project_Board> testBoards=[];
  Project_Board data =new Project_Board();
  data.Project_Title="Test Board created during testing";
http.Client client=new http.Client();
//http.Client client=new MockClient();
group('CRUD Testing Student', (){
  test('Create board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.createBoard(data,1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/createBoard.php"), "Board AND Association created!");
  });
  test('Create board',() async{
    Project_BoardController projectController=new Project_BoardController();
    Project_Board project_board=new Project_Board();
    project_board.Project_Title="Board in testing for archiving";
    expect(await projectController.createBoard(project_board,1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/createBoard.php"), "Board AND Association created!");
  });
  test('read board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.ReadBoards(1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php"), isInstanceOf<List<List<Project_Board>>>());
  });
  test('update board',() async{
    Project_BoardController projectController=new Project_BoardController();
    List allBoards=await projectController.ReadBoards(1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    testBoards=allBoards[0];
    data.Project_Title="Updated Title";
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.updateBoard(data,url:"https://lamp.ms.wits.ac.za/~s1611821/updateBoard.php"), "Board updated successfully");
  });
  test('archive board',() async{
    Project_BoardController projectController=new Project_BoardController();
    List allBoards=await projectController.ReadBoards(1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    testBoards=allBoards[0];
    Project_Board pb=new Project_Board();
    pb=testBoards.last;
    pb.boardActive=false;
    //pb.boardAssignActive=false;
    expect(await projectController.archiveBoard(pb.ProjectID,false,url:"https://lamp.ms.wits.ac.za/~s1611821/ArchiveBoard.php"), "Updated BoardActive");
  });
  test('read board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.ReadBoards(1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php"), isInstanceOf<List<List<Project_Board>>>());
  });
  test('archive assignment',() async{
    Project_BoardController projectController=new Project_BoardController();
    List allBoards=await projectController.ReadBoards(1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    testBoards=allBoards[0];
    Project_Board pb=new Project_Board();
    pb=testBoards.last;
    //pb.boardActive=false;
    pb.boardAssignActive=false;
    expect(await projectController.archiveAssignment(1,'0930',pb.ProjectID,false,url:"https://lamp.ms.wits.ac.za/~s1611821/ArchiveAssignment.php"), "Updated AssignmentActive");
  });
  test('read board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.ReadBoards(1,'0930',client, url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php"), isInstanceOf<List<List<Project_Board>>>());
  });
  test('delete board',() async{
    Project_BoardController projectController=new Project_BoardController();
    List allBoards=await projectController.ReadBoards(1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    testBoards=allBoards[0];
    data.ProjectID=testBoards.last.ProjectID;
    List arch=allBoards[1];
    Project_Board archCreated=arch.last;
    expect(await projectController.deleteBoard(data.ProjectID,client,url:"https://lamp.ms.wits.ac.za/~s1611821/deleteBoard.php"), "Board DELETED!");
    expect(await projectController.deleteBoard(archCreated.ProjectID,client,url:"https://lamp.ms.wits.ac.za/~s1611821/deleteBoard.php"), "Board DELETED!");
  });

});
group('CRUD Testing Supervisor', (){
  test('Create board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.createBoard(data,2,'A00',client,url:"https://lamp.ms.wits.ac.za/~s1611821/createBoard.php"), "Board AND Association created!");
  });
  test('read board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.ReadBoards(2,'A00',client, url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php"), isInstanceOf<List<List<Project_Board>>>());
  });
  test('update board',() async{
    Project_BoardController projectController=new Project_BoardController();
    List allBoards=await projectController.ReadBoards(2,'A00',client, url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    testBoards=allBoards[0];
    data.Project_Title="Updated Title";
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.updateBoard(data,url:"https://lamp.ms.wits.ac.za/~s1611821/updateBoard.php"), "Board updated successfully");
  });
  test('delete board',() async{
    Project_BoardController projectController=new Project_BoardController();
    List allBoards=await projectController.ReadBoards(2,'A00',client, url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    testBoards=allBoards[0];
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.deleteBoard(data.ProjectID,client,url:"https://lamp.ms.wits.ac.za/~s1611821/deleteBoard.php"), "Board DELETED!");
  });

});
group('CRUD Testing Student with dates', (){
  data.Project_StartDate=DateTime.now();
  data.Project_EndDate=DateTime.now();
  test('Create board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.createBoard(data,1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/createBoard.php"), "Board AND Association created!");
  });
  test('read board',() async{
    Project_BoardController projectController=new Project_BoardController();
    expect(await projectController.ReadBoards(1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php"), isInstanceOf<List<List<Project_Board>>>());
  });
  test('update board',() async{
    Project_BoardController projectController=new Project_BoardController();
    List allBoards=await projectController.ReadBoards(1,'0930',client,url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");
    testBoards=allBoards[0];
    data.Project_Title="Updated Title";
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.updateBoard(data,url:"https://lamp.ms.wits.ac.za/~s1611821/updateBoard.php"), "Board updated successfully");
  });

  test('delete board',() async{
    Project_BoardController projectController=new Project_BoardController();
    List allBoards=await projectController.ReadBoards(1,'0930',client, url:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");;
    testBoards=allBoards[0];
    data.ProjectID=testBoards.last.ProjectID;
    expect(await projectController.deleteBoard(data.ProjectID,client,url:"https://lamp.ms.wits.ac.za/~s1611821/deleteBoard.php"), "Board DELETED!");
  });

});




}