import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_proxy/shelf_proxy.dart';

//前端页面访问本地域名
const String localHost = 'localhost';

//前端页面访问本地端口号
const int localPort = 8080;

//目标域名，这里我们将要请求火狐的这个地址
const String targetUrl = 'https://api.devio.org';

Future main() async {
  var server = await shelf_io.serve(
    proxyHandler(targetUrl),
    localHost,
    localPort,
  );
  // 添加上跨域的这几个header
  server.defaultResponseHeaders.add('Access-Control-Allow-Origin', '*');
  server.defaultResponseHeaders.add('Access-Control-Allow-Credentials', true);

  print('Serving at http://${server.address.host}:${server.port}');
}
