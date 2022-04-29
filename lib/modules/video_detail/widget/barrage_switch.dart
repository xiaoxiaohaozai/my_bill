
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/colors.dart';

/// 弹幕组件
class BarrageSwitch extends StatefulWidget {
  ///初始时是否展开
  final bool initSwitch;

  ///是否为输入中
  final bool inputShowing;

  ///输入框切换回调
  final VoidCallback onShowInput;

  ///展开与伸缩状态切换回调
  final ValueChanged<bool> onBarrageSwitch;

  const BarrageSwitch({
    Key? key,
    this.initSwitch = true,
    required this.onShowInput,
    required this.onBarrageSwitch,
    this.inputShowing = false,
  }) : super(key: key);

  @override
  State<BarrageSwitch> createState() => _BarrageSwitchState();
}

class _BarrageSwitchState extends State<BarrageSwitch> {
  bool _barrageSwitch = false;

  @override
  void initState() {
    super.initState();
    _barrageSwitch = widget.initSwitch;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.h,
      padding:  const EdgeInsets.only(left: 10, right: 10).r,
      margin:  const EdgeInsets.only(right: 15).r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(15).r),
      child: Row(children: [_buildText(), _buildIcon()]),
    );
  }

  /// 文本
  Widget _buildText() {
    var text = widget.inputShowing ? '弹幕输入中...' : '点我发弹幕';
    return _barrageSwitch
        ? InkWell(
            onTap: (){
              widget.onShowInput();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10).r,
              child: Text(
                text,
                style:  TextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
            ),
          )
        : Container();
  }

  /// 图标
  Widget _buildIcon() {
    return InkWell(
        onTap: () {
          setState(() {
            _barrageSwitch = !_barrageSwitch;
          });
          widget.onBarrageSwitch(_barrageSwitch);
        },
        child: Icon(
          Icons.live_tv_rounded,
          color: _barrageSwitch ? ColorRes.color_232323 : Colors.grey,
        ));
  }
}
