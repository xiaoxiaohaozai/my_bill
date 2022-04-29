import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_bili/getx/middlewares/auth_middleware.dart';
import 'package:my_bili/routes/app_routes.dart';

import '../modules/frame/frame_page.dart';
import '../modules/login/login_page.dart';
import '../modules/video_detail/video_detail_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    //首页框架
    GetPage(
      name: AppRoutes.frame,
      page: () => const FramePage(),
      middlewares: [AuthMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.videoDetail,
      page: () => VideoDetailPage(),
    ),
    //登录页
    GetPage(name: AppRoutes.login, page: () => LoginPage())
  ];
}
