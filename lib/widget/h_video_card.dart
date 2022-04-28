import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/utils/format_util.dart';
import '../common/utils/image_utils.dart';
import '../common/utils/view_utils.dart';
import '../data/models/video_mo.dart';
import '../res/colors.dart';
import '../res/res.dart';

class HVideoCard extends StatelessWidget {
  final VideoMo videoMo;

  const HVideoCard({Key? key, required this.videoMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Routes.toVideoDetail(videoMo.vid!);
      },
      child: Container(
        decoration:
            BoxDecoration(color: Colors.white, border: borderLine(context)),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        height: 137.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoMo.title!,
                    maxLines: 3,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: ColorRes.color_232323,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2).r,
                        decoration: BoxDecoration(
                            color: ColorRes.color_232323,
                            borderRadius: BorderRadius.circular(2).r),
                        child: Text(
                          "Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        videoMo.owner!.name!,
                        style: TextStyle(
                            color: ColorRes.color_6D7278, fontSize: 12.sp),
                      )
                    ],
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5).r,
                    child: Stack(
                      children: [
                        cachedImage(videoMo.cover!,
                            width: 129.w, height: 80.h, fit: BoxFit.cover),
                        //视频时长
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(4).r,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 2.h),
                              child: Text(durationTransform(videoMo.duration!),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 9.sp)),
                            ))
                      ],
                    )),
                Row(
                  children: [
                    //浏览角标
                    Image.asset(
                      Res.imageViews,
                      width: 14.w,
                      height: 14.w,
                    ),
                    //浏览数

                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      countFormat(videoMo.view!),
                      style: TextStyle(
                          color: ColorRes.color_AAAAB9,
                          fontSize: 10.sp,
                          height: 1.1),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
