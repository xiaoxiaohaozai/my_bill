import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'application.dart';
import 'common/utils/view_utils.dart';
import 'global.dart';

/// 启动程序
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //启动页
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // 初始化全局配置
  await Global.init();
  // 启动应用
  runApp( Application());
  //关闭启动页
  FlutterNativeSplash.remove();
}
