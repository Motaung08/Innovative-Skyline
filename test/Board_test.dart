import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'dart:async';


void main(){
  test('Future.value() returns the value', () async {
    var value = await Future.value(10);
    expect(value, equals(10));
  });


//
//    testWidgets('Testing Board', (WidgetTester tester) async{
//      await tester.pumpWidget(Board());
//    });git
}