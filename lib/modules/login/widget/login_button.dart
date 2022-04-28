import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/colors.dart';

/// 登录按钮
class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LoginButton(this.title, {Key? key, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //widthFactor占满父控件的宽度
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6).r),
        height: 45,
        onPressed: enable ? onPressed : null,
        //按钮颜色
        disabledColor: Colors.grey,
        color: ColorRes.color_232323,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
      ),
    );
  }
}
