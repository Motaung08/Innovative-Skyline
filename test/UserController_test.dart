import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/TaskStatusController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';


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
class MockUserController extends Mock implements UserController{}
void main(){
  group('Test User', (){
    test('test fetch user', () async{
      UserController mockUserController=MockUserController();
      expect(when(await mockUserController.getUser('1713445@students.wits.ac.za')),isInstanceOf<PostExpectation<User>>());
    });

    test('Test UserRegistration', () async {
      User testuser = new User();

      UserController userController = new UserController();
//      User mockList=MockUser();
      await userController.ReadUsers();
      List<List<User>> testlists=[];

      testuser.email = 'tman@gmail.com';
      expect(testuser.email, 'tman@gmail.com');

      testuser.password = 'tman';
      expect(testuser.password, 'tman');

      testuser.userTypeID =1;
      expect(testuser.userTypeID, 1);
    });

    test('test Status', () async {
      TaskStatusController taskStatus = new TaskStatusController();

      await taskStatus.getStatuses();

    });

    test('UserReceived', () async {
      User userRec = new User();
      UserController userController = new UserController();

      userRec.email = '';
      userRec.password = '';


    });


  });
}