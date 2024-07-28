import 'package:bauxite_admin_app/models/land_model.dart';

class CompanyModel {
  int? id;
  String? code;
  String? name;
  ProvinceModel? proId;
  DistrictsModel? disId;
  VillagesModel? vilId;
  String? note;
  int? del;
  String? updatedAt;
  String? createdAt;
  String? countryName;
  String? proName;
  String? disName;
  String? vilName;

  CompanyModel(
      {this.id,
      this.code,
      this.name,
      this.proId,
      this.disId,
      this.vilId,
      this.note,
      this.del,
      this.updatedAt,
      this.createdAt,
      this.countryName,
      this.proName,
      this.disName,
      this.vilName});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    proId =
        json['pro_id'] != null ? ProvinceModel.fromMap(json['pro_id']) : null;
    disId =
        json['dis_id'] != null ? DistrictsModel.fromMap(json['dis_id']) : null;
    vilId =
        json['vil_id'] != null ? VillagesModel.fromMap(json['vil_id']) : null;
    note = json['note'];
    del = json['del'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    countryName = json['country_name'];
    proName = json['pro_name'];
    disName = json['dis_name'];
    vilName = json['vil_name'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    if (id != null) data['id'] = id.toString();
    data['name'] = name ?? '';
    if (proId != null) {
      data['pro_id'] = proId!.id.toString();
    }
    if (disId != null) {
      data['dis_id'] = disId!.id.toString();
    }
    if (vilId != null) {
      data['vil_id'] = vilId!.id.toString();
    }
    data['country_name'] = countryName ?? '';
    data['pro_name'] = proName ?? '';
    data['dis_name'] = disName ?? '';
    data['vil_name'] = vilName ?? '';
    data['note'] = note ?? '';
    return data;
  }
}
