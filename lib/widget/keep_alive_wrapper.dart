import 'package:flutter/material.dart';

/// 保持界面状态
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); //这句话需要
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
