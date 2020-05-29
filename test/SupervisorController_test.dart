import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/SupervisorController.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';



class Post {
  dynamic data;
  Post.fromJson(this.data);
}

class MockClient extends Mock implements http.Client {}

Future<Post> fetchPost(http.Client client) async {
  final response =
  await client.get('https://witsinnovativeskyline.000webhostapp.com/viewSupProfile.php');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


void main() {
  group('Server connection', () {
    test(
        'fetchSupervisor', () async {
      SupervisorController fetchedSup=new SupervisorController();

      expect(await fetchedSup.fetchSup('tsh@wits.ac.za'), isInstanceOf<Supervisor>());
    });

    test(
        'setSupervisorUser', () async {
      SupervisorController fetchedSup=new SupervisorController();

      await fetchedSup.setUserSup('tsh@wits.ac.za');
      expect(supervisor!=null, true);
    });

    test('Invalid supUser details', () async {
      SupervisorController fetchedSup = new SupervisorController();

      String email ='';

      //print("No supervisor")

      await fetchedSup.fetchSup(email);
    });

    test(
        'Supervisor Registration', () async {
      User testUser=new User();
      String userSuccess="";
      String registrationSuccess="";


      testUser.email='testSupvisor@wits.ac.za';
      testUser.password="testSupPassword";
      testUser.userTypeID=1;

      Supervisor testSupervisor=new Supervisor();

      testSupervisor.email=testUser.email;
      expect(testSupervisor.email, testUser.email);

      testSupervisor.staffNo="12345";
      expect(testSupervisor.staffNo, '12345');

      testSupervisor.fName="Tshepang";
      expect(testSupervisor.fName, "Tshepang");

      testSupervisor.lName="Motaung";
      expect(testSupervisor.lName, "Motaung");

      testSupervisor.office="1";
      expect(testSupervisor.office, "1");


      //testStudent.studentTypeID
      SupervisorController supervisorController=new SupervisorController();
      await supervisorController.setUserSup('tsh@wits.ac.za');
      expect(supervisor!=null, true);
    });

    test("test variable data", () async {
      Supervisor supervisorA = new Supervisor();

      supervisorA.email = 'email';
      expect(supervisorA.email, 'email');

      supervisorA.staffNo = 'StaffNo';
      expect(supervisorA.staffNo, 'StaffNo');

      supervisorA.fName = 'Sup_FName';
      expect(supervisorA.fName, 'Sup_FName');

      supervisorA.lName = 'Sup_LName';
      expect(supervisorA.lName,'Sup_LName');

      supervisorA.office = 'Supervisor_OfficePhone';
      expect(supervisorA.office,'Supervisor_OfficePhone');


    });

  });

}
