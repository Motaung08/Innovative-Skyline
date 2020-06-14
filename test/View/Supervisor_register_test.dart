import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/View/register/SupervisorRegister.dart';

import '../Models_test.dart';


class MockClient extends Mock implements http.Client{}


void main(){

  group('Server connection', () {

    testWidgets('All input feild and button widgets should be on screen', (
        WidgetTester tester) async {
      SupervisorRegisterPage supervisorRegisterPage=new SupervisorRegisterPage();
      await tester.pumpWidget(makeWidgetTestable(supervisorRegisterPage));

      final supStaffNo = find.byKey(Key('staffNumber'));
      expect(supStaffNo, findsOneWidget);

      final supEmail = find.byKey(Key('firstName'));
      expect(supEmail, findsOneWidget);

      final supfName = find.byKey(Key('lastName'));
      expect(supfName, findsOneWidget);

      final supLName = find.byKey(Key('email'));
      expect(supLName, findsOneWidget);

      final supOffice = find.byKey(Key('office'));
      expect(supOffice, findsOneWidget);

      final supPass = find.byKey(Key('password'));
      expect(supPass, findsOneWidget);

      final supCOnfPass = find.byKey(Key('confPass'));
      expect(supCOnfPass, findsOneWidget);

      final regButton = find.byKey(Key('RegisterButton'));
      expect(regButton, findsOneWidget);

      final divider = find.byKey(Key('Divider'));
      expect(divider, findsOneWidget);

      final loginButton = find.byKey(Key('LoginButton'));
      expect(loginButton, findsOneWidget);


      expect(find.text('Enter a Staff Number'),findsNothing);
      expect(find.text('Enter a First Name'),findsNothing);
      expect(find.text('Enter a Last Name'),findsNothing);
      expect(find.text('Please enter an email address!.'),findsNothing);
      expect(find.text('Invalid staff email address'),findsNothing);
      expect(find.text('Enter a Password with 6+ chars.'),findsNothing);
      expect(find.text('Confirm password.'),findsNothing);
      expect(find.text('Passwords must match'),findsNothing);

      await tester.tap(regButton);
      await tester.pump();

      expect(find.text('Enter a Staff Number'),findsOneWidget);
      expect(find.text('Enter a First Name'),findsOneWidget);
      expect(find.text('Enter a Last Name'),findsOneWidget);
      expect(find.text('Please enter an email address!.'),findsOneWidget);
      //expect(find.text('Invalid staff email address'),findsNothing);
      expect(find.text('Enter a Password with 6+ chars.'),findsOneWidget);
      expect(find.text('Confirm password.'),findsOneWidget);
      //expect(find.text('Passwords must match'),findsNothing);

      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState.validate(), isFalse);

      await tester.enterText(supStaffNo, '123456AQ');
      await tester.enterText(supEmail, 'invalid@gmail.com');
      await tester.enterText(supfName, 'SupFirst');
      await tester.enterText(supLName, 'SupLast');
      await tester.enterText(supPass, '123456AQ');
      await tester.enterText(supCOnfPass, 'invalid');
      await tester.pump();

      await tester.tap(regButton);
      await tester.pump();

      expect(find.text('Invalid staff email address'),findsOneWidget);
      expect(find.text('Passwords must match'),findsOneWidget);

      await tester.enterText(supEmail, 'supInput@wits.ac.za');
      await tester.enterText(supCOnfPass, '123456AQ');

//      await tester.tap(regButton);
//      await tester.pump();

//      expect(formKey.currentState.validate(), isTrue);





    });



  });

}