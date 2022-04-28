
import 'owner_mo.dart';

/// id : "204"
/// vid : "BV1M7411w7A8"
/// title : "这才是狂扁小朋友！！！"
/// tname : "单机游戏"
/// url : "https://o.devio.org/files/video/fr-2319746262.mp4"
/// cover : "https://o.devio.org/images/fa/photo-1611095971113-9f7542655338.webp"
/// pubdate : 1582257657
/// desc : "狂扁小朋友，小时候最喜欢的游戏之一\n喜欢的朋友可以三连一波！！！"
/// view : 2711542
/// duration : 20
/// owner : {"name":"等待独白的戏","face":"https://o.devio.org/images/o_as/avatar/tx18.jpeg","fans":224648757}
/// reply : 1709
/// favorite : 25778
/// like : 186352
/// coin : 40601
/// share : 4206
/// createTime : "2020-11-14 19:35:54"
/// size : 6992

class VideoMo {
  VideoMo({
    String? id,
    String? vid,
    String? title,
    String? tname,
    String? url,
    String? cover,
    int? pubdate,
    String? desc,
    int? view,
    int? duration,
    OwnerMo? owner,
    int? reply,
    int? favorite,
    int? like,
    int? coin,
    int? share,
    String? createTime,
    int? size,}){
    _id = id;
    _vid = vid;
    _title = title;
    _tname = tname;
    _url = url;
    _cover = cover;
    _pubdate = pubdate;
    _desc = desc;
    _view = view;
    _duration = duration;
    _owner = owner;
    _reply = reply;
    _favorite = favorite;
    _like = like;
    _coin = coin;
    _share = share;
    _createTime = createTime;
    _size = size;
  }

  VideoMo.fromJson(dynamic json) {
    _id = json['id'];
    _vid = json['vid'];
    _title = json['title'];
    _tname = json['tname'];
    _url = json['url'];
    _cover = json['cover'];
    _pubdate = json['pubdate'];
    _desc = json['desc'];
    _view = json['view'];
    _duration = json['duration'];
    _owner = json['owner'] != null ? OwnerMo.fromJson(json['owner']) : null;
    _reply = json['reply'];
    _favorite = json['favorite'];
    _like = json['like'];
    _coin = json['coin'];
    _share = json['share'];
    _createTime = json['createTime'];
    _size = json['size'];
  }
  String? _id;
  String? _vid;
  String? _title;
  String? _tname;
  String? _url;
  String? _cover;
  int? _pubdate;
  String? _desc;
  int? _view;
  int? _duration;
  OwnerMo? _owner;
  int? _reply;
  int? _favorite;
  int? _like;
  int? _coin;
  int? _share;
  String? _createTime;
  int? _size;

  String? get id => _id;
  String? get vid => _vid;
  String? get title => _title;
  String? get tname => _tname;
  String? get url => _url;
  String? get cover => _cover;
  int? get pubdate => _pubdate;
  String? get desc => _desc;
  int? get view => _view;
  int? get duration => _duration;
  OwnerMo? get owner => _owner;
  int? get reply => _reply;
  int? get favorite => _favorite;
  int? get like => _like;
  int? get coin => _coin;
  int? get share => _share;
  String? get createTime => _createTime;
  int? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['vid'] = _vid;
    map['title'] = _title;
    map['tname'] = _tname;
    map['url'] = _url;
    map['cover'] = _cover;
    map['pubdate'] = _pubdate;
    map['desc'] = _desc;
    map['view'] = _view;
    map['duration'] = _duration;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    map['reply'] = _reply;
    map['favorite'] = _favorite;
    map['like'] = _like;
    map['coin'] = _coin;
    map['share'] = _share;
    map['createTime'] = _createTime;
    map['size'] = _size;
    return map;
  }

}
