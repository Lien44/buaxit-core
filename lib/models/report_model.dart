class ReportModel {
  List<Data>? data;
  num? totalWeightAll;
  num? totalWeightSuccess;
  num? metalPriceAll;
  num? servicePriceAll;
  num? totalPriceAll;

  ReportModel(
      {this.data,
      this.totalWeightAll,
      this.totalWeightSuccess,
      this.metalPriceAll,
      this.servicePriceAll,
      this.totalPriceAll});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    totalWeightAll = num.parse(json['total_weight_all'].toString());
    totalWeightSuccess = num.parse(json['total_weight_success'].toString());
    metalPriceAll = num.parse(json['metal_price_all'].toString());
    servicePriceAll = num.parse(json['service_price_all'].toString());
    totalPriceAll = num.parse(json['total_price_all'].toString());
  }
}

class Data {
  ContractId? contractId;
  String? totalMetalWeight;
  String? totalPrice;
  String? servicePrice;
  String? metalPrice;

  Data(
      {this.contractId,
      this.totalMetalWeight,
      this.totalPrice,
      this.servicePrice,
      this.metalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    contractId = json['contract_id'] != null
        ? ContractId.fromJson(json['contract_id'])
        : null;
    totalMetalWeight = json['total_metal_weight'];
    totalPrice = json['total_price'];
    servicePrice = json['service_price'];
    metalPrice = json['metal_price'];
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
