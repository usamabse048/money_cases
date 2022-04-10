import 'package:get/get.dart';
import 'package:money_cases/constants/controllers.dart';
import 'package:money_cases/constants/global_constant.dart';
import 'package:money_cases/models/user_model.dart';
import 'package:money_cases/services/database.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  //String currentUid = "";

  final Database _database = Database();

  RxList<UserModel> allUsers = RxList();
  UserModel currentUser =
      UserModel(uid: "", name: "", phoneNumber: "", email: "", money: {});

  void bindAllUsers() {
    allUsers.bindStream(_database.getAllUsers(GlobalConstant.currentUser.uid));
  }

  @override
  void onInit() async {
    super.onInit();
    bool state = await authController.checkLogingState();

    if (state) {}
  }
}
