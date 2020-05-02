import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Model/PostGradType.dart';

class DegreeController extends StatefulWidget {

  static List<PostGradType> getDegree() {
    PostGradType A=new PostGradType();
    A.DegreeID=1;A.DegreeType='a';

    PostGradType B=new PostGradType();
    B.DegreeID=2;B.DegreeType='b';
    return <PostGradType>[A,B];
//    return <Degree>[
//      Degree(1, 'Honors-fulltime'),
//      Degree(2, 'Honors-partime'),
//      Degree(3, 'Masters-fulltime'), //Must change thid part to extract data from the server
//      Degree(4, 'Masters-partime'),
//    ];
  }



  @override
  _DegreeControllerState createState() => _DegreeControllerState();
}

class _DegreeControllerState extends State<DegreeController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
