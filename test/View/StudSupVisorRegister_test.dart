import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/View/Login.dart';
import 'package:postgrad_tracker/View/register/StudentSuperVisorRegister.dart';


class MockClient extends Mock implements http.Client{}


Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle,child: widget),
  );
}

main() {
  group('Server connection', () {

    test(
        'returns a Post if the Login http call completes successfully', () async {
      final client = MockClient();

      when(client.get(
          'https://lamp.ms.wits.ac.za/~s1611821/register_user.php'))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
    });

    test(
        'returns a Post if the Register http call completes successfully', () async {
      final client = MockClient();

      when(client.get(
          'https://lamp.ms.wits.ac.za/~s1611821/register_user.php'))
          .thenAnswer((_) async =>
          http.Response('{"title: RegisterChoice"}', 200));
    });


    testWidgets('All input feild and button widgets should be on screen', (
        WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(LoginPage()));

    });

    testWidgets('All input feild and button widgets should be on screen', (
        WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(StudentSupChoicePage()));

    });




  });



}