/// id : "10"
/// sticky : 1
/// type : "recommend"
/// title : "好课推荐"
/// subtitle : "Flutter高级进阶实战 仿哔哩哔哩APP"
/// url : "https://coding.imooc.com/class/487.html"
/// cover : "https://szimg.mukewang.com/60497caf0971842912000676.jpg"
/// createTime : "2021-10-11 10:54:35"

class BannerMo {
  BannerMo({
    String? id,
    int? sticky,
    String? type,
    String? title,
    String? subtitle,
    String? url,
    String? cover,
    String? createTime,}){
    _id = id;
    _sticky = sticky;
    _type = type;
    _title = title;
    _subtitle = subtitle;
    _url = url;
    _cover = cover;
    _createTime = createTime;
  }

  BannerMo.fromJson(dynamic json) {
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