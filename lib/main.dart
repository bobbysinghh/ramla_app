import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/api/modal/user.dart';
import 'package:asset_app/api/providers/auth_provider.dart';
import 'package:asset_app/api/providers/cart_provider.dart';
import 'package:asset_app/api/providers/suggest_location_provider.dart';
import 'package:asset_app/api/providers/user_provider.dart';
import 'package:asset_app/api/utility/shared_preferences.dart';
import 'package:asset_app/screens/login_screens/log_in.dart';
import 'package:asset_app/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SuggestLocationProvider()),
      ],
      child: MaterialApp(
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data.token == null)
                    return SignInScreen();
                  else
                    Provider.of<UserProvider>(context).setUser(snapshot.data);
                  Config.name = snapshot.data.full_name;
                  Config.fcmToken = snapshot.data.token;
                  Config.email = snapshot.data.email;
                  Config.mobile = snapshot.data.phone;
                  return MainScreen();
              }
            }),
        // home: SplashScreen(),
      ),
    );
  }
}
