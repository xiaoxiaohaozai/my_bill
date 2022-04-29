import 'dart:convert';


/// 弹幕实体类
class BarrageMo {
  late String content;
  late String vid;
  late int priority;
  late int type;

  BarrageMo(
      {required this.content,
      required this.vid,
      required this.priority,
      required this.type});

  BarrageMo.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    vid = json['vid'];
    priority = json['priority'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['vid'] = vid;
    data['priority'] = priority;
    data['type'] = type;
    return data;
  }

  static List<BarrageMo> fromJsonString(json) {
    List<BarrageMo> list = [];
    if (json is! String || !json.startsWith('[')) {
      print('json is not invalid');
      return [];
    }
    var jsonArray = jsonDecode(json);
    jsonArray.forEach((v) {
      list.add(BarrageMo.fromJson(v));
    });
    return list;
  }
}
