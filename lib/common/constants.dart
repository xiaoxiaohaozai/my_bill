class Constants {
  /// ---------------- 缺省页 ----------------
  static const EMPTY = 0;
  static const SUCCESS = 1;
  static const LOADING = 2;
  static const ERROR = 3;

  /// ---------------- 网络 ----------------
  static const BASE_URL = "https://api.devio.org/uapi";
  // static const BASE_URL = "http://localhost:8080/uapi";
  static const BARRAGE_URL = "wss://api.devio.org/uapi/fa/barrage/";

  //用户登录后,产生的令牌
  static const BOARDING_PASS = "33665CA3F23FEFE277A747A423BD9D43AF";
  static const COURSE_FLAG = "fa";

  //请求接口需要的token,定期修改,先本地写死
  static const AUTH_TOKEN = "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa";

  // socket 请求头
  static barrageHeaders() {
    Map<String, dynamic> header = {
      "auth-token": AUTH_TOKEN,
      "course-flag": COURSE_FLAG,
      "boarding-pass": BOARDING_PASS
    };
    return header;
  }

  /// ---------------- 常量 ----------------
  static const VID = "vid";
  static const IS_LOGIN = "isLogin";
}
