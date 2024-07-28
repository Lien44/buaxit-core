class DailyDashModel {
  String? date;
  String? totalWeight;

  DailyDashModel({this.date, this.totalWeight});

  DailyDashModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalWeight = json['total_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['total_weight'] = totalWeight;
    return data;
  }
}
