import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Model/DegreeType.dart';
import 'package:postgrad_tracker/View/profile/student/ViewStudentProfile.dart';
import 'package:postgrad_tracker/View/profile/supervisor/ViewSupProfile.dart';
import 'package:postgrad_tracker/main.dart';
import 'Models_test.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client{}

void main(){
//  group('All pages should be accessed', ()
//  {
//    testWidgets('All input feild and button widgets should be on screen',
//            (WidgetTester tester) async {
//              await tester.pumpWidget(
//                  makeWidgetTestable(ViewStudentProfilePage()));
//            });
//    test('validation failed', () {
//      final results = ViewStudentProfilePage.validate(null);
//      expect(results, 'null');
//    });
//    test('validation passed', () {
//      final results = ViewStudentProfilePage.validate('nully');
//      expect(results, 'nully');
//    });
//    test('validation date failed', () {
//      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
//      final results = ViewStudentProfilePage.validateDate(null);
//      expect(results, dateFormat.parse('0000-00-00'));
//    });
//    test('validation date passed', () {
//
//      final DateTime dateTime = DateTime(2000);
//      final results = ViewStudentProfilePage.validateDate(dateTime);
//      expect(results, dateTime);
//    });
//    test('validation1 failed', () {
//      final results = ViewSupProfilePage.validate(null);
//      expect(results, 'null');
//    });
//    test('validation1 passed', () {
//      final results = ViewSupProfilePage.validate('nully');
//      expect(results, 'nully');
//    });
//
//    test("getter and setter methods", ()
//    {
//      student.fName = "Tshepang";
//      expect(student.fName, "Tshepang");
//
//      student.lName = "Motaung";
//      expect(student.lName, "Motaung");
//
//      student.studentNo = "1431795";
//      expect(student.studentNo, "1431795");
//
//      student.email = "1431795@students.wits.ac.za";
//      expect(student.email, "1431795@students.wits.ac.za");
//
////      student.studentType = "Full-Year";
////      expect(student.studentType, "Full-Year");
//
//      student.degreeID = 1;
//      expect(student.degreeID, 1);
//
////      student.registrationDate = "20-02-2009" as DateTime;
////      expect(student.registrationDate,"20-02-2009" as DateTime);
//
//      // ignore: unnecessary_statements
//      student.key;
//
//
//    });
group('Widgets', (){
    testWidgets('All input fields and button widgets should be on screen', (
        WidgetTester tester) async {
      Student testStud = new Student();
      testStud.fName = 'Meghan';
      testStud.lName = 'SB';
      testStud.studentNo = '1713445';
      testStud.email = '1713445@students.wits.ac.za';
      testStud.degreeID = 1;
      testStud.studentTypeID = 1;
      student = testStud;

      final client = new MockClient();

        when(client.post(
            'http://10.100.15.38/login.php',
            body: {
              'Email': '1713445@students.wits.ac.za'.toLowerCase(),
              'Password': 'Meghan'
            })).thenAnswer((_) async =>
            http.Response(
                '[{"UserID":"48","Email":"1713445@students.wits.ac.za","Password":"\$2y\$10\$gxaTrZTzD0L.LGCrBtKMZeaLcWKimeWN76KaSpMlthe6M9ARFFoYG","UserTypeId":"1"}]',
                200
            ));

        when(client.post('http://10.100.15.38/getTaskStatuses.php'))
            .thenAnswer((_) async =>
            http.Response(
                '[{"Task_StatusID":"1","Status":"Assigned"},{"Task_StatusID":"2","Status":"Acknowledged "},{"Task_StatusID":"3","Status":"Pending"},{"Task_StatusID":"4","Status":"Complete"}]'
                , 200
            ));
        when(client.post('http://10.100.15.38/getAssignmentTypes.php'))
            .thenAnswer((_) async =>
            http.Response(
                '[{"AssignmentTypeID":"1","AssignmentType":"Can edit and share."},{"AssignmentTypeID":"2","AssignmentType":"Can edit."},{"AssignmentTypeID":"3","AssignmentType":"Can view."},{"AssignmentTypeID":"4","AssignmentType":"Is Owner."}]'
                , 200
            ));

        when(client.post("http://10.100.15.38/getStudentTypes.php"))
            .thenAnswer((_) async =>
            http.Response(
                '[{"StudentTypeID":"1","Student_Type":"Full-time"},{"StudentTypeID":"2","Student_Type":"Part-time"}]'
                , 200
            ));

        when(client.post('http://10.100.15.38/getDegreeTypes.php')).thenAnswer((
            _) async =>
            http.Response(
                '[{"DegreeID":"1","Degree_Type":"Honors"},{"DegreeID":"2","Degree_Type":"Masters by dissertation"},{"DegreeID":"3","Degree_Type":"Masters by coursework"},{"DegreeID":"4","Degree_Type":"PhD"}]'
                , 200
            ));

        var data = {
          "Email": '1713445@students.wits.ac.za',
        };

        when(client.post(
            'http://10.100.15.38/viewStudentProfile.php', body: data))
            .thenAnswer((_) async =>
            http.Response(
                '[{"StudentNo":"1713445","Student_FirstName":"Meghan","Student_LastName":"Sinclair-Black","Student_Email":"1713445@students.wits.ac.za","Degree_ID":"1","Student_RegistrationDate":"2021-01-01","StudentTypeID":"1"}]'
                , 200
            ));

        await userController.login(
            '1713445@students.wits.ac.za', 'Meghan', client);


        ViewStudentProfilePage viewStudentProfilePage = new ViewStudentProfilePage();
        await tester.pumpWidget(makeWidgetTestable(ViewStudentProfilePage()));


        final ProfileField = find.byKey(Key('ProfileText'));
        expect(ProfileField, findsOneWidget);

      final nameHeading = find.byKey(Key('NameHeadingText'));
      expect(nameHeading, findsOneWidget);

      final NameField = find.byKey(Key('StudFullName'));
      expect(NameField, findsOneWidget);

      final StudentNumHeadingText = find.byKey(Key('StudentNumHeadingText'));
      expect(StudentNumHeadingText, findsOneWidget);

      // ignore: non_constant_identifier_names
      final StudentNoField = find.byKey(Key('StudentNoText'));
      expect(StudentNoField, findsOneWidget);

      final EmailHeadingText = find.byKey(Key('EmailHeadingText'));
      expect(EmailHeadingText, findsOneWidget);

      // ignore: non_constant_identifier_names
      final EmailField = find.byKey(Key('EmailText'));
      expect(EmailField, findsOneWidget);

      final DegreeHeadingText = find.byKey(Key('DegreeHeadingText'));
      expect(DegreeHeadingText, findsOneWidget);

      // ignore: non_constant_identifier_names
      final DegreeField = find.byKey(Key('DegreeText'));
      expect(DegreeField, findsOneWidget);

      final DateRegHeadingText = find.byKey(Key('DateRegHeadingText'));
      expect(DateRegHeadingText, findsOneWidget);

      // ignore: non_constant_identifier_names
      final DORField = find.byKey(Key('DORText'));
      expect(DORField, findsOneWidget);

      final StudTypeHeadingText = find.byKey(Key('StudTypeHeadingText'));
      expect(StudTypeHeadingText, findsOneWidget);

      // ignore: non_constant_identifier_names
      final StudentField = find.byKey(Key('StudentText'));
      expect(StudentField, findsOneWidget);

      });
    });


}