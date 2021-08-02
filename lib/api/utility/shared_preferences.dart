import 'package:asset_app/api/modal/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('user_Guid', user.user_Guid);
    prefs.setString('full_name', user.full_name);
    prefs.setString('email', user.email);
    prefs.setString('phone', user.phone);
    prefs.setString('created_at', user.created_at);
    prefs.setString('token', user.token);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String user_Guid = prefs.getString("user_Guid");
    String full_name = prefs.getString("full_name");
    String email = prefs.getString("email");
    String phone = prefs.getString("phone");
    String created_at = prefs.getString("created_at");
    String token = prefs.getString("token");
    String renewalToken = prefs.getString("renewalToken");

    return User(
      user_Guid: user_Guid,
      full_name: full_name,
      email: email,
      phone: phone,
      created_at: created_at,
      token: token,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('user_Guid');
    prefs.remove('full_name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('created_at');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
