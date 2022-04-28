import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bili/common/app_ext.dart';

import '../../data/models/category_mo.dart';
import '../../data/models/home_mo.dart';
import '../../data/repositories/bili_repository.dart';

class HomeLogic extends GetxController with GetTickerProviderStateMixin {

  late TabController tabController;

  // 第一个tab的数据
  late HomeMo homeMo;

  //分类标题
  var tabs = RxList<CategoryMo>();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onReady() {
    loadHome();
    super.onReady();
  }

  void loadHome() {
    asyncRequest(
      () => BiliRepository.to.loadHomeCategory("推荐", 1),
      onSuccess: (data) {
        homeMo = HomeMo.fromJson(data);
        tabController = TabController(length: homeMo.categoryList!.length, vsync: this);
        tabs.value = homeMo.categoryList!;
      },
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
