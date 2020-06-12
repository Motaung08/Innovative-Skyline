import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/View/profile/supervisor/ViewSupProfile.dart';
import '../Models_test.dart';

void main(){
  testWidgets('All input feild and button widgets should be on screen',
          (WidgetTester tester) async {
    await tester.pumpWidget(makeWidgetTestable(ViewSupProfilePage()));

    final ProfileField = find.byKey(Key('ProfileText'));
    expect(ProfileField, isInstanceOf());

    final StudFullName = find.byKey(Key('StudFullName'));
    expect(StudFullName, isInstanceOf());
  });
}