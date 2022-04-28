import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class FrameLogic extends GetxController {
  late PageController pageController =  PageController();
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
