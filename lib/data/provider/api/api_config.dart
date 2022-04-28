
/// 配置
class ApiConfig {
  final String baseUrl;
  final int connectTimeout;
  final int receiveTimeout;
  final int sendTimeout;
  final Map<String, dynamic>? headers;
  final String? cookiesPath;
  final String? cachePath;
  final bool showLog;

  ApiConfig(
      {required this.baseUrl,
      this.headers,
      this.cookiesPath,
      this.cachePath,
      this.showLog = true,
      this.connectTimeout = 10000,
      this.receiveTimeout = 10000,
      this.sendTimeout = 10000});
}
