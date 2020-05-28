import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/DegreeController.dart';
import 'package:postgrad_tracker/main.dart';

import 'Models_test.dart';

class Post {
  dynamic data;
  Post.fromJson(this.data);
}

class MockClient extends Mock implements http.Client {}

//class MockDegreeController extends Mock implements DegreeController{}

//Future<Post> fetchPost(http.Client client) async {
//  final response =
//  await client.get('https://witsinnovativeskyline.000webhostapp.com/getDegreeTypes.php');
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
void main() {
  group('get degrees test', () {

    test(
        'populates degree array if the http call completes successfully', () async {
      final client = MockDegreeController();
      await client.getDegrees();

        expect(degrees.length, greaterThan(0));

      


//      when(client.getDegrees())
//          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
    });

//    test(
//        'returns a Post if the DegreeController http call completes successfully', () async {
//      final client = MockClient();
//
//      when(client.get(
//          'https://witsinnovativeskyline.000webhostapp.com/getDegreeTypes.php'))
//          .thenAnswer((_) async =>
//          http.Response('{"title: DegreeController"}', 200));
//    });
//
//    test(
//        'returns a Post if the DegreeController http call completes successfully', () async {
//      final client = MockClient();
//      final degree=DegreeController();
//
//
//      when(client.get(
//          'https://witsinnovativeskyline.000webhostapp.com/getDegreeTypes.php'))
//          .thenAnswer((_) async => http.Response('Not Found', 404));
//
//
//      expect(degree.getDegrees(), throwsException);
//    });
//
//    testWidgets('All input feild and button widgets should be on screen', (
//        WidgetTester tester) async {
//      await tester.pumpWidget(makeWidgetTestable(DegreeController()));
//
//    });

  });

}