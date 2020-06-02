import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/Assignment.dart';

class AssignmentController {
  Assignment assignment;

  /*
  The purpose of this method is to share a board. This is done by taking in the
  appropriate arguments to write to the Assignment table in the database -
  with special mention of who the board is being shared with as this will be
  used to load the board upon their logging in.
   */

  // ignore: non_constant_identifier_names
  Future<String> createAssignment(int OtherUserType, String OtherPersonNo, int ProjectID, int AccessID) async{
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/createAssignment.php';

    var data={
      'UserTypeID' : OtherUserType.toString(),
      'AssignPerson' : OtherPersonNo.toLowerCase(),
      'ProjectID' : ProjectID.toString(),
      'AccessLevelID' : AccessID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url,body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);

    return Response;


  }

  // ignore: non_constant_identifier_names
  Future<List> ReadAssignment(int UserType, String OtherPersonNo, int ProjectID) async{
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/ReadAssignment.php';

    var data={
      'UserTypeID' : UserType.toString(),
      'AssignPerson' : OtherPersonNo.toLowerCase(),
      'ProjectID' : ProjectID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url,body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);

    return Response;


  }

  // ignore: non_constant_identifier_names
  Future<String> DeleteAssignment(int UserType, String OtherPersonNo, int ProjectID) async{
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/DeleteAssignment.php';

    var data={
      'UserTypeID' : UserType.toString(),
      'AssignPerson' : OtherPersonNo.toLowerCase(),
      'ProjectID' : ProjectID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url,body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);

    return Response;


  }


}


