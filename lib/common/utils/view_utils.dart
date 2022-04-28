import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../res/colors.dart';
import 'format_util.dart';

///带文字的小图标
List<Widget> smallIconText(IconData iconData, var text) {
  var style = const TextStyle(fontSize: 12, color: Colors.grey, height: 1.1);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      iconData,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      ' $text',
      style: style,
    )
  ];
}

///border线
borderLine(BuildContext context, {bottom = true, top = false, color = ColorRes.color_F5F5F9}) {
  BorderSide borderSide = BorderSide(width: 0.5, color: color);
  return Border(
      bottom: bottom ? borderSide : BorderSide.none,
      top: top ? borderSide : BorderSide.none);
}

///间距
SizedBox hiSpace({double height = 1, double width = 1}) {
  return SizedBox(height: height, width: width);
}

///底部阴影
BoxDecoration? bottomBoxShadow(BuildContext context) {

  return BoxDecoration(color: Colors.white, boxShadow: [
    BoxShadow(
        color: Colors.grey[100]!,
        offset: const Offset(0, 5), //xy轴偏移
        blurRadius: 5.0, //阴影模糊程度
        spreadRadius: 1 //阴影扩散程度
        )
  ]);
}

///主题模式
enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

/// 显示隐藏状态栏
void showStatusBar(bool isShow) {
  if (isShow) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  } else {
    //隐藏状态栏，保留底部按钮栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]); //隐藏状态栏，保留底部按钮栏
  }
}

/// 设置状态栏文字颜色
void setStatusBarColor({
  StatusStyle statusStyle = StatusStyle.DARK_CONTENT,
}) {
  Brightness brightness;
  if (Platform.isIOS) {
    brightness = statusStyle == StatusStyle.LIGHT_CONTENT
        ? Brightness.dark
        : Brightness.light;
  } else {
    brightness = statusStyle == StatusStyle.LIGHT_CONTENT
        ? Brightness.light
        : Brightness.dark;
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: brightness,
    statusBarBrightness: brightness,
  ));
}
