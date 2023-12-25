import 'package:http/http.dart' as http;
import 'package:learn_flutter_testing/app/models/post_model.dart';

class PostRepository {
  final http.Client httpClient;

  PostRepository(this.httpClient);

  Future<Post> getPost(int id) async {
    final response = await httpClient
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode == 200) {
      return Post.fromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Post>> getPosts() async {
    final response = await httpClient
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      return Post.postsFromJson(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
