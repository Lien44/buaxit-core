class MineralModel {
  int? id;
  String? name;
  String? address;
  String? createdAt;
  String? updatedAt;

  MineralModel(
      {this.id, this.name, this.address, this.createdAt, this.updatedAt});

  MineralModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    if (id != null) data['id'] = id.toString();
    data['name'] = name ?? '';
    data['address'] = address ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    return data;
  }
}
