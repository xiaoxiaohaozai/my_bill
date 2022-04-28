import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_bili/modules/login/widget/login_button.dart';
import 'package:my_bili/modules/login/widget/login_effect.dart';
import 'package:my_bili/modules/login/widget/login_input.dart';
import 'package:my_bili/widget/custom_top_bar.dart';

import '../../res/colors.dart';
import '../../res/strings.dart';
import 'login_controller.dart';

/// 登录页
class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTopBar(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Text(
              StringRes.welcome,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorRes.color_232323,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: LoginEffect(controller.protect.value),
              ),
            ),
            LoginInput(
              StringRes.username,
              StringRes.username_hint,
              onChanged: (text) {
                controller.userName = text;
                controller.checkInput();
              },
            ),
            LoginInput(
              StringRes.password,
              StringRes.password_hint,
              obscureText: true,
              onChanged: (text) {
                controller.password = text;
                controller.checkInput();
              },
              focusChanged: (focus) {
                controller.protect.value = focus;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              //响应式监听
              child: Obx(
                () => LoginButton(
                  StringRes.login,
                  enable: controller.loginEnable.value,
                  onPressed: controller.loginClick,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Text(
              "账号 admin , 密码 123456",
              style: TextStyle(color: ColorRes.color_767A7F),
            )
          ],
        ),
      ),
    );
  }
}
