import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/SupervisorController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'package:postgrad_tracker/main.dart';

final List<DynamicWidget> listDynamic = [];

initializeDisplay() {
  listDynamic.clear();
  print('Initializing board display! ##################');
  for (int i = 0; i < user.boards.length; i++) {
    listDynamic.add(new DynamicWidget(aboard: user.boards[i]));
  }
}

class HomePage extends StatefulWidget {

  initializeDisplay() {
    listDynamic.clear();
    print('Initializing board display! ##################');
    for (int i = 0; i < user.boards.length; i++) {
      listDynamic.add(new DynamicWidget(aboard: user.boards[i]));
    }
  }
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  TextEditingController titleController = new TextEditingController();
  String boardTitle = "";

  //int userType=user.userTypeID;
  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Board title: "),
            content: TextField(
              controller: titleController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Create Board"),
                onPressed: () {
                  boardTitle = titleController.text;
                  //Navigator.of(context).pop(titleController.text.toString());
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Icon floatingIcon = new Icon(Icons.add);

  addDynamic(Project_Board givenBoard) {
    listDynamic.add(new DynamicWidget(aboard: givenBoard));
  }

  signout() {
    degrees.clear();
    studentTypes.clear();
    listDynamic.clear();

    User user = new User();
    supervisor = new Supervisor();
    student = new Student();
    //project_board=new Project_Board();
    studentController = new StudentController();
    supervisorController = new SupervisorController();
    userController = new UserController();
    //project_boardController=new Project_BoardController();
    Navigator.popAndPushNamed(context, '/Login');

//ProjectBoardView
    HomePage homePage = new HomePage();
  }

  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));
  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    final plusButton = new Container(
      alignment: Alignment.bottomRight,
      child: MaterialButton(
        onPressed: () {
          createAlertDialog(context).then((onValue) {
            if (boardTitle != "") {
              Project_Board project_board = new Project_Board();
              Project_BoardController project_boardController =
                  new Project_BoardController();
              project_board.Project_Title = boardTitle;
              project_boardController.createBoard(project_board);
              addDynamic(project_board);
              boardTitle = "";
              setState(() {});
            }
          });
        },
        color:
            //Colors.blueGrey
            Color(0xff009999),
        textColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      ),
    );

    final arrowImage = Image.asset("assets/downarrow.png");

    final noBoardsView = new Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          child: Text(
            "Click the + button below to create a board.",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
        ),
        arrowImage,
      ],
    );

    return Scaffold(
      //
      appBar: AppBar(
        title: Text("Innovative Skyline"),
        backgroundColor: Color(0xff009999),
      ),
      body: new Container(
        margin: new EdgeInsets.all(10.0),
//         // height: MediaQuery.of(context).size.height,
        child: new Column(
//
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              user.boards.isEmpty ? noBoardsView : dynamicTextField,
              plusButton,
            ]),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
              decoration: BoxDecoration(
                color: Color(0xff009999),
              ),
            ),
            ListTile(
              title: Text('View Profile',
                  style: TextStyle(
                      color: Color(0xff009999), fontWeight: FontWeight.bold)),
              onTap: () {
                print("USER SUPERVISOR: " + user.userTypeID.toString());
                if (user.userTypeID == 1) {
                  Navigator.popAndPushNamed(context, '/StudProfile');
                } else if (user.userTypeID == 2) {
                  supervisorController.GetSupDetails();
                  print('Navigate to View Supervisor Profile: ' +
                      supervisor.staffNo);
                  Navigator.popAndPushNamed(context, '/SupProfile');
                } else {
                  print('User type not recognized');
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title: Text('Sign Out',
                  style: TextStyle(
                      color: Color(0xff009999), fontWeight: FontWeight.bold)),
              onTap: () {
                signout();
              },
            ),
          ],
        ),
      ),
      //bottomNavigationBar: plusButton,
      //bottomSheet: plusButton,
    );
  }
}

class DynamicWidget extends StatefulWidget {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));
  //String giventitle='';
  Project_Board aboard;

  DynamicWidget({Key key, @required this.aboard}) : super(key: key);

  popLists() async {
    aboard.boardLists = await listController.ReadLists(aboard.ProjectID);
  }

  @override
  _DynamicWidgetState createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  @override
  Widget build(BuildContext context) {
    //widget.popLists();
    final buttonview = Container(
        margin: new EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(20)

        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new MaterialButton(
                  //elevation: 5.0,
                  //borderRadius: BorderRadius.circular(30.0),
                  //color: Colors.blueGrey,
                  //Color(0xff009999)

                  onPressed: () async {
                    await widget.popLists();
                    Board boardPage = new Board(
                      proj_board: widget.aboard,
                    );

                    await boardPage.populateListDisplay(widget.aboard.ProjectID);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => boardPage),
                    );
                  },
                  child: Text(
                    widget.aboard.Project_Title,
                    style: widget.style,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                )
              ],
            )


          ],
        ));
    Project_BoardController project_boardController=new Project_BoardController();
    final listReturn = new Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        title: Text(
          widget.aboard.Project_Title,
          style: widget.style,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete,color: Colors.black,),
          onPressed: ()async {
            int boardIndex;
            for (int j=0;j<user.boards.length;j++){
              if(user.boards[j].ProjectID==widget.aboard.ProjectID){
                boardIndex=j;
              }
            }
            await project_boardController.deleteBoard(widget.aboard.ProjectID);
            //await project_boardController.ReadBoards(user.userTypeID, personNo);
            //homePage=new HomePage();

            //
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (BuildContext context) => homePage),
//            );
            print("BOARD INDEX: "+boardIndex.toString());
            listDynamic.removeAt(boardIndex);
            user.boards.removeAt(boardIndex);
            homePage.initializeDisplay();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => homePage),
            );
            setState(() {

            });
          },
        ),
        onTap: () async {
          await widget.popLists();
          //aboard.boardLists = await listController.ReadLists(aboard.ProjectID);
          Board boardPage = new Board(
            proj_board: widget.aboard,
          );

          await boardPage.populateListDisplay(widget.aboard.ProjectID);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => boardPage),
          );
        },
      ),

    );

    return listReturn;
  }
}


//// ignore: must_be_immutable
//class DynamicWidget extends StatelessWidget {
//  TextStyle style = TextStyle(
//      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));
//  //String giventitle='';
//  Project_Board aboard;
//
//  DynamicWidget({Key key, @required this.aboard}) : super(key: key);
//
//  popLists() async {
//    aboard.boardLists = await listController.ReadLists(aboard.ProjectID);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    final buttonview = Container(
//        margin: new EdgeInsets.all(8.0),
//        decoration: BoxDecoration(
//            color: Colors.blueGrey,
//            borderRadius: BorderRadius.circular(20)
//
//        ),
//        child: Row(
//          mainAxisSize: MainAxisSize.max,
//          children: <Widget>[
//            Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                new MaterialButton(
//                  //elevation: 5.0,
//                  //borderRadius: BorderRadius.circular(30.0),
//                  //color: Colors.blueGrey,
//                  //Color(0xff009999)
//
//                  onPressed: () async {
//                    await popLists();
//                    Board boardPage = new Board(
//                      proj_board: aboard,
//                    );
//
//                    await boardPage.populateListDisplay(aboard.ProjectID);
//
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (BuildContext context) => boardPage),
//                    );
//                  },
//                  child: Text(
//                    aboard.Project_Title,
//                    style: style,
//                  ),
//                ),
//              ],
//            ),
//            Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                IconButton(
//                  icon: Icon(Icons.delete),
//                )
//              ],
//            )
//
//
//          ],
//        ));
//Project_BoardController project_boardController=new Project_BoardController();
//    final listReturn = new Container(
//      margin: EdgeInsets.all(8),
//      padding: EdgeInsets.all(8),
//      decoration: BoxDecoration(
//        color: Colors.blueGrey,
//        borderRadius: BorderRadius.circular(20)
//      ),
//      child: ListTile(
//        title: Text(
//          aboard.Project_Title,
//          style: style,
//        ),
//        trailing: IconButton(
//          icon: Icon(Icons.delete,color: Colors.black,),
//          onPressed: (){
//            project_boardController.deleteBoard(aboard.ProjectID);
//
//          },
//        ),
//        onTap: () async {
//          await popLists();
//          Board boardPage = new Board(
//            proj_board: aboard,
//          );
//
//          await boardPage.populateListDisplay(aboard.ProjectID);
//
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (BuildContext context) => boardPage),
//          );
//        },
//      ),
//
//    );
//
//    return listReturn;
//  }
//}
