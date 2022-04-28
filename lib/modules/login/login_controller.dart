import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bili/routes/app_routes.dart';

import '../../common/utils/loading.dart';
import '../../getx/controllers/user.dart';

class LoginController extends GetxController {
  String? userName;
  String? password;

  final protect = false.obs; //是否保护
  final loginEnable = false.obs; //登录按钮是否可用

  void checkInput() {
    bool enable;
    if (GetUtils.isNullOrBlank(userName)! ||
        GetUtils.isNullOrBlank(password)!) {
      enable = false;
    } else {
      enable = true;
    }
    loginEnable.value = enable;
  }

  VoidCallback? loginClick() {
    if (userName == "admin" && password == "123456") {
      UserStore.to.saveLogin();
      AppRoutes.toMain();
    } else {
      // UserStore.to.saveLogin(false);
      Loading.toast("请输入正确用户名,密码");
    }
  }
}
