class Sosmed {
  int? id;
  String? dataKeys;
  DataValues? dataValues;
  String? createdAt;
  String? updatedAt;

  Sosmed(
      {this.id,
      this.dataKeys,
      this.dataValues,
      this.createdAt,
      this.updatedAt});

  Sosmed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataKeys = json['data_keys'];
    dataValues = json['data_values'] != null
        ? new DataValues.fromJson(json['data_values'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_keys'] = this.dataKeys;
    if (this.dataValues != null) {
      data['data_values'] = this.dataValues!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DataValues {
  String? socialIcon;
  String? url;

  DataValues({this.socialIcon, this.url});

  DataValues.fromJson(Map<String, dynamic> json) {
    socialIcon = json['social_icon'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['social_icon'] = this.socialIcon;
    data['url'] = this.url;
    return data;
  }
}
