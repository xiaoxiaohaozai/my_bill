/// total : 7
/// list : [{"id":"10","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"Flutter高级进阶实战 仿哔哩哔哩APP","url":"https://coding.imooc.com/class/487.html","cover":"https://szimg.mukewang.com/60497caf0971842912000676.jpg","createTime":"2021-10-11 10:54:35"},{"id":"9","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"移动端普通工程师到架构师的全方位蜕变","url":"http://class.imooc.com/sale/mobilearchitect","cover":"https://o.devio.org/images/other/as-cover.png","createTime":"2021-06-01 11:17:43"},{"id":"8","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"带你解锁React Native开发应用新姿势，一网打尽React Native新版本热门技术","url":"https://coding.imooc.com/class/304.html","cover":"https://o.devio.org/images/other/rn-cover2.png","createTime":"2020-11-04 13:54:06"},{"id":"5","sticky":1,"type":"video","title":"精彩视频推荐","subtitle":"最强自夸王！！！！！","url":"BV1p7411Y7BC","cover":"https://o.devio.org/images/fa/photo-1601513041797-a79a526a521e.webp","createTime":"2021-02-06 00:37:32"},{"id":"4","sticky":1,"type":"video","title":"精彩视频推荐","subtitle":"【派大星的独白】一个关于正常人的故事","url":"BV1qt411j7fV","cover":"https://o.devio.org/images/fa/cat-4098058__340.webp","createTime":"2021-02-06 01:19:14"},{"id":"2","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"Flutter从入门到进阶-实战携程网App","url":"https://coding.imooc.com/class/321.html","cover":"https://o.devio.org/images/o_as/other/flutter_321.jpg","createTime":"2020-06-11 23:48:38"},{"id":"1","sticky":0,"type":"update","title":"有新的更新了","subtitle":"本次更新了第6周，赶快去学习吧","url":"http://class.imooc.com/sale/mobilearchitect","cover":null,"createTime":"2020-06-11 20:06:43"}]

class NoticeListMo {
  NoticeListMo({
    int? total,
    List<NoticeMo>? list,
  }) {
    _total = total;
    _list = list;
  }

  NoticeListMo.fromJson(dynamic json) {
    _total = json['total'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(NoticeMo.fromJson(v));
      });
    }
  }

  int? _total;
  List<NoticeMo>? _list;

  int? get total => _total;

  List<NoticeMo>? get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "10"
/// sticky : 1
/// type : "recommend"
/// title : "好课推荐"
/// subtitle : "Flutter高级进阶实战 仿哔哩哔哩APP"
/// url : "https://coding.imooc.com/class/487.html"
/// cover : "https://szimg.mukewang.com/60497caf0971842912000676.jpg"
/// createTime : "2021-10-11 10:54:35"

class NoticeMo {
  NoticeMo({
    String? id,
    int? sticky,
    String? type,
    String? title,
    String? subtitle,
    String? url,
    String? cover,
    String? createTime,
  }) {
    _id = id;
    _sticky = sticky;
    _type = type;
    _title = title;
    _subtitle = subtitle;
    _url = url;
    _cover = cover;
    _createTime = createTime;
  }

  NoticeMo.fromJson(dynamic json) {
    _id = json['id'];
    _sticky = json['sticky'];
    _type = json['type'];
    _title = json['title'];
    _subtitle = json['subtitle'];
    _url = json['url'];
    _cover = json['cover'];
    _createTime = json['createTime'];
  }

  String? _id;
  int? _sticky;
  String? _type;
  String? _title;
  String? _subtitle;
  String? _url;
  String? _cover;
  String? _createTime;

  String? get id => _id;

  int? get sticky => _sticky;

  String? get type => _type;

  String? get title => _title;

  String? get subtitle => _subtitle;

  String? get url => _url;

  String? get cover => _cover;

  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sticky'] = _sticky;
    map['type'] = _type;
    map['title'] = _title;
    map['subtitle'] = _subtitle;
    map['url'] = _url;
    map['cover'] = _cover;
    map['createTime'] = _createTime;
    return map;
  }
}
