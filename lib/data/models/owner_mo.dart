/// name : "等待独白的戏"
/// face : "https://o.devio.org/images/o_as/avatar/tx18.jpeg"
/// fans : 224648757

class OwnerMo {
  OwnerMo({
    String? name,
    String? face,
    int? fans,}){
    _name = name;
    _face = face;
    _fans = fans;
  }

  OwnerMo.fromJson(dynamic json) {
    _name = json['name'];
    _face = json['face'];
    _fans = json['fans'];
  }
  String? _name;
  String? _face;
  int? _fans;

  String? get name => _name;
  String? get face => _face;
  int? get fans => _fans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['face'] = _face;
    map['fans'] = _fans;
    return map;
  }

}