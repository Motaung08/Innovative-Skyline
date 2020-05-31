import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/DegreeController.dart';
import 'package:postgrad_tracker/main.dart';

class MockDegreeController extends DegreeController implements Mock{}
void main() {
  test(
      'populates degree array if the http call completes successfully', () async {
    final client = MockDegreeController();
    await client.getDegrees();

    expect(degrees.length, greaterThan(0));

  });

}