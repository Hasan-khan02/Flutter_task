import 'package:shared_preferences/shared_preferences.dart';

class AuthController{

Future saveLogin() async{

SharedPreferences pref=
await SharedPreferences.getInstance();

await pref.setBool(
"isLoggedIn",
true
);

}

Future logout() async{

SharedPreferences pref=
await SharedPreferences.getInstance();

await pref.clear();

}

Future<bool> checkLogin() async{

SharedPreferences pref=
await SharedPreferences.getInstance();

return pref.getBool(
"isLoggedIn"
) ?? false;

}

}