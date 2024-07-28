class CarsModel {
  int? id;
  String? code;
  String? name;
  String? carNumber;
  CompanyId? companyId;
  String? note;
  int? del;
  String? createdAt;
  String? updatedAt;
  String? tisNumber;

  CarsModel(
      {this.id,
      this.code,
      this.name,
      this.carNumber,
      this.companyId,
      this.note,
      this.del,
      this.createdAt,
      this.updatedAt,
      this.tisNumber});

  CarsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    carNumber = json['car_number'];
    companyId = json['company_id'] != null
        ? CompanyId.fromJson(json['company_id'])
        : null;
    note = json['note'];
    del = json['del'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tisNumber = json['tis_number'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    if (id != null) data['id'] = id.toString();
    data['name'] = name ?? '';
    data['car_number'] = carNumber ?? '';
    if (companyId != null) {
      data['company_id'] = companyId!.id.toString();
    }
    data['note'] = note ?? '';
    data['tis_number'] = tisNumber ?? '';
    return data;
  }
}

class CompanyId {
  int? id;
  String? code;
  String? name;
  int? proId;
  int? disId;
  int? vilId;
  String? note;
  int? del;
  String? createdAt;
  String? updatedAt;

  CompanyId(
      {this.id,
      this.code,
      this.name,
      this.proId,
      this.disId,
      this.vilId,
      this.note,
      this.del,
      this.createdAt,
      this.updatedAt});

  CompanyId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    proId = json['pro_id'];
    disId = json['dis_id'];
    vilId = json['vil_id'];
    note = json['note'];
    del = json['del'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['pro_id'] = proId;
    data['dis_id'] = disId;
    data['vil_id'] = vilId;
    data['note'] = note;
    data['del'] = del;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
