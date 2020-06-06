import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Controller/SupervisorController.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';

void main() {
  group('Server connection', () {
    test(
        'fetchSupervisor', () async {
      SupervisorController fetchedSup=new SupervisorController();

      //expect(await fetchedSup.fetchSup('tsh@wits.ac.za',url: "https://lamp.ms.wits.ac.za/~s1611821/viewSupProfile.php"), isNotNull);
    });

    test(
        'setSupervisorUser', () async {
      SupervisorController fetchedSup=new SupervisorController();

      await fetchedSup.setUserSup('tsh@wits.ac.za', url: "https://lamp.ms.wits.ac.za/~s1611821/viewSupProfile.php",
                        url2:"https://lamp.ms.wits.ac.za/~s1611821/ReadBoards.php");

      expect(supervisor!=null, true);
    });


    test(
        'Supervisor Registration', () async {
      User testUser=new User();

      testUser.email='testSupvisorReg@wits.ac.za';
      testUser.password="testSupPassword";
      testUser.userTypeID=2;

      Supervisor testSupervisor=new Supervisor();

      testSupervisor.email=testUser.email;
      expect(testSupervisor.email, testUser.email);

      testSupervisor.staffNo="UniqueStaffNo123456a";
      expect(testSupervisor.staffNo, 'UniqueStaffNo123456a');

      testSupervisor.fName="Tshepang";
      expect(testSupervisor.fName, "Tshepang");

      testSupervisor.lName="Motaung";
      expect(testSupervisor.lName, "Motaung");

      testSupervisor.office="+134";
      expect(testSupervisor.office, "+134");


      SupervisorController supervisorController=new SupervisorController();
//
//      expect(await supervisorController.registration(testSupervisor, testUser,
//          url:"https://lamp.ms.wits.ac.za/~s1611821/Register_Supervisor.php",
//          url2:"https://lamp.ms.wits.ac.za/~s1611821/register_user.php"), "Supervisor successfully registered!");
//
//      await userController.userDeRegistration(testUser,url:"https://lamp.ms.wits.ac.za/~s1611821/deregister_user.php");
    });

    test("test variable data", () async {
      Supervisor supervisorA = new Supervisor();

      var data = {

        'email': supervisorA.email,

        'StaffNo': supervisorA.staffNo,

        'Sup_FName': supervisorA.fName,

        'Sup_LName': supervisorA.lName,

        'Supervisor_OfficePhone': supervisorA.office,

      };

      data.containsKey(supervisorA.email);
      data.containsKey(supervisorA.lName);
      data.containsKey(supervisorA.fName);
      data.containsKey(supervisorA.staffNo);
      data.containsKey(supervisorA.office);
      data.containsKey(supervisorA.key);

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
