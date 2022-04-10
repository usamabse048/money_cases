import 'package:get/get.dart';
import 'package:money_cases/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final Auth _auth = Auth();

  void signup(
      {required String email,
      required String password,
      required String phoneNumber,
      required String name}) async {
    await _auth.signup(
        email: email, password: password, phoneNumber: phoneNumber, name: name);
  }

  void signin({
    required String email,
    required String password,
  }) async {
    await _auth.signin(email: email, password: password);
  }

  void signout() async {
    clearData();
    await _auth.signout();
  }

 Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
 
    return   prefs.getString("uid");
  }

  Future<bool> checkLogingState() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey("uid");
  }

  void clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
