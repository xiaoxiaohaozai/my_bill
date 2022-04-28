import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../widget/custom_refresh/custom_refresh.dart';
import '../../../widget/state_wrapper.dart';
import '../../../widget/video_card.dart';
import 'tab_logic.dart';

// 首页非推荐Tab页
class TabPage extends StatelessWidget {
  String name;
  late TabLogic logic;

  TabPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //每个Tab 绑定不同的TabLogic
    logic = Get.put(TabLogic(name: name), tag: name);
    return Obx(() => StateWrapper(
          state: logic.loadState.value,
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
            child: CustomRefresh<TabLogic>(
              tag: name,
              child: MasonryGridView.count(
                  itemCount: logic.videoList.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.h,
                  crossAxisSpacing: 5.w,
                  itemBuilder: (context, index) {
                    return _buildVideoCard(index);
                  }),
            ),
          ),
        ));
  }

  Widget _buildVideoCard(int index) {
    return VideoCard(videoMo: logic.videoList[index]);
  }
}
