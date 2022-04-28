import 'package:flutter/material.dart';

import '../res/colors.dart';

/// 顶部通用切换组件
class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;
  final Color labelColor; //选中颜色
  final Color unselectedLabelColor; //未选中颜色
  final double borderWidth; //指示器高度
  final double insets; //指示器左右间距
  final double fontSize; //标签文字大小

  const HiTab(this.tabs, this.controller,
      {Key? key,
      this.labelColor = ColorRes.color_232323,
      this.unselectedLabelColor = ColorRes.color_AAAAB9,
      this.borderWidth = 2,
      this.insets = 15,
      this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //通过theme 去除点击水波纹效果
    return Theme(
        data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: TabBar(
          tabs: tabs,
          controller: controller,
          labelColor: labelColor,
          labelStyle: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.w500, height: 1.1),
          unselectedLabelColor: unselectedLabelColor,
          isScrollable: true,
          indicator: UnderlineTabIndicator(
              borderSide:
                  BorderSide(color: ColorRes.color_232323, width: borderWidth),
              insets: EdgeInsets.symmetric(horizontal: insets)),
        ));
  }
}
