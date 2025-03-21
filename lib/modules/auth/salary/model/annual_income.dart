class AnnualIncomeModel {
  int? status;
  AnnualIncomeData? data;

  AnnualIncomeModel({this.status, this.data});

  AnnualIncomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? AnnualIncomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AnnualIncomeData {
  List<AnnualTurnover>? annualTurnover;

  AnnualIncomeData({this.annualTurnover});

  AnnualIncomeData.fromJson(Map<String, dynamic> json) {
    if (json['annual_turnover'] != null) {
      annualTurnover = <AnnualTurnover>[];
      json['annual_turnover'].forEach((v) {
        annualTurnover!.add(AnnualTurnover.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (annualTurnover != null) {
      data['annual_turnover'] = annualTurnover!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnnualTurnover {
  int? id;
  String? value;

  AnnualTurnover({this.id, this.value});

  AnnualTurnover.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    return data;
  }
}
