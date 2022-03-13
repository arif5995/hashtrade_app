class PrivacyPolice {
  String? success;
  List<Message>? message;

  PrivacyPolice({this.success, this.message});

  PrivacyPolice.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  int? id;
  String? dataKeys;
  DataValues2? dataValues2;
  String? createdAt;
  String? updatedAt;

  Message(
      {this.id,
      this.dataKeys,
      this.dataValues2,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataKeys = json['data_keys'];
    dataValues2 = (json['data_values'] != null
        ? new DataValues2.fromJson(json['data_values'])
        : "") as DataValues2?;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_keys'] = this.dataKeys;
    if (this.dataValues2 != null) {
      data['data_values'] = this.dataValues2!.toJson();
    } else {
      data['data_values'] = "";
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DataValues2 {
  String? title;
  String? details;

  DataValues2({this.title, this.details});

  DataValues2.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['details'] = this.details;
    return data;
  }
}
