class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? token;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.token,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'], // nullable
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'token': token,
    };
  }
}
