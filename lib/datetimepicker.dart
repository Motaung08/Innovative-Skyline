import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(
      home: MyHomePage()));}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  DateTime _date = new DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2000),
        lastDate: new DateTime(2030)
    );

    if(picked != null && picked != _date){
      print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar( title: new Text('Name Here'),),

      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
            new Text('Date Selected: ${_date.toString()}'),

            new RaisedButton(
                child: new Text('Select Date'),
                onPressed: (){selectDate(context);}
              )
          ],

        ),
      ),

    );
  }
}
