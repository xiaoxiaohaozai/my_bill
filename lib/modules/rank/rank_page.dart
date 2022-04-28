import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_bili/modules/rank/tab/rank_tab_page.dart';
import 'package:my_bili/widget/custom_top_bar.dart';

import '../../common/utils/view_utils.dart';
import '../../widget/hi_tab.dart';
import '../../widget/keep_alive_wrapper.dart';
import 'rank_logic.dart';

/// 排行首页
class RankPage extends StatelessWidget {
  late RankLogic rankLogic;

  @override
  Widget build(BuildContext context) {
    rankLogic = Get.put(RankLogic());
    return Column(
      children: [
        CustomTopBar(
            child: Container(
          decoration: bottomBoxShadow(context),
          alignment: Alignment.center,
          child: _tabBar(),
        )),
        Expanded(
          child: TabBarView(
            controller: rankLogic.tabController,
            children: RankLogic.tabs
                .map(
                  (tab) => KeepAliveWrapper(
                    child: RankTabPage(
                      sort: tab['key']!,
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  Widget _tabBar() {
    return HiTab(
      RankLogic.tabs
          .map((tab) => Tab(
                text: tab['name'],
              ))
          .toList(),
      rankLogic.tabController,
      fontSize: 14.sp,
      borderWidth: 3.h,
    );
  }
}
