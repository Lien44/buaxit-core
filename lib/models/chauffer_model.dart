import 'package:bauxite_admin_app/models/scan_in_out_log_model.dart';
import 'package:bauxite_admin_app/models/user_model.dart';

class ChaufferModel {
  int? id;
  String? code;
  UserModel? userId;
  CompanyId? companyId;
  String? passport;
  String? dateExpired;
  int? del;
  String? createdAt;
  String? updatedAt;
  CarModel? carmodel;

  ChaufferModel(
      {this.id,
      this.code,
      this.userId,
      this.companyId,
      this.passport,
      this.dateExpired,
      this.del,
      this.createdAt,
      this.updatedAt,
      this.carmodel});

  ChaufferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId =
        json['user_id'] != null ? UserModel.fromJson(json['user_id']) : null;
    companyId = json['company_id'] != null
        ? CompanyId.fromJson(json['company_id'])
        : null;
    passport = json['passport'];
    dateExpired = json['date_expired'];
    del = json['del'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    carmodel = json['carmodel'] != null
        ? CarModel.fromJson(json['carmodel'])
        : null;
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    if (id != null) data['id'] = id.toString();
    if (userId?.id != null) data['user_id'] = userId!.id.toString();

    data['name'] = userId?.name ?? '';
    data['phone'] = userId?.phone ?? '';
    if (userId?.passWord != null) data['password'] = userId?.passWord ?? '';
    data['role_id'] = userId?.roleId.toString() ?? '';
    if (companyId != null) {
      data['company_id'] = companyId!.id.toString();
    }
    data['passport'] = passport ?? '';
    data['date_expired'] = dateExpired ?? '';
   if(carmodel != null) data['car_id'] = carmodel!.id.toString();

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
