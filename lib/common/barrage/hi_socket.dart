
import 'package:web_socket_channel/io.dart';

import '../constants.dart';
import 'barrage_mo.dart';

/// 定义socket 相关接口
abstract class ISocket {
  ///和服务器建立连接
  ISocket open(String vid);

  ///发送弹幕
  ISocket send(String message);

  ///关闭连接
  void close();

  ///接受弹幕
  ISocket listen(Function(List<BarrageMo> value) callBack);
}

class HiSocket implements ISocket {
  final Map<String, dynamic> headers;
  IOWebSocketChannel? _channel;
  Function(List<BarrageMo> mo)? _callBack;

  ///心跳间隔秒数，根据服务器实际timeout时间来调整，这里Nginx服务器的timeout为60
  final int _intervalSeconds = 50;

  HiSocket(this.headers);

  @override
  void close() {
    if (_channel != null) {
      _channel?.sink.close();
    }
  }

  @override
  ISocket listen(callBack) {
    _callBack = callBack;
    return this;
  }

  @override
  ISocket open(String vid) {
    //建立链接
    _channel = IOWebSocketChannel.connect(
      Constants.BARRAGE_URL + vid,
      headers: headers,
      pingInterval: Duration(seconds: _intervalSeconds),
    );
    //监听服务器返回
    _channel?.stream.handleError((error) {
      print("连接发生错误: $error");
    }).listen((message) {
      _handleMessage(message);
    });
    return this;
  }

  @override
  ISocket send(String message) {
    _channel?.sink.add(message);
    return this;
  }

  ///处理服务端的返回
  void _handleMessage(message) {
    print("服务器返回弹幕: $message");
    var result = BarrageMo.fromJsonString(message);
    if (_callBack != null) {
      _callBack!(result);
    }
  }
}
