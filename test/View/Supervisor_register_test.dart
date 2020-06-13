import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/View/register/SupervisorRegister.dart';

import '../Models_test.dart';


class MockClient extends Mock implements http.Client{}


class Post {
  dynamic data;
  Post.fromJson(this.data);
}

Future<Post> fetchPost(http.Client client) async {
  final response =
  await client.get('https://lamp.ms.wits.ac.za/~s1611821/Register_Supervisor.php');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


void main(){

  group('Server connection', () {

    testWidgets('All input feild and button widgets should be on screen', (
        WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(SupervisorRegisterPage()));

      final client = MockClient();

      when(client.get(
          'https://lamp.ms.wits.ac.za/~s1611821/Register_Supervisor.php'))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchPost(client), throwsException);
    });

  });

}