import 'package:money_cases/models/user_model.dart';
import 'package:money_cases/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalConstant {
  static late SharedPreferences sharedPreferences;
  static late UserModel currentUser;
  static Database _database = Database();

  static void getSharedPrefrence() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void getCurrentUser(String uid) async {
    currentUser = await _database.getCurrentUser(uid);
  }
}
