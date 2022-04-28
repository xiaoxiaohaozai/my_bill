/// name : "推荐"
/// count : 933

class CategoryMo {
  CategoryList({
    String? name,
    int? count,}){
    _name = name;
    _count = count;
  }

  CategoryMo.fromJson(dynamic json) {
    _name = json['name'];
    _count = json['count'];
  }
  String? _name;
  int? _count;

  String? get name => _name;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['count'] = _count;
    return map;
  }

}