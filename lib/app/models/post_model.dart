import 'dart:convert';

class Post {
  final String? title;
  final String? body;

  Post({this.title, this.body});

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  Post copyWith({String? title, String? body}) => Post(
        title: title ?? this.title,
        body: body ?? this.body,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'body': body,
      };

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  static List<Post> postsFromJson(String str) =>
      List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

  @override
  String toString() {
    return 'Post{title: $title, body: $body}';
  }
}
