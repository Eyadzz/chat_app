class User {
  static const String COLLECTION_NAME = 'User';
  final String id;
  final String username;
  final String email;
  final String password;


  User({required this.id, required this.username, required this.email, required this.password});

  User.fromJson(Map<String, Object?> json) : this(
    id: json['id']! as String,
    username: json['username']! as String,
    email: json['email']! as String,
    password: json['password']! as String
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}