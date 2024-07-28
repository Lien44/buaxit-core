// ignore_for_file: unnecessary_overrides, hash_and_equals

class ProvinceModel {
  int? id;
  String? name;
  ProvinceModel({this.id, this.name});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  ProvinceModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  @override
  // ignore: todo
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}

class DistrictsModel {
  int? id;
  int? proId;
  String? name;
  DistrictsModel({
    this.id,
    this.proId,
    this.name,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;
  DistrictsModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    proId = data['pro_id'];
    name = data['name'];
  }

}

class VillagesModel {
  int? id;
  int? proId;
  int? disId;
  String? name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;
  VillagesModel({
    this.id,
    this.proId,
    this.disId,
    this.name,
  });
  VillagesModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    proId = data['pro_id'];
    disId = data['dis_id'];
    name = data['name'];
  }

}
