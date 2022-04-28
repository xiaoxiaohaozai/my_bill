import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../../common/utils/image_utils.dart';
import '../../../data/models/banner_mo.dart';

/// 首页推荐页轮播图
class RecommendBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsets? padding;

  const RecommendBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    return Swiper(
      key: UniqueKey(),
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _item(bannerList[index]);
      },
      //自定义指示器
      pagination: const SwiperPagination(
          alignment: Alignment.bottomRight,
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6)),
    );
  }

  _item(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
       // Routes.toUrl(bannerMo.url!);
      },
      child: Container(
        padding: padding,
        //圆角
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)).r,
          child: cachedImage(
            bannerMo.cover ?? "",
          ),
        ),
      ),
    );
  }
}
