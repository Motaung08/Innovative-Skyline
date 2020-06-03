import 'dart:convert';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/main.dart';

class SupervisorController{

  /*
  The purpose of this method is to retrieve the Supervisor instance associated
  with the given email address and assign the instance attributes to a new
  Supervisor object which is subsequently returned.
   */
  Future<Supervisor> fetchSup(String email) async {
    Supervisor fetchedSup=new Supervisor();
    String msg='';
    final response = await http.post(
       "http://10.100.15.38/viewSupProfile.php",
//        "https://witsinnovativeskyline.000webhostapp.com/viewSupProfile.php",
        body: {
          "Email": email.toLowerCase(),
        });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      msg='No supervisor';
    } else {
      msg='Found supervisor.';
      fetchedSup.staffNo = datauser[0]['StaffNo'];
      fetchedSup.fName = datauser[0]['Supervisor_Firstname'];
      fetchedSup.lName = datauser[0]['Supervisor_Lastname'];
      fetchedSup.email=datauser[0]['Supervisor_Email'];
      fetchedSup.office=datauser[0]['Supervisor_OfficePhone'];
    }
    print(msg);

    return fetchedSup;
  }

  /*
  The purpose of this method is to set the user as a supervisor and load their
  supervisor attributes as well as loading the boards which are associated with
  said user/supervisor.
   */
  Future setUserSup(String email)async{
    supervisor=await fetchSup(email);
    personNo=supervisor.staffNo;
    Project_BoardController projectBoardController=new Project_BoardController();
    user.boards=await projectBoardController.ReadBoards(user.userTypeID,supervisor.staffNo);
  }

  /*
    The purpose of this method is to take in a supervisor object and a user
    object (created when the user selects register under the supervisor
    registration page) and subsequently creates instances in the Supervisor
    Table and User Table respectively. This method ensures that a duplicate
    email address is not used.

    This registration method is different to that in StudentController
    as different data is required to be passed in.

     NOTE: Should subsequently log the new user in if the registration is
     successful.
   */
  Future<String> registration(Supervisor supervisorA, User userA) async {
    supervisor.register = false;
    String userRegistrationMessage="";
    // ignore: non_constant_identifier_names
    String RegistrationSuccess="";
    userRegistrationMessage=await userController.userRegistration(userA);
    if (userRegistrationMessage=="Email Already Exists, Please Try Again With New Email Address..!"){
      RegistrationSuccess=userRegistrationMessage;
    }
    else{
      // SERVER API URL
      var url =
          'http://10.100.15.38/Register_Supervisor.php';
//          'https://witsinnovativeskyline.000webhostapp.com/Register_Supervisor.php';

      // Store all data with Param Name.
      var data = {
        'email': supervisorA.email.toLowerCase(),
        'StaffNo': supervisorA.staffNo.toLowerCase(),
        'Sup_FName': supervisorA.fName,
        'Sup_LName': supervisorA.lName,
        'Supervisor_OfficePhone': supervisorA.office,
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      if(message=="This staff number already has an associated account."){
        RegistrationSuccess=message;
        UserController userController=new UserController();
        userController.userDeRegistration(userA);
      }

      // If Web call Success than Hide the CircularProgressIndicator.
      if (message=="Supervisor Registered Successfully") {
        supervisor.register = true;
        RegistrationSuccess="Supervisor successfully registered!";
      }
    }

    return RegistrationSuccess;
  }

}
