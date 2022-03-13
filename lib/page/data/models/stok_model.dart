import 'data_values.dart';

class StokModel {
  int? id;
  String? data_keys;
  DataValues? data_values;
  String? createdAt;
  String? updatedAt;

  StokModel(
      {this.id,
      this.data_keys,
      this.data_values,
      this.createdAt,
      this.updatedAt});

  StokModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    data_keys = map['data_keys'];
    data_values = map['data_values'] != null
        ? new DataValues.fromJson(map['data_values'])
        : null;
    createdAt = map['created_at'];
    updatedAt = map['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_keys'] = this.data_keys;
    if (this.data_values != null) {
      data['data_values'] = this.data_values!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
