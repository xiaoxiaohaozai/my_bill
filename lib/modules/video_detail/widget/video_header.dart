
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_bili/common/utils/loading.dart';

import '../../../common/utils/format_util.dart';
import '../../../common/utils/image_utils.dart';
import '../../../data/models/owner_mo.dart';
import '../../../res/colors.dart';

/// 视频详情头
class VideoHeader extends StatelessWidget {
  OwnerMo ownerMo;

  VideoHeader(this.ownerMo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //头像
                ClipRRect(
                  borderRadius: BorderRadius.circular(15).r,
                  child: cachedImage(ownerMo.face!, width: 30, height: 30),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ownerMo.name!),
                      Text(
                        '${countFormat(ownerMo.fans!)}粉丝',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                Loading.toast("暂不支持");
              },
              color: ColorRes.color_232323,
              height: 26.h,
              minWidth: 45.w,
              child: Text(
                "+ 关注",
                style: TextStyle(color: Colors.white, fontSize: 12.sp,height: 1.1),
              ),
            )
          ],
        ));
  }
}
