import 'package:get/get.dart';

import '../../common/constants.dart';
import '../services/storage_service.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;

  bool get isLogin => _isLogin.value;


  @override
  void onInit() {
    super.onInit();
    _isLogin.value = StorageService.to.getBool(Constants.IS_LOGIN);
  }


  Future<void> saveLogin() async {
    _isLogin.value = true;
    StorageService.to.setBool(Constants.IS_LOGIN, true);
  }

}