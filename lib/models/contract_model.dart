class ContractModel {
  int? id;
  String? code;
  CompanyId? companyId;
  String? currentWeight;
  String? actualWeight;
  String? totalWeight;
  String? shippingPriceCal;
  String? weightPriceCal;
  String? startDate;
  String? endDate;
  int? status;
  String? note;
  String? createdAt;
  String? updatedAt;

  ContractModel(
      {this.id,
      this.code,
      this.companyId,
      this.currentWeight,
      this.actualWeight,
      this.totalWeight,
      this.shippingPriceCal,
      this.weightPriceCal,
      this.startDate,
      this.endDate,
      this.status,
      this.note,
      this.createdAt,
      this.updatedAt});

  ContractModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    companyId = json['company_id'] != null
        ? CompanyId.fromJson(json['company_id'])
        : null;
    currentWeight = json['current_weight'].toString();
    actualWeight = json['Actual_weight'].toString();
    totalWeight = json['total_weight'].toString();
    shippingPriceCal = json['shipping_price_cal'].toString();
    weightPriceCal = json['weight_price_cal'].toString();
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
    data['actual_weight'] = actualWeight;
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
