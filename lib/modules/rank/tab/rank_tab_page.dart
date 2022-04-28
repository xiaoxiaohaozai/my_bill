
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/custom_refresh/custom_refresh.dart';
import '../../../widget/h_video_card.dart';
import '../../../widget/state_wrapper.dart';
import 'rank_tab_logic.dart';

/// 排行tab 页
class RankTabPage extends StatelessWidget {
  final String sort;

  const RankTabPage({required this.sort});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(RankTabLogic(sort: sort), tag: sort);

    return Obx(() => StateWrapper(
        child: CustomRefresh<RankTabLogic>(
          tag: sort,
          child: ListView.builder(
            cacheExtent: 700,
            itemExtent: 137.h,
            itemCount: logic.videoList.length,
            itemBuilder: (BuildContext context, int index) =>
                HVideoCard(videoMo: logic.videoList[index]),
          ),
        ),
        state: logic.loadState.value));
  }
}
