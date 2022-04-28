import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/base/controllers/base_page_controller.dart';

/// 自定义refresh
class CustomRefresh<T extends BasePageController> extends StatelessWidget {
  late T controller;

  final Widget child;

  ///是否启用上拉
  final bool enablePullUp = true;

  ///是否启用下拉
  final bool enablePullDown = true;

  // 用于区分Controller
  final String? tag;

  CustomRefresh({Key? key, required this.child, this.tag}) : super(key: key) {
    controller = GetInstance().find<T>(tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      enablePullUp: enablePullUp,
      enablePullDown: enablePullDown,
      onLoading: controller.onLoading,
      onRefresh: controller.onRefresh,
      child: child,
    );
  }
}
