import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/ListController.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:postgrad_tracker/counter.dart';
import 'package:postgrad_tracker/main.dart';


import 'Models_test.dart';

class Post {
  dynamic data;
  Post.fromJson(this.data);
}

class MockListController extends Mock implements ListController {
  @override
  String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    String fullString;
    assert(() {
      fullString = toDiagnosticsNode(style: DiagnosticsTreeStyle.singleLine).toString(minLevel: minLevel);
      return true;
    }());
    return fullString ?? toStringShort();
  }
}

//Future<Post> fetchPost(http.Client client) async {
//  final response =
//  await client.get('https://witsinnovativeskyline.000webhostapp.com/ReadLists.php');
//
//  if (response.statusCode == 200) {
//    // If the call to the server was successful, parse the JSON.
//    return Post.fromJson(json.decode(response.body));
//  } else {
//    // If that call was not successful, throw an error.
//    throw Exception('Failed to load post');
//  }
//}


class MockClient extends Mock implements http.Client{}

void main() {
  group('Server connection', () {

    ListController lc=new ListController();
    test('Reads lists',() async{final client=MockClient();
    expect(await lc.ReadLists(55), isInstanceOf<List<ListCard>>());



    });

//    test(
//        'returns a Post if the ListController http call completes successfully', () async {
//      final client = MockClient();
//
//      when(client.get(
//          'https://witsinnovativeskyline.000webhostapp.com/ReadLists.php'))
//          .thenAnswer((_) async =>
//          http.Response('{"title: ListController"}', 200));
//    });
//
//    test(
//        'returns a Post if the ListController http call completes successfully', () async {
//      final client = MockClient();
//
//      when(client.get(
//          'https://witsinnovativeskyline.000webhostapp.com/ReadLists.php'))
//          .thenAnswer((_) async => http.Response('Not Found', 404));
//
//      expect(fetchPost(client), throwsException);
//    });
//
//    testWidgets('All input feild and button widgets should be on screen', (
//        WidgetTester tester) async {
//      await tester.pumpWidget(makeWidgetTestable(ListController()));
//    });


  });

}
