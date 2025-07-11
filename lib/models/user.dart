class User {
  final String id;
  final String username;
  final String email;
  final String? bio;
  final String? avatar;
  final String? banner;
  final List<String> sports;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.bio,
    this.avatar,
    this.banner,
    this.sports = const [],
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'],
      email: json['email'],
      bio: json['bio'],
      avatar: json['avatar'],
      banner: json['banner'],
      sports: (json['sports'] as String?)?.split(',') ?? [],
      tags: (json['tags'] as String?)?.split(',') ?? [],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bio': bio,
      'avatar': avatar,
      'banner': banner,
      'sports': sports.join(','),
      'tags': tags.join(','),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
