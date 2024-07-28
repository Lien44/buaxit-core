import 'package:bauxite_admin_app/models/chauffer_model.dart';
import 'package:bauxite_admin_app/models/contract_model.dart';

class ContractDetailModel {
  ContractModel? contract;
  List<Data>? data;

  ContractDetailModel({this.contract, this.data});

  ContractDetailModel.fromJson(Map<String, dynamic> json) {
    contract = json['contract'] != null
        ? ContractModel.fromJson(json['contract'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contract != null) {
      data['contract'] = contract!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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

class Data {
  int? id;
  String? code;
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

  Data(
      {this.id,
      this.code,
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    if (creatorModel != null) {
      data['creator_model'] = creatorModel!.toJson();
    }
    if (contractModel != null) {
      data['contract_model'] = contractModel!.toJson();
    }
    if (chaufferModel != null) {
      data['chauffer_model'] = chaufferModel!.toJson();
    }
    if (carModel != null) {
      data['car_model'] = carModel!.toJson();
    }
    data['car_weight'] = carWeight;
    data['total_weight'] = totalWeight;
    data['metal_weight'] = metalWeight;
    data['actual_weight'] = actualWeight;
    data['clearing_model'] = clearingModel;
    data['status'] = status;
    data['note'] = note;
    data['del'] = del;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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

  CarModel(
      {this.id,
      this.code,
      this.name,
      this.carNumber,
      this.companyId,
      this.note,
      this.del,
      this.createdAt,
      this.updatedAt});

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
    return data;
  }
}
