import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Login.dart';
import 'package:postgrad_tracker/ViewStudentProfile.dart';

class HomePage extends StatelessWidget {
  //HomePage({Key key, this.title}) : super(key: key);
  final String email;
  final int userType;
  HomePage({this.email, this.userType});

//  List<DynamicWidget> listDynamic = [];
//  List<String> data = [];
//
//  Icon floatingIcon = new Icon(Icons.add);
//
//  addDynamic() {
//    if (data.length != 0) {
//      floatingIcon = new Icon(Icons.add);
//
//      data = [];
//      listDynamic = [];
//      print('if');
//    }
//    setState(() {});
//    if (listDynamic.length >= 5) {
//      return;
//    }
//    listDynamic.add(new DynamicWidget());
//  }
//
//  submitData() {
//    floatingIcon = new Icon(Icons.arrow_back);
//    data = [];
//    listDynamic.forEach((widget) => data.add(widget.controller.text));
//    setState(() {});
//    print(data.length);
//  }




  @override

  Widget build(BuildContext context) {

    final ViewProfileButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {


          },
        child: Text("View Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );



    Widget _divider() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            Text('or'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
          //automaticallyImplyLeading: false,
        title: Text("Innovative Skyline"),
        backgroundColor: Color(0xff009999),
      ),

      body: Center(
          child: Row(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //BackButton(),

                ],
              ),
            ),
          ),
        ],
      )),
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
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0)),
                decoration: BoxDecoration(
                  color: Color(0xff009999),
                ),
              ),
              ListTile(
                title: Text(
                    'View Profile',
                    style: TextStyle(
                        color: Color(0xff009999), fontWeight: FontWeight.bold)
                ),
                onTap: () {
                  if(userType==1 || userType==2){
                    Navigator.pushNamed(context, '/StudProfile');
                  } else if (userType==3){
                    Navigator.pushNamed(context, '/SupProfile');
                  }else{
                    print('User type not recognized');
                    Navigator.pop(context);
                  }

                },
              ),
              ListTile(
                title: Text(
                    'Sign Out',
                    style: TextStyle(
                        color: Color(0xff009999), fontWeight: FontWeight.bold)
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context,'/');
                },
              ),
            ],
          ),
        )
    );
  }
}
