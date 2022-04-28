import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 登录效果
class LoginEffect extends StatelessWidget {
  final bool protect;

  const LoginEffect(this.protect, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          _image(false),
        ],
      ),
    );
  }

  /// 图片
  _image(bool isLeft) {
    var leftImage = protect
        ? 'assets/images/head_left_protect.png'
        : 'assets/images/head_left.png';
    var rightImage = protect
        ? 'assets/images/head_right_protect.png'
        : 'assets/images/head_right.png';
    return Image(
      height: 90.h,
      image: AssetImage(isLeft ? leftImage : rightImage),
    );
  }
}
