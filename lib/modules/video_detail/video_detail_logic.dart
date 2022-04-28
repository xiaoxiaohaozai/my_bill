import 'package:get/get.dart';
import 'package:my_bili/common/app_ext.dart';
import 'package:my_bili/common/base/controllers/base_empty_controller.dart';
import 'package:my_bili/data/repositories/bili_repository.dart';

import '../../common/constants.dart';
import '../../data/models/video_mo.dart';

class VideoDetailLogic extends BaseEmptyController {
  //视频播放信息,用户信息
  var videoMo = Rx<VideoMo?>(null);

  @override
  void onReady() {
    super.onReady();

    // 获取视频详情
    var arguments = Get.arguments;
    var vid = arguments[Constants.VID];
    asyncRequest(
      () => BiliRepository.to.loadVideoDetail(vid),
      onSuccess: (data) {
        //视频信息
        videoMo.value = data.videoInfo;
      },
    );
  }
}
