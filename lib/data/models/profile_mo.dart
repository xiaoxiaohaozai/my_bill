

import 'banner_mo.dart';

/// name : "xiaohao"
/// face : "https://o.devio.org/images/other/fa_avatar.png"
/// fans : 66
/// favorite : 0
/// like : 0
/// coin : 888
/// browsing : 0
/// bannerList : [{"id":"2","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"Flutter从入门到进阶-实战携程网App","url":"https://coding.imooc.com/class/321.html","cover":"https://o.devio.org/images/o_as/other/flutter_321.jpg","createTime":"2020-06-11 23:48:38"},{"id":"8","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"带你解锁React Native开发应用新姿势，一网打尽React Native新版本热门技术","url":"https://coding.imooc.com/class/304.html","cover":"https://o.devio.org/images/other/rn-cover2.png","createTime":"2020-11-04 13:54:06"},{"id":"9","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"移动端普通工程师到架构师的全方位蜕变","url":"http://class.imooc.com/sale/mobilearchitect","cover":"https://o.devio.org/images/other/as-cover.png","createTime":"2021-06-01 11:17:43"},{"id":"10","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"Flutter高级进阶实战 仿哔哩哔哩APP","url":"https://coding.imooc.com/class/487.html","cover":"https://szimg.mukewang.com/60497caf0971842912000676.jpg","createTime":"2021-10-11 10:54:35"}]
/// courseList : [{"name":"移动端架构师","cover":"https://o.devio.org/images/fa/banner/mobilearchitect.png","url":"https://class.imooc.com/sale/mobilearchitect","group":1},{"name":"Flutter从基础到进阶","cover":"https://o.devio.org/images/fa/banner/flutter.png","url":"https://coding.imooc.com/class/321.html","group":1},{"name":"React Native从入门到实战打造高质量上线App","cover":"https://o.devio.org/images/fa/banner/rn.png","url":"https://coding.imooc.com/class/304.html","group":2},{"name":"Flutter 实战哔哩哔哩","cover":"https://o.devio.org/images/fa/banner/fa.png","url":"https://coding.imooc.com/class/487.html","group":2}]
/// benefitList : [{"name":"交流群","url":"660782755"},{"name":"问答区","url":"https://coding.imooc.com/class/487.html"},{"name":"电子书","url":"https://www.imooc.com/t/4951150#Article"}]

class ProfileMo {
  ProfileMo({
    String? name,
    String? face,
    int? fans,
    int? favorite,
    int? like,
    int? coin,
    int? browsing,
    List<BannerMo>? bannerList,
    List<CourseList>? courseList,
    List<BenefitList>? benefitList,
  }) {
    _name = name;
    _face = face;
    _fans = fans;
    _favorite = favorite;
    _like = like;
    _coin = coin;
    _browsing = browsing;
    _bannerList = bannerList;
    _courseList = courseList;
    _benefitList = benefitList;
  }

  ProfileMo.fromJson(dynamic json) {
    _name = json['name'];
    _face = json['face'];
    _fans = json['fans'];
    _favorite = json['favorite'];
    _like = json['like'];
    _coin = json['coin'];
    _browsing = json['browsing'];
    if (json['bannerList'] != null) {
      _bannerList = [];
      json['bannerList'].forEach((v) {
        _bannerList?.add(BannerMo.fromJson(v));
      });
    }
    if (json['courseList'] != null) {
      _courseList = [];
      json['courseList'].forEach((v) {
        _courseList?.add(CourseList.fromJson(v));
      });
    }
    if (json['benefitList'] != null) {
      _benefitList = [];
      json['benefitList'].forEach((v) {
        _benefitList?.add(BenefitList.fromJson(v));
      });
    }
  }

  String? _name;
  String? _face;
  int? _fans;
  int? _favorite;
  int? _like;
  int? _coin;
  int? _browsing;
  List<BannerMo>? _bannerList;
  List<CourseList>? _courseList;
  List<BenefitList>? _benefitList;

  String? get name => _name;

  String? get face => _face;

  int? get fans => _fans;

  int? get favorite => _favorite;

  int? get like => _like;

  int? get coin => _coin;

  int? get browsing => _browsing;

  List<BannerMo>? get bannerList => _bannerList;

  List<CourseList>? get courseList => _courseList;

  List<BenefitList>? get benefitList => _benefitList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['face'] = _face;
    map['fans'] = _fans;
    map['favorite'] = _favorite;
    map['like'] = _like;
    map['coin'] = _coin;
    map['browsing'] = _browsing;
    if (_bannerList != null) {
      map['bannerList'] = _bannerList?.map((v) => v.toJson()).toList();
    }
    if (_courseList != null) {
      map['courseList'] = _courseList?.map((v) => v.toJson()).toList();
    }
    if (_benefitList != null) {
      map['benefitList'] = _benefitList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "交流群"
/// url : "660782755"

class BenefitList {
  BenefitList({
    String? name,
    String? url,
  }) {
    _name = name;
    _url = url;
  }

  BenefitList.fromJson(dynamic json) {
    _name = json['name'];
    _url = json['url'];
  }

  String? _name;
  String? _url;

  String? get name => _name;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['url'] = _url;
    return map;
  }
}

/// name : "移动端架构师"
/// cover : "https://o.devio.org/images/fa/banner/mobilearchitect.png"
/// url : "https://class.imooc.com/sale/mobilearchitect"
/// group : 1

class CourseList {
  CourseList({
    String? name,
    String? cover,
    String? url,
    int? group,
  }) {
    _name = name;
    _cover = cover;
    _url = url;
    _group = group;
  }

  CourseList.fromJson(dynamic json) {
    _name = json['name'];
    _cover = json['cover'];
    _url = json['url'];
    _group = json['group'];
  }

  String? _name;
  String? _cover;
  String? _url;
  int? _group;

  String? get name => _name;

  String? get cover => _cover;

  String? get url => _url;

  int? get group => _group;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['cover'] = _cover;
    map['url'] = _url;
    map['group'] = _group;
    return map;
  }
}
