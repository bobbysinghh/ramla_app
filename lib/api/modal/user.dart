class User {
  String user_Guid;
  String full_name;
  String email;
  String phone;
  String created_at;
  String token;

  User({
    this.user_Guid,
    this.full_name,
    this.email,
    this.phone,
    this.created_at,
    this.token,
  });

  // now create converter

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      user_Guid: responseData['user_Guid'],
      full_name: responseData['full_name'],
      email: responseData['email'],
      phone: responseData['phone'],
      created_at: responseData['created_at'],
      token: responseData['token'],
    );
  }
}
