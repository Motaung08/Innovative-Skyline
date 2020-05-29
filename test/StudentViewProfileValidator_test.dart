import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/profile/student/ViewStudentProfile.dart';
import 'package:postgrad_tracker/View/profile/supervisor/ViewSupProfile.dart';
import 'package:postgrad_tracker/main.dart';

import 'Models_test.dart';


void main(){
  group('All pages should be accessed', ()
  {
    test('validation failed', () {
      final results = ViewStudentProfilePage.validate(null);
      expect(results, 'null');
    });
    test('validation passed', () {
      final results = ViewStudentProfilePage.validate('nully');
      expect(results, 'nully');
    });
    test('validation date failed', () {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      final results = ViewStudentProfilePage.validateDate(null);
      expect(results, dateFormat.parse('0000-00-00'));
    });
    test('validation date passed', () {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      final DateTime dateTime = DateTime(2000);
      final results = ViewStudentProfilePage.validateDate(dateTime);
      expect(results, dateTime);
    });
    test('validation1 failed', () {
      final results = ViewSupProfilePage.validate(null);
      expect(results, 'null');
    });
    test('validation1 passed', () {
      final results = ViewSupProfilePage.validate('nully');
      expect(results, 'nully');
    });

    test("getter and setter methods", ()
    {
      student.fName = "Tshepang";
      expect(student.fName, "Tshepang");

      student.lName = "Motaung";
      expect(student.lName, "Motaung");

      student.studentNo = "1431795";
      expect(student.studentNo, "1431795");

      student.email = "1431795@students.wits.ac.za";
      expect(student.email, "1431795@students.wits.ac.za");

//      student.studentType = "Full-Year";
//      expect(student.studentType, "Full-Year");

      student.degreeID = 1;
      expect(student.degreeID, 1);

//      student.registrationDate = "20-02-2009" as DateTime;
//      expect(student.registrationDate,"20-02-2009" as DateTime);

      // ignore: unnecessary_statements
      student.key;


    });

//    testWidgets('All input feild and button widgets should be on screen', (
//        WidgetTester tester) async {
//      await tester.pumpWidget(makeWidgetTestable(ViewStudentProfilePage()));

      // ignore: non_constant_identifier_names
//      final ProfileField = find.byKey(Key('ProfileText'));
//      expect(ProfileField, findsOneWidget);

      // ignore: non_constant_identifier_names
//      final NameField = find.byKey(Key('NameText'));
//      expect(NameField, findsOneWidget);
//
//      // ignore: non_constant_identifier_names
//      final StudentNoField = find.byKey(Key('StudentNoText'));
//      expect(StudentNoField, findsOneWidget);
//
//      // ignore: non_constant_identifier_names
//      final EmailField = find.byKey(Key('EmailText'));
//      expect(EmailField, findsOneWidget);
//
//      // ignore: non_constant_identifier_names
//      final DegreeField = find.byKey(Key('DegreeText'));
//      expect(DegreeField, findsOneWidget);
//
//      // ignore: non_constant_identifier_names
//      final DORField = find.byKey(Key('DORText'));
//      expect(DORField, findsOneWidget);
//
//      // ignore: non_constant_identifier_names
//      final StudentField = find.byKey(Key('StudentText'));
//      expect(StudentField, findsOneWidget);

//    });



  });

}