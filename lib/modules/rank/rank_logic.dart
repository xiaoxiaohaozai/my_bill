
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 排行首页逻辑
class RankLogic extends GetxController with GetTickerProviderStateMixin {
  static const tabs = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"}
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
