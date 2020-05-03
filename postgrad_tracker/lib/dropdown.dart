import 'package:flutter/material.dart';

void main()=> runApp(DropDown());

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class Degreetype {
  int id;
  String name;

  Degreetype(this.id, this.name);

  static List<Degreetype> getDegree() {
    return <Degreetype>[
      Degreetype(1, 'Honors-fulltime'),
      Degreetype(2, 'Honors-partime'),
      Degreetype(3, 'Masters-fulltime'), //Must change this part to extract data from the server
      Degreetype(4, 'Masters-partime'),
    ];
  }
}

class DropDownState extends State<DropDown> {
  //
  List<Degreetype> _degree = Degreetype.getDegree();
  List<DropdownMenuItem<Degreetype>> _dropdownMenuItems;
  Degreetype _selectedDegree;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_degree);
    _selectedDegree = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Degreetype>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Degreetype>> items = List();
    for (Degreetype degree in companies) {
      items.add(
        DropdownMenuItem(
          value: degree,
          child: Text(degree.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Degreetype selectedDegree) {
    setState(() {
      _selectedDegree = selectedDegree;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("DropDown Button Example"),
        ),
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Select Degree Type"),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  value: _selectedDegree,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Selected: ${_selectedDegree.name}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
