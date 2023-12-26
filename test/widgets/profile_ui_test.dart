import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:learn_flutter_testing/app/models/user_model.dart';
import 'package:learn_flutter_testing/app/repositories/user_repository.dart';
import 'package:learn_flutter_testing/app/ui/profile_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late UserRepository sut;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    sut = UserRepository(mockHttpClient);
  });
  testWidgets('ProfileUi has a title and a user', (WidgetTester tester) async {
    final user = User(
      id: 1,
      name: 'Leanne Graham',
      email: "Sincere@april.biz",
      website: "hildegard.org",
    );

    Future<User> getUser() async =>
        Future.delayed(const Duration(seconds: 1), () => user);
    await tester
        .pumpWidget(MaterialApp(home: ProfileUi(futureUser: getUser())));
    await tester.pumpAndSettle();
/*    when(() => mockHttpClient.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
        )).thenAnswer((invocation) async {
      return Response('''
            {
              "id": 1,
            "name": "Leanne Graham",
            "username": "Bret",
            "email": "Sincere@april.biz",
            "website": "hildegard.org"
            }
          ''', 200);
    });*/

    expect(find.text('Profile'), findsOneWidget);
    // expect(find.byType(ProfileUi), findsOneWidget);
  });

  testWidgets('ProfileUi has a CircularProgressIndicator',
      (WidgetTester tester) async {
    final user = User(
      id: 1,
      name: 'Leanne Graham',
      email: "Sincere@april.biz",
      website: "hildegard.org",
    );

    Future<User> getUser() async =>
        Future.delayed(const Duration(seconds: 1), () => user);

    await tester
        .pumpWidget(MaterialApp(home: ProfileUi(futureUser: getUser())));

/*    when(() => mockHttpClient.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
        )).thenAnswer((invocation) async {
      return Response('''
            {
              "id": 1,
            "name": "Leanne Graham",
            "username": "Bret",
            "email": "Sincere@april.biz",
            "website": "hildegard.org"
            }
          ''', 200);
    });*/

    final circularProgressIndicator = find.byType(CircularProgressIndicator);
    expect(circularProgressIndicator, findsOneWidget);

    await tester.pumpAndSettle();
    final userName = find.text(user.name!);

    expect(userName, findsOneWidget);
  });
}
