class UserModel {
  int? id;
  String? code;
  String? name;
  String? phone;
  int? roleId;
  int? status;
  int? del;
  String? createdAt;
  String? updatedAt;
  String? passWord;

  UserModel(
      {this.id,
      this.code,
      this.name,
      this.phone,
      this.roleId,
      this.status,
      this.del,
      this.createdAt,
      this.updatedAt,
      this.passWord});

  UserModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    if (id != null) data['id'] = id.toString();
    data['name'] = name ?? '';
    data['phone'] = phone ?? '';
    data['role_id'] = roleId.toString();
    if (passWord != null) data['password'] = passWord ?? "";

    return data;
  }
}
