
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bili/modules/video_detail/video_detail_logic.dart';

import '../../common/constants.dart';

class VideoDetailPage extends StatelessWidget {
  late VideoDetailLogic logic;

  var vid = Get.arguments[Constants.VID];

  @override
  Widget build(BuildContext context) {
    // 每个播放器绑定不同的logic
    logic = Get.put(VideoDetailLogic(), tag: vid);
    return Material(child: _testVideoView());
  }

  _testVideoView() {
       return Container();
  }
}
