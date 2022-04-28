
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_bili/routes/app_pages.dart';
import 'package:my_bili/routes/app_routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// app 启动时启动的第一个组件
class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 屏幕适配组件
    return ScreenUtilInit(
        designSize: const Size(375, 797),
        builder: (context) {
          // 刷新组件
          return RefreshConfiguration(
              headerBuilder: () => const ClassicHeader(),
              footerBuilder: () => const ClassicFooter(),
              child: GetMaterialApp(
                //全局loading
                builder: EasyLoading.init(),
                initialRoute: AppRoutes.login,
                getPages: AppPages.pages,
              ));
        });
  }
}
