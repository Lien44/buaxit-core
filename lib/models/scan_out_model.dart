import 'package:bauxite_admin_app/models/chauffer_model.dart';
import 'package:bauxite_admin_app/models/contract_model.dart';

class ScanOutModel {
  int? id;
  String? code;
  MineralModel? mineralModel;
  CreatorModel? creatorModel;
  ContractModel? contractModel;
  ChaufferModel? chaufferModel;
  CarModel? carModel;
  String? carWeight;
  String? totalWeight;
  String? metalWeight;
  String? actualWeight;
  int? clearingModel;
  int? status;
  String? note;
  int? del;
  String? createdAt;
  String? updatedAt;

  ScanOutModel(
      {this.id,
      this.code,
      this.mineralModel,
      this.creatorModel,
      this.contractModel,
      this.chaufferModel,
      this.carModel,
      this.carWeight,
      this.totalWeight,
      this.metalWeight,
      this.actualWeight,
      this.clearingModel,
      this.status,
      this.note,
      this.del,
      this.createdAt,
      this.updatedAt});

  ScanOutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    mineralModel = json['mineral_model'] != null
        ? MineralModel.fromJson(json['mineral_model'])
        : null;
    creatorModel = json['creator_model'] != null
        ? CreatorModel.fromJson(json['creator_model'])
        : null;
    contractModel = json['contract_model'] != null
        ? ContractModel.fromJson(json['contract_model'])
        : null;
    chaufferModel = json['chauffer_model'] != null
        ? ChaufferModel.fromJson(json['chauffer_model'])
        : null;
    carModel =
        json['car_model'] != null ? CarModel.fromJson(json['car_model']) : null;
    carWeight = json['car_weight'];
    totalWeight = json['total_weight'];
    metalWeight = json['metal_weight'];
    actualWeight = json['actual_weight'];
    clearingModel = json['clearing_model'];
    status = json['status'];
    note = json['note'];
    del = json['del'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};

    data['code'] = code ?? '';
    data['total_weight'] = totalWeight ?? '';
    data['metal_weight'] = metalWeight ?? '';
    data['actual_weight'] = actualWeight ?? '';

    return data;
  }
}

class CreatorModel {
  int? id;
  String? code;
  String? name;
  String? phone;
  int? roleId;
  int? status;
  int? del;
  String? createdAt;
  String? updatedAt;

  CreatorModel(
      {this.id,
      this.code,
      this.name,
      this.phone,
      this.roleId,
      this.status,
      this.del,
      this.createdAt,
      this.updatedAt});

  CreatorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    phone = json['phone'];
    roleId = json['role_id'];
    status = json['status'];
    del = json['del'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['phone'] = phone;
    data['role_id'] = roleId;
    data['status'] = status;
    data['del'] = del;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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

class CarModel {
  int? id;
  String? code;
  String? name;
  String? carNumber;
  int? companyId;
  String? note;
  int? del;
  String? createdAt;
  String? updatedAt;
  String? tisNumber;

  CarModel(
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

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    carNumber = json['car_number'];
    companyId = json['company_id'];
    note = json['note'];
    del = json['del'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tisNumber = json['tis_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['car_number'] = carNumber;
    data['company_id'] = companyId;
    data['note'] = note;
    data['del'] = del;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['tis_number'] = tisNumber;
    return data;
  }
}
