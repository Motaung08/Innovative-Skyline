import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'dart:async';

import 'package:postgrad_tracker/View/Board.dart';
import 'package:postgrad_tracker/main.dart';


void main(){
  test('Future.value() returns the value', () async {
    var value = await Future.value(10);
    expect(value, equals(10));
  });

  
    testWidgets('Testing Board', (WidgetTester tester) async{
      await tester.pumpWidget(Board());

      var button = find.text('Add Task');
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pump();
//
    });

    
}