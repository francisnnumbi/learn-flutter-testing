import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
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
    await tester.pumpWidget(MaterialApp(home: ProfileUi(userRepository: sut)));

    when(() => mockHttpClient.get(
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
    });

    expect(find.text('Profile'), findsOneWidget);
    // expect(find.byType(ProfileUi), findsOneWidget);
  });

  testWidgets('ProfileUi has a CircularProgressIndicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileUi(userRepository: sut)));

    when(() => mockHttpClient.get(
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
    });

    var circularProgressIndicator = find.byType(CircularProgressIndicator);
    expect(circularProgressIndicator, findsOneWidget);

    await tester.pump();
    var userName = find.text("Leanne Graham");

    expect(userName, findsOneWidget);
  });
}
