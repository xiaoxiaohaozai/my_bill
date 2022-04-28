
import 'package:flutter/material.dart';

import 'application.dart';
import 'common/utils/view_utils.dart';
import 'global.dart';


/// 启动程序
Future<void> main() async{

  // 初始化全局配置
  await Global.init();
  // 启动应用
  runApp(const Application());
  // 沉浸式状态栏
  setStatusBarColor();
}


