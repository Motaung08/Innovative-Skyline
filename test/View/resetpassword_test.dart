import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/View/Login.dart';
import 'package:postgrad_tracker/View/resetpassword.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;


Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
      home:DefaultAssetBundle(bundle: rootBundle, child: widget)
  );
}

class MockClient extends Mock implements http.Client{}

void main() {
 group('all input field  and button widgets should be on screen', ()
 {
   testWidgets('all input field  and button widgets should be on screen', (
       WidgetTester tester) async {
     await tester.pumpWidget(makeWidgetTestable(ResetPasswordView()));

     //password input field
     final passwordField = find.byKey(Key("PasswordInput"));
     expect(passwordField, findsOneWidget);

     //confirm password
     // ignore: non_constant_identifier_names
     final ConfirmPasswordField = find.byKey(Key("confirmPasswordInput"));
     expect(ConfirmPasswordField, findsOneWidget);

     // ignore: non_constant_identifier_names
     final StudentEmailField = find.byKey(Key('StudentEmailInput'));
     expect(StudentEmailField, findsOneWidget);

     // ignore: non_constant_identifier_names
     final resetButton = find.byKey(Key("ResetButtonInput"));
     expect(resetButton, findsOneWidget);


   });

   testWidgets('entering text on input fields', (WidgetTester tester) async {
     await tester.pumpWidget(makeWidgetTestable(LoginPage()));

     final forgotPassButton = find.byKey(Key("ForgotPasswordInput"));
     expect(forgotPassButton, findsOneWidget);
   });

   testWidgets('test visibility', (WidgetTester tester) async {
     ResetPasswordView resetPasswordView=new ResetPasswordView();
     await tester.pumpWidget(makeWidgetTestable(resetPasswordView));

     expect(resetPasswordView.isHidden, true);
     expect(resetPasswordView.isHiddenConf, true);
     final viewHidePassword = find.byKey(Key("viewHidePassword"));
     final hiddenConfButton=find.byKey(Key('isHiddenConfButton'));
     expect(viewHidePassword, findsOneWidget);
     expect(hiddenConfButton, findsOneWidget);
     await tester.tap(viewHidePassword);
     await tester.tap(hiddenConfButton);
     expect(resetPasswordView.isHidden, false);
     expect(resetPasswordView.isHiddenConf, false);


   });

   testWidgets('Reset password', (WidgetTester tester) async {
     ResetPasswordView resetPasswordView=new ResetPasswordView();
     await tester.pumpWidget(makeWidgetTestable(resetPasswordView));
     resetPasswordView.resetUrl="https://lamp.ms.wits.ac.za/~s1611821/ResetPassword.php";

     Finder email = find.byKey(new Key('StudentEmailInput'));
     expect(email, findsOneWidget);

     Finder password = find.byKey(new Key('PasswordInput'));
     expect(password, findsOneWidget);

     Finder confirmPassword = find.byKey(new Key('confirmPasswordInput'));
     expect(confirmPassword, findsOneWidget);

     Finder formWidgetFinder = find.byType(Form);
     Form formWidget = tester.widget(formWidgetFinder) as Form;
     GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
     expect(formKey.currentState.validate(), isFalse);

     expect(formKey.currentState.validate(), isFalse);

     expect(formKey.currentState.validate(), isFalse);

     expect(formKey.currentState.validate(), isFalse);

     final resetButton = find.byKey(Key("ResetButtonInput"));
     expect(resetButton, findsOneWidget);
     await tester.tap(resetButton);
     await tester.pump();
     expect(find.text('Email is Required'), findsOneWidget);
     expect(find.text('Enter a password 6+ chars long'), findsOneWidget);
     expect(find.text('Confirm password.'), findsOneWidget);

     await tester.enterText(email, "Default@students.wits.ac.za");
     await tester.pump();
     await tester.enterText(password, "123456");
     await tester.pump();
     await tester.enterText(confirmPassword, "1234567");
     await tester.pump();
     await tester.tap(resetButton);
     await tester.pump();
     expect(find.text('Passwords must match'), findsOneWidget);
     await tester.enterText(confirmPassword, "123456");
     await tester.pump();

     //http.Client httpClient=
     resetPasswordView.resetClient=new MockClient();

     var data =
     {
       'Email': 'default@students.wits.ac.za'.toLowerCase(),
       'Password': '123456'
     };

     when(resetPasswordView.resetClient.post('http://10.100.15.38/ResetPassword.php', body: jsonEncode(data)))
         .thenAnswer((_) async => http.Response("Password updated successfully",200));
//     userController.ResetPassword('Default@students.wits.ac.za'.toLowerCase(), '123456', new MockClient());

     await tester.tap(resetButton);
     await tester.pump();

     expect(formKey.currentState.validate(), isTrue);


   });

 });

 group('Reset',(){

 });

}