import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/profile/student/ViewStudentProfile.dart';
import 'package:postgrad_tracker/View/profile/supervisor/ViewSupProfile.dart';

import 'Models_test.dart';

//class Post {
//  dynamic data;
//  Post.fromJson(this.data);
//}
//
//class MockClient extends Mock implements http.Client {}
//
//Future<Post> fetchPost(http.Client client) async {
//  final response =
//  await client.get('https://witsinnovativeskyline.000webhostapp.com/register_user.php');
//
//  if (response.statusCode == 200) {
//    // If the call to the server was successful, parse the JSON.
//    return Post.fromJson(json.decode(response.body));
//  } else {
//    // If that call was not successful, throw an error.
//    throw Exception('Failed to load post');
//  }
//}
//
//
//void main() {
//  group('Server connection', () {
//
//    test(
//        'returns a Post if the UserController http call completes successfully', () async {
//      final client = MockClient();
//
//      when(client.get(
//          'https://witsinnovativeskyline.000webhostapp.com/register_user.php'))
//          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
//    });
//
//    test(
//        'returns a Post if the UserController http call completes successfully', () async {
//      final client = MockClient();
//
//      when(client.get(
//          'https://witsinnovativeskyline.000webhostapp.com/register_user.php'))
//          .thenAnswer((_) async =>
//          http.Response('{"title: UserController"}', 200));
//    });
//
//    test(
//        'returns a Post if the UserController http call completes successfully', () async {
//      final client = MockClient();
//
//      when(client.get(
//          'https://witsinnovativeskyline.000webhostapp.com/register_user.php'))
//          .thenAnswer((_) async => http.Response('Not Found', 404));
//
//      expect(fetchPost(client), throwsException);
//    });
//
//    testWidgets('All input feild and button widgets should be on screen', (
//        WidgetTester tester) async {
//      await tester.pumpWidget(makeWidgetTestable(UserController()));
//
//    });
//
//
//  });
//
//}
class MockUserController extends Mock implements UserController{
//  @override
//  String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
//    String fullString;
//    assert(() {
//      fullString = toDiagnosticsNode(style: DiagnosticsTreeStyle.singleLine).toString(minLevel: minLevel);
//      return true;
//    }());
//    return fullString ?? toStringShort();
//  }
}
void main(){
  group('Test User', (){
    test('test fetch user', () async{
      UserController mockUserController=MockUserController();
      expect(when(await mockUserController.getUser('1713445@students.wits.ac.za')),isInstanceOf<PostExpectation<User>>());
    });

//        testWidgets('All input feild and button widgets should be on screen', (
//        WidgetTester tester) async {
//      await tester.pumpWidget(makeWidgetTestable(UserController()));
//
//    });
  });
}