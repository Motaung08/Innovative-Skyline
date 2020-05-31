import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/View/profile/supervisor/ViewSupProfile.dart';
import '../Models_test.dart';



void main(){
  testWidgets('All input feild and button widgets should be on screen', (
      WidgetTester tester) async {
    await tester.pumpWidget(makeWidgetTestable(ViewSupProfilePage()));


    // ignore: non_constant_identifier_names
    final ProfileField = find.byKey(Key('ProfileText'));
    expect(ProfileField, findsOneWidget);

    // ignore: non_constant_identifier_names
    final NameField = find.byKey(Key('NameText'));
    expect(NameField, findsOneWidget);

//    // ignore: non_constant_identifier_names
    // ignore: non_constant_identifier_names
    final StaffNumberField = find.byKey(Key('StaffNumberText'));
    expect(StaffNumberField, findsOneWidget);

//    // ignore: non_constant_identifier_names
    // ignore: non_constant_identifier_names
    final EmailField = find.byKey(Key('EmailText'));
    expect(EmailField, findsOneWidget);
//
//    // ignore: non_constant_identifier_names
    // ignore: non_constant_identifier_names
    final OfficePhoneField = find.byKey(Key('OfficePhoneText'));
    expect(OfficePhoneField, findsOneWidget);

  });
}