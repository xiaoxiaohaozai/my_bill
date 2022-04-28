import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/colors.dart';

/// 通用输入框
class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged; //内容
  final ValueChanged<bool>? focusChanged; //焦点改变
  final bool lineStretch; //占满整行
  final bool obscureText; //是否是密码
  final TextInputType? keyboardType; //输入类型

  const LoginInput(this.title, this.hint,
      {Key? key,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType})
      : super(key: key);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  //焦点
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (widget.focusChanged != null) {
        //通知焦点变化
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.w),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            _input()
          ],
        ),
        //分割线
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15.w : 0),
          child: Divider(
            height: 1.h,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  //输入框
  _input() {
    return Expanded(
        child: TextField(
      cursorColor: ColorRes.color_232323,
      //游标颜色
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey)),
    ));
  }
}
