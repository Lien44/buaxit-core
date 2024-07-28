class DashboardModel {
  String? totalSendWeight;
  String ? totalContractGovermentWeight;
  String? totalContracts;
  String? totalCalWeight;
  String? totalActualWeight;
  String? totalCalPrice;
  String? totalScan;

  DashboardModel(
      {this.totalSendWeight,
      this.totalContractGovermentWeight,
      this.totalContracts,
      this.totalCalWeight,
      this.totalActualWeight,
      this.totalCalPrice,
      this.totalScan});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    totalSendWeight = json['total_send_weight'].toString();
    totalContractGovermentWeight = json['total_contract_goverment_wieght'].toString();
    totalContracts = json['total_contracts'].toString();
    totalCalWeight = json['total_cal_weight'].toString();
    totalActualWeight = json['total_actuals_weight'].toString();
    totalCalPrice = json['total_cal_price'].toString();
    totalScan = json['total_scan'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_send_weight'] = totalSendWeight;
    data['total_contract_goverment_wieght'] = totalContractGovermentWeight;
    data['total_contracts'] = totalContracts;
    data['total_cal_weight'] = totalCalWeight;
    data['total_actuals_weight'] = totalActualWeight;
    data['total_cal_price'] = totalCalPrice;
    data['total_scan'] = totalScan;
    return data;
  }
}
