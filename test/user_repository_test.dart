import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:learn_flutter_testing/app/models/user_model.dart';
import 'package:learn_flutter_testing/app/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late UserRepository userRepository;
  late MockHttpClient mockHttpClient;
  setUp(() {
    // use Mocktail to mock the http client as it is the simplest way to mock
    mockHttpClient = MockHttpClient();
    userRepository = UserRepository(mockHttpClient);
  });

  group("UserRepository - ", () {
    group("getUser() - ", () {
      test("if status code is 200 then the user model should be returned",
          () async {
        // Arrange
        // We are stubbing the http client to return a response with status code 200
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

        // Act
        // here we are expecting a user to be returned, then we must await the call
        final user = await userRepository.getUser();
        // Assert
        expect(user, isA<User>());
      });

      test("if status code is not 200 then an exception should be thrown",
          () async {
        // Arrange
        // We are stubbing the http client to return a response with status code different than 200
        when(() => mockHttpClient.get(
              Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
            )).thenAnswer((invocation) async => Response('{}', 500));

        // Act
        // here we are expecting an exception to be thrown, then we must not await the call
        final user = userRepository.getUser();
        // Assert
        expect(user, throwsA(isA<Exception>()));
      });
    });
  });
}
