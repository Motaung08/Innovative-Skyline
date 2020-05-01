import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';


class HomePage extends StatefulWidget {

 final  List<DynamicWidget> listDynamic = [];

  initializeDisplay(){
    print('Initializing board display! ##################');
    for(int i=0;i<boards.length;i++){
      listDynamic.add(new DynamicWidget(giventitle: boards[i].Project_Title));
    }

  }

  @override
  _MyHomePageState createState() => _MyHomePageState();


}

class _MyHomePageState extends State<HomePage> {
  TextEditingController titleController = new TextEditingController();
//  List<DynamicWidget> listDynamic = [];


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

                  //Board board = new Board();
                  //print('Title: '+ board.title);

                 // project_boardController.createBoard(titleController.text);

                  //board.createBoard();

                  Navigator.of(context).pop(titleController.text.toString());

                  //addDynamic(titleController.text.toString());
                  //Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Icon floatingIcon = new Icon(Icons.add);

  addDynamic(String Title) {
    widget.listDynamic.add(new DynamicWidget(giventitle: Title));

  }

//  submitData() {
//    floatingIcon = new Icon(Icons.arrow_back);
//    data = [];
//    listDynamic.forEach((widget) => data.add("ello"));
//    //setState(() {});
//    print(data.length);
//  }

  signout(){
    boards.clear();
    widget.listDynamic.clear();
    Navigator.popAndPushNamed(context, '/Login');
    
    //NOTE!!! more will need to be done here.
  }



  @override
  Widget build(BuildContext context) {

//    setState(() {
//
//    });
    print('=============== I am refreshed! ========================');
   // initialize();
    Widget result = new Flexible(
        flex: 1,
        child: new Card(
          child: ListView.builder(
            itemCount: widget.listDynamic.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                    new Container(
//                      margin: new EdgeInsets.only(left: 10.0),
//                      child: new Text("${index + 1} : ${data[index]}"),
//                      //child: new DynamicWidget(giventitle: "test rabbits"),
//                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));

    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: widget.listDynamic.length,
        itemBuilder: (_, index) => widget.listDynamic[index],
      ),
    );

    return Scaffold(

        appBar: AppBar(
          title: Text("Innovative Skyline"),
          backgroundColor: Color(0xff009999),
        ),
        body: new Container(
          margin: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              dynamicTextField,
              //1 == 0 ? result : dynamicTextField,
              // data.length == 0 ? submitButton : new Container(),

              FlatButton(
                onPressed: () {

                  createAlertDialog(context).then((onValue){
                    addDynamic('testt');
                    setState(() {

                    });
                  });

                  //print("New board click");
//                  createAlertDialog(context).then((onValue) {
//                    if("$onValue"!='null'){
//                      addDynamic("$onValue");
//                      setState(() {});
//                    }
//
//                  });
                },
                color: Colors.blue,
                padding: EdgeInsets.all(30),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    Text(
                      "  Create new board",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
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

                  if (user.userTypeID == 1) {
                    Navigator.popAndPushNamed(context, '/StudProfile');
                  } else if (user.userTypeID == 2) {
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
        ));
  }
}


class DynamicWidget extends StatelessWidget {
  String giventitle='';

  DynamicWidget({Key key, @required this.giventitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.all(8.0),
      child: new MaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Board');
        },
        color: Colors.blue,
        child: Text(giventitle),
      ),
    );
  }
}


