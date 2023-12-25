import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:learn_flutter_testing/app/models/post_model.dart';
import 'package:learn_flutter_testing/app/repositories/post_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late PostRepository sut; // sut = system under test
  late MockHttpClient mockHttpClient;

  setUp(() {
    // use Mocktail to mock the http client as it is the simplest way to mock
    mockHttpClient = MockHttpClient();
    sut = PostRepository(mockHttpClient);
  });

  group("PostRepository - ", () {
    group("getPosts() - ", () {
      test(
          "if status code is 200 then the list of post models should be returned",
          () async {
        // Arrange
        when(() => mockHttpClient.get(
              Uri.parse('https://jsonplaceholder.typicode.com/posts'),
            )).thenAnswer((invocation) async {
          return Response('''
          [
            {
              "userId": 1,
              "id": 1,
              "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
              "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit "
            },
            {
              "userId": 1,
              "id": 2,
              "title": "qui est esse",
              "body": "est rerum tempore vitae sequi sint nihil reprehenderit dolor beatae ea dolores neque"
            }
          ]
          ''', 200);
        });
        // Act
        final List<Post> posts = await sut.getPosts();
        // Assert
        expect(posts, isA<List<Post>>());
      });
      test("if status code is not 200 then an exception should be thrown",
          () async {
        // Arrange
        when(() => mockHttpClient.get(
              Uri.parse('https://jsonplaceholder.typicode.com/posts'),
            )).thenAnswer((invocation) async => Response('{}', 500));
        // Act
        final posts = sut.getPosts();
        // Assert
        expect(posts, throwsA(isA<Exception>()));
      });
    });
    group("getPost(id) - ", () {
      test("if status code is 200 then the post model should be returned",
          () async {
        // Arrange
        when(() => mockHttpClient.get(
              Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
            )).thenAnswer((invocation) async {
          return Response('''
            {
              "userId": 1,
              "id": 1,
              "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
              "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit "
            }
          ''', 200);
        });
        // Act
        final Post post = await sut.getPost(1);
        // Assert
        expect(post, isA<Post>());
      });
      test("if status code is not 200 then an exception should be thrown",
          () async {
        // Arrange
        when(() => mockHttpClient.get(
              Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
            )).thenAnswer((invocation) async => Response('{}', 500));
        // Act
        final post = sut.getPost(1);
        // Assert
        expect(post, throwsA(isA<Exception>()));
      });
    });
  });
}
