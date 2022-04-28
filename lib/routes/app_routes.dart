
import 'package:get/get.dart';
import 'package:my_bili/common/constants.dart';

class AppRoutes{
  /// 登录
  static const String login = "/login";

  /// 注册
  static const String registration = "/registration";

  /// 框架启动
  static const String frame = "/";

  /// 视频详情
  static const String videoDetail = "/videoDetail";

  /// 通知
  static const String notice = "/notice";


  /// 跳转视频详情
  static void toVideoDetail(String vid) {
    Get.toNamed(videoDetail,
        arguments: {Constants.VID: vid}, preventDuplicates: false);
  }

  /// 跳转登录
  static void toLogin() {
    Get.toNamed(login);
  }

  /// 跳转首页
  static void toMain() {
    Get.offAndToNamed(frame);
  }

  // /// 通过url执行相关操作,例如浏览器打开网页
  // static Future<bool>  toUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     return await launch(url);
  //   } else {
  //     return Future.value(false);
  //   }
  // }
}