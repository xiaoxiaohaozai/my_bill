import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading{

  /// 显示loading时,不允许用户交互
  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: text ?? 'Loading...');
  }

  /// 显示提示
  static void toast(String text) {
    EasyLoading.showToast(text,toastPosition: EasyLoadingToastPosition.bottom);
  }

  /// 显示错误
  static void showError([String? error]){
    EasyLoading.showError(error??"未知错误");
  }

  /// 取消loading
  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }
}