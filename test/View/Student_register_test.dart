import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/View/register/StudentRegister.dart';
import 'package:postgrad_tracker/View/register/SupervisorRegister.dart';

import '../Models_test.dart';


class MockClient extends Mock implements http.Client{}


void main(){

  group('Server connection', () {

    testWidgets('All input feild and button widgets should be on screen', (
        WidgetTester tester) async {
      StudentRegisterPage studentRegisterPage=new StudentRegisterPage();

      http.Client client=new MockClient();
      when(client.post("http://10.100.15.38/getStudentTypes.php"))
          .thenAnswer((_) async =>
          http.Response(
              '[{"StudentTypeID":"1","Student_Type":"Full-time"},{"StudentTypeID":"2","Student_Type":"Part-time"}]'
              , 200
          ));

      //5
      when(client.post('http://10.100.15.38/getDegreeTypes.php')).thenAnswer((
          _) async =>
          http.Response(
              '[{"DegreeID":"1","Degree_Type":"Honors"},{"DegreeID":"2","Degree_Type":"Masters by dissertation"},{"DegreeID":"3","Degree_Type":"Masters by coursework"},{"DegreeID":"4","Degree_Type":"PhD"}]'
              , 200
          ));
      studRegClient=client;
      await tester.pumpWidget(makeWidgetTestable(studentRegisterPage));

      final studNo = find.byKey(Key('studNo'));
      expect(studNo, findsOneWidget);

      final firstName = find.byKey(Key('firstName'));
      expect(firstName, findsOneWidget);

      final lastName = find.byKey(Key('lastName'));
      expect(lastName, findsOneWidget);

      final email = find.byKey(Key('email'));
      expect(email, findsOneWidget);

      final DropDownDegree = find.byKey(Key('DropDownDegree'));
      expect(DropDownDegree, findsOneWidget);

      final DropDownStudType = find.byKey(Key('DropDownStudType'));
      expect(DropDownStudType, findsOneWidget);

      final RegDateButton = find.byKey(Key('RegDateButton'));
      expect(RegDateButton, findsOneWidget);

      final password = find.byKey(Key('password'));
      expect(password, findsOneWidget);

      final confirmPass = find.byKey(Key('confirmPass'));
      expect(confirmPass, findsOneWidget);

      final registerButton = find.byKey(Key('registerButton'));
      expect(registerButton, findsOneWidget);

      final divider = find.byKey(Key('divider'));
      expect(divider, findsOneWidget);

      final loginButton = find.byKey(Key('loginButton'));
      expect(loginButton, findsOneWidget);


      expect(find.text('Enter a Student Number'),findsNothing);
      expect(find.text('Enter a first name'),findsNothing);
      expect(find.text('Enter a last name'),findsNothing);
      expect(find.text('Please enter an email address!.'),findsNothing);
      expect(find.text('Invalid student email address'),findsNothing);
      expect(find.text('Enter a password 6+ chars long'),findsNothing);
      expect(find.text('Confirm password.'),findsNothing);
      expect(find.text('Passwords must match'),findsNothing);

      await tester.tap(registerButton);
      await tester.pump();

      expect(find.text('Enter a Student Number'),findsOneWidget);
      expect(find.text('Enter a first name'),findsOneWidget);
      expect(find.text('Enter a last name'),findsOneWidget);
      expect(find.text('Please enter an email address!.'),findsOneWidget);
      expect(find.text('Enter a password 6+ chars long'),findsOneWidget);
      expect(find.text('Confirm password.'),findsOneWidget);


      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState.validate(), isFalse);

      await tester.enterText(studNo, '123456AQ');
      await tester.enterText(email, 'invalid@gmail.com');
      await tester.enterText(firstName, 'SupFirst');
      await tester.enterText(lastName, 'SupLast');
      await tester.enterText(password, '123456AQ');
      await tester.enterText(confirmPass, 'invalid');
      await tester.pump();

      await tester.tap(registerButton);
      await tester.pump();

      expect(find.text('Invalid student email address'),findsOneWidget);
      expect(find.text('Passwords must match'),findsOneWidget);

      await tester.enterText(email, 'supInput@wits.ac.za');
      await tester.enterText(confirmPass, '123456AQ');

//      await tester.tap(registerButton);
//      await tester.pump();
//
//      expect(formKey.currentState.validate(), isTrue);





    });



  });

}