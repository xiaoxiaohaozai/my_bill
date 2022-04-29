import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/colors.dart';

/// 弹幕输入框
class BarrageInput extends StatelessWidget {
  //点击
  final VoidCallback? onTabClose;

  const BarrageInput({Key? key, required this.onTabClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          if (onTabClose != null) onTabClose!();
          Navigator.of(context).pop();
          return false;
        },
        child: Column(
          children: [
            //空白区域点击关闭弹框
            Expanded(
              child: GestureDetector(
                onTap: () {
                  //通知外部
                  if (onTabClose != null) onTabClose!();
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    _buildInput(editingController, context),
                    _buildSendBtn(editingController, context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 自定义输入框
  _buildInput(TextEditingController editingController, BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10.h, bottom: 10.w),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20).r),
        child: TextField(
          autofocus: true,
          controller: editingController,
          onSubmitted: (value) {
            _send(value, context);
          },
          cursorColor: ColorRes.color_232323,
          decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5)
                      .r,
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
              hintText: "发个友善的弹幕见证当下"),
        ),
      ),
    );
  }

  ///发送消息
  void _send(String text, BuildContext context) {
    if (text.isNotEmpty) {
      if (onTabClose != null) onTabClose!();
      Navigator.pop(context, text);
    }
  }

  /// 发送按钮
  _buildSendBtn(TextEditingController editingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = editingController.text.trim();
        _send(text, context);
      },
      child: Container(
        padding: const EdgeInsets.all(10).r,
        child: const Icon(Icons.send_rounded, color: Colors.grey),
      ),
    );
  }
}
