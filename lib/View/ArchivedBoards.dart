import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'package:postgrad_tracker/View/Home.dart';
import 'package:postgrad_tracker/View/Login.dart';
import 'package:postgrad_tracker/View/profile/student/ViewStudentProfile.dart';
import 'package:postgrad_tracker/View/profile/supervisor/ViewSupProfile.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

final List<DynamicWidget> listArchDynamic = new List<DynamicWidget>();
bool _isDeleted;
http.Client archiveClient=new http.Client();

class ArchivedBoards extends StatefulWidget {
  Future<void> initialize(http.Client client) async {
    Project_BoardController projectBoardController =
        new Project_BoardController();
    List<List<Project_Board>> allBoards =
        await projectBoardController.ReadBoards(
            user.userTypeID, personNo, client);
    if (allBoards.isEmpty == false) {
      if (allBoards[0] != null) {
        user.boards = allBoards[0];
      }
      if (allBoards[1] != null) {
        user.archivedBoards = allBoards[1];
      }
    }
  }

  Future<void> initializeDisplay(http.Client client) async {
    await initialize(client);
    listArchDynamic.clear();
    if (user.archivedBoards != null) {
      if (user.archivedBoards.length == 0) {
        _isDeleted = true;
      } else {
        for (int i = 0; i < user.archivedBoards.length; i++) {
//          print("Board ID: " +
//              user.archivedBoards[i].ProjectID.toString() +
//              ", Title: " +
//              user.archivedBoards[i].Project_Title);
          listArchDynamic
              .add(new DynamicWidget(aboard: user.archivedBoards[i]));
        }
      }
    } else {
      _isDeleted = true;
    }
  }

  @override
  _ArchivedBoardsPageState createState() => _ArchivedBoardsPageState();
}

class _ArchivedBoardsPageState extends State<ArchivedBoards> {
  String boardTitle = "";
  final format = DateFormat("yyyy-MM-dd");
  String startDateInput = "Select date ...";
  String endDateInput = "Select date ...";
  TextStyle dateStyle = TextStyle(
      color: Colors.black.withOpacity(0.65), fontFamily: 'Montserrat');

  signOut() {
    degrees.clear();
    studentTypes.clear();
    listArchDynamic.clear();

    user = new User();
    supervisor = new Supervisor();
    student = new Student();
    homePage = new HomePage();

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
//    Navigator.popAndPushNamed(context, '/Login');
  }

  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));
  bool _viewArchived = false;
  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = new Container(
      alignment: Alignment.center,
      margin: new EdgeInsets.all(10.0),
      //height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: listArchDynamic.length,
        itemBuilder: (_, index) => listArchDynamic[index],
      ),
    );

    final noBoardsView = new Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      key: Key('noBoardsView'),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisSize: MainAxisSize.max,

        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            alignment: Alignment.bottomCenter,
            child: Text(
              "No archived boards.",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
    bool archempty = false;
    // if(user.archivedBoards=null)

    return Scaffold(
      key: Key('archScaffold'),
      appBar: AppBar(
        title: Text("Archived Boards"),
        backgroundColor: Color(0xff009999),
      ),
      body: new Container(
        alignment: Alignment.center,
        margin: new EdgeInsets.all(10.0),
        child: (user.archivedBoards == null)
            ? noBoardsView
            : (user.archivedBoards.length == 0)
                ? noBoardsView
                : dynamicTextField,
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
                  key: Key('profileButton'),
                  style: TextStyle(
                      color: Color(0xff009999), fontWeight: FontWeight.bold)),
              onTap: () {
                if (user.userTypeID == 1) {
                  //Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewStudentProfilePage()),
                  );
                  //Navigator.popAndPushNamed(context, '/StudProfile');
                } else if (user.userTypeID == 2) {
                  //Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewSupProfilePage()),
                  );
                } else {
                  print('User type not recognized');
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              key: Key('ActiveBoardsInput'),
              title: Text('Active Boards',
                  style: TextStyle(
                      color: Color(0xff009999), fontWeight: FontWeight.bold)),
              onTap: () async {
                print("Active boards");
//                http.Client client = new http.Client();
                await homePage.initializeDisplay(archiveClient);
                setState(() {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homePage),
                  );
                });
              },
            ),
            ListTile(
              key: Key('signOutDrawerButton'),
              title: Text('Sign Out',
                  style: TextStyle(
                      color: Color(0xff009999), fontWeight: FontWeight.bold)),
              onTap: () {
                signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DynamicWidget extends StatefulWidget {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));
  //String giventitle='';
  Project_Board aboard;

  DynamicWidget({Key key, @required this.aboard}) : super(key: key);

  popLists() async {
    aboard.boardLists = await listController.ReadLists(aboard.ProjectID,archiveClient);
  }

  @override
  _DynamicWidgetState createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  // ignore: missing_return
  int getBoardIndex(int boardID) {
    for (int i = 0; i < user.archivedBoards.length; i++) {
      if (user.archivedBoards[i].ProjectID == boardID) {
        return i;
      }
    }
  }

  bool _isShareDisabled = false;
  bool _isEditDisabled = false;
  determineAccess() {
    Project_Board pb =
        user.archivedBoards[getBoardIndex(widget.aboard.ProjectID)];
    if (pb.AccessLevel == null || pb.AccessLevel == 1) {
      //Full admin
      _isShareDisabled = false;
      _isEditDisabled = false;
    } else if (pb.AccessLevel == 2) {
      //Can edit but not share
      _isShareDisabled = true;
      _isEditDisabled = false;
    } else if (pb.AccessLevel == 3) {
      //Can only view
      _isShareDisabled = true;
      _isEditDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //determineAccess();
    //widget.popLists();
    Project_BoardController projectBoardController =
        new Project_BoardController();
    TextEditingController descriptionController = new TextEditingController();
    // ignore: non_constant_identifier_names
    final Edit_formKey = GlobalKey<FormState>();
    //int userType=user.userTypeID;

    DateTime _startDate;
    DateTime _endDate;

    TextStyle datestyle = TextStyle(
        color: Colors.black.withOpacity(0.65), fontFamily: 'Montserrat');

    Future<String> confirmDeleteAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "CONFIRM DELETE ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              content: Text(
                "Are you sure you want to delete this board?",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    int boardIndex;
                    for (int j = 0; j < user.archivedBoards.length; j++) {
                      if (user.archivedBoards[j].ProjectID ==
                          widget.aboard.ProjectID) {
                        boardIndex = j;
                      }
                    }
                    await projectBoardController
                        .deleteBoard(widget.aboard.ProjectID,archiveClient);

                    listArchDynamic.removeAt(boardIndex);
                    http.Client client = new http.Client();
                    homePage.initializeDisplay(client);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => homePage),
                    );
                    setState(() {});
                  },
                ),
                MaterialButton(
                  elevation: 5.0,
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

    final listReturn = kIsWeb == false
        ? new Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              title: Text(
                widget.aboard.Project_Title,
                style: widget.style,
              ),
//        trailing: PopupMenuButton(
//          itemBuilder: ,
//
//        ),
              onTap: () async {
//          print("BOARD: "+widget.aboard.ProjectID.toString());
                await widget.popLists();

                Board boardPage = new Board();
                boardPage.proj_board = widget.aboard;

                await boardPage.populateListDisplay(widget.aboard.ProjectID,archiveClient);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => boardPage),
                );
              },
            ),
          )
        : Row(
            children: [
              Expanded(flex: 1, child: Text("")),
              Expanded(
                  flex: 5,
                  child: new Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text(
                        widget.aboard.Project_Title,
                        style: widget.style,
                      ),
                      //trailing: PopupMenuButton(),
                      onTap: () async {
                        print("BOARD: " + widget.aboard.ProjectID.toString());
                        await widget.popLists();
                        print("LISTS IS NULL: " +
                            (widget.aboard.boardLists == null).toString());
                        //aboard.boardLists = await listController.ReadLists(aboard.ProjectID);
                        Board boardPage = new Board(
                          proj_board: widget.aboard,
                        );
                        await boardPage
                            .populateListDisplay(widget.aboard.ProjectID,archiveClient);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => boardPage),
                        );
                      },
                    ),
                  )),
              Expanded(flex: 1, child: Text(""))
            ],
          );

    return listReturn;
  }
}
