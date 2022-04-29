import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bili/modules/frame/widget/lottie_bottom_bar.dart';
import 'package:my_bili/modules/home/home_page.dart';
import 'package:my_bili/modules/rank/rank_page.dart';
import 'package:my_bili/res/strings.dart';

import '../../common/utils/view_utils.dart';
import '../../res/res.dart';
import '../../widget/keep_alive_wrapper.dart';
import 'frame_logic.dart';

/// 主框架
class FramePage extends StatelessWidget {
  const FramePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var logic = Get.put(FrameLogic());
    return Material(
        child: Column(
      children: [
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: logic.pageController,
            children: [
              KeepAliveWrapper(
                child: HomePage(),
              ),
              KeepAliveWrapper(
                child: RankPage(),
              ),
            ],
          ),
        ),
        LottieBottomBar(
          [
            LottieItem(StringRes.home, Res.lottieBottomTab1),
            LottieItem(StringRes.rank, Res.lottieBottomTab2),
          ],
          currentIndex: 0,
          onBottomItemChanged: (index) {
            logic.pageController.jumpToPage(index);
          },
        )
      ],
    ));
  }
}
