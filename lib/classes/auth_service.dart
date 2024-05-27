import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> signIn(String username, String password) async {
    // Simulate authentication (replace with actual authentication logic)
    if ((username == 'admin' && password == 'admin')) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userType', username);
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userType');
  }

  Future<String?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  Future<bool> isAdmin() async {
    String? userType = await getUserType();
    return userType == 'admin';
  }

  Future<bool> isCustomer() async {
    String? userType = await getUserType();
    return userType == 'customer';
  }
}

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
