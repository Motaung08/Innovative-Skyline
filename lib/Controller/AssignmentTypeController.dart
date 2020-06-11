import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/AssignmentType.dart';
import 'package:postgrad_tracker/main.dart';

class AssignmentTypeController {
  /*
  This method should retrieve the different assignment types so that
  upon sharing of a board, a user may select from a pre-populated list.
   */
  Future getTypes({url='http://10.100.15.38/getAssignmentTypes.php'}) async{
    //print('I am called');
//    final response = await http.post("http://146.141.21.17/getStudentTypes.php");
    final response = await http.post(
       // "https://witsinnovativeskyline.000webhostapp.com/getAssignmentTypes.php"
      url
    );

    //print('Assigning title for '+student.studentTypeID.toString());

    var result = json.decode(response.body);
    assignmentTypes.clear();
    for (int i=0; i<result.length;i++){
      AssignmentType assignmentType = new AssignmentType();
      assignmentType.assignmentTypeID =int.parse(result[i]['AssignmentTypeID']);
      assignmentType.assignmentTypeText=result[i]['AssignmentType'];
      assignmentTypes.add(assignmentType);
      //print(assignmentType.assignmentTypeText);
    }


  }
}