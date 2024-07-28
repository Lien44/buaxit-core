import 'package:bauxite_admin_app/models/scan_in_out_model.dart';

class ClearingHistoryModel {
  List<Data>? data;
  num? metalWeight;
  num? metalPrice;
  num? servicePrice;
  num? totalPrice;

  ClearingHistoryModel(
      {this.data,
      this.metalWeight,
      this.metalPrice,
      this.servicePrice,
      this.totalPrice});

  ClearingHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    metalWeight = num.parse(json['metal_weight'].toString());
    metalPrice = num.parse(json['metal_price'].toString());
    servicePrice = num.parse(json['service_price'].toString());
    totalPrice = num.parse(json['total_price'].toString());
  }
}

class Data {
  int? id;
  String? code;
  ContractId? contractId;
  List<ScanInOutModel> scanDetail = [];
  int? qty;
  String? totalMetalWeight;
  String? metalPrice;
  String? servicePrice;
  String? totalPrice;
  int? status;
  String? note;
  String? createdAt;
  String? updatedAt;
  String? calPrice;
  String? calWeight;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];

    for (var element in json['scan_detail']) {
      scanDetail.add(ScanInOutModel.fromJson(element));
    }
    contractId = json['contract_id'] != null
        ? ContractId.fromJson(json['contract_id'])
        : null;
    qty = json['qty'];
    totalMetalWeight = json['total_metal_weight'];
    metalPrice = json['metal_price'];
    servicePrice = json['service_price'];
    totalPrice = json['total_price'];
    status = json['status'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    calPrice = json['cal_price'];
    calWeight = json['cal_weight'];
  }
}

class ContractId {
  int? id;
  String? code;
  CompanyId? companyId;
  String? currentWeight;
  String? totalWeight;
  String? shippingPriceCal;
  String? weightPriceCal;
  String? startDate;
  String? endDate;
  int? status;
  String? note;
  String? createdAt;
  String? updatedAt;

  ContractId(
      {this.id,
      this.code,
      this.companyId,
      this.currentWeight,
      this.totalWeight,
      this.shippingPriceCal,
      this.weightPriceCal,
      this.startDate,
      this.endDate,
      this.status,
      this.note,
      this.createdAt,
      this.updatedAt});

  ContractId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    companyId = json['company_id'] != null
        ? CompanyId.fromJson(json['company_id'])
        : null;
    currentWeight = json['current_weight'];
    totalWeight = json['total_weight'];
    shippingPriceCal = json['shipping_price_cal'];
    weightPriceCal = json['weight_price_cal'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    if (companyId != null) {
      data['company_id'] = companyId!.toJson();
    }
    data['current_weight'] = currentWeight;
    data['total_weight'] = totalWeight;
    data['shipping_price_cal'] = shippingPriceCal;
    data['weight_price_cal'] = weightPriceCal;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['note'] = note;
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
