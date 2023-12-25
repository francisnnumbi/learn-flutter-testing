import 'dart:convert';

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? website;

  User({this.id, this.name, this.email, this.website});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      website: map['website'] ?? '',
    );
  }

  User copyWith({int? id, String? name, String? email, String? website}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        website: website ?? this.website,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'website': website,
      };

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, website: $website}';
  }
}
