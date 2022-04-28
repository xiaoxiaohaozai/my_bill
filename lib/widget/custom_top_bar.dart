import 'package:flutter/material.dart';

/// 沉浸式状态栏
class CustomTopBar extends StatelessWidget {
  final Color color;
  final double height; // 实际app 状态栏的高度
  final Widget child;

  const CustomTopBar(
      {Key? key,
      this.color = Colors.white,
      this.height = 44,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    //获取距离顶部的高度,可以空出水滴,刘海的位置
    var top = MediaQuery.of(context).padding.top;
    return Container(
      child: child,
      width: MediaQuery.of(context).size.width,
      height: top + height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
    );
  }

  void _statusBarInit() {
    //changeStatusBar(color: color, statusStyle: statusStyle);
  }
}
