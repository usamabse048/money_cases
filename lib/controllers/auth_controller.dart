import 'package:get/get.dart';
import 'package:money_cases/services/auth.dart';

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
    await _auth.signout();
  }
}
