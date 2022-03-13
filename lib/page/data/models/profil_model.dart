class ProfilModel {
  int? id;
  int? packageId;
  String? validity;
  String? telegramUsername;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? countryCode;
  String? mobile;
  int? refBy;
  String? balance;
  String? image;
  String? address;
  int? status;
  int? ev;
  int? sv;
  String? verCode;
  String? verCodeSendAt;
  int? ts;
  int? tv;
  String? tsc;
  String? createdAt;
  String? updatedAt;

  ProfilModel(
      {this.id,
      this.packageId,
      this.validity,
      this.telegramUsername,
      this.firstname,
      this.lastname,
      this.username,
      this.email,
      this.countryCode,
      this.mobile,
      this.refBy,
      this.balance,
      this.image,
      this.address,
      this.status,
      this.ev,
      this.sv,
      this.verCode,
      this.verCodeSendAt,
      this.ts,
      this.tv,
      this.tsc,
      this.createdAt,
      this.updatedAt});

  ProfilModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    packageId = json['package_id'] ?? "";
    validity = json['validity'] ?? "";
    telegramUsername = json['telegram_username'] ?? "";
    firstname = json['firstname'] ?? "";
    lastname = json['lastname'] ?? "";
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    countryCode = json['country_code'] ?? "";
    mobile = json['mobile'] ?? "";
    refBy = json['ref_by'] ?? "";
    balance = json['balance'] ?? "";
    image = json['image'] ?? "";
    address = json['address'] ?? "";
    status = json['status'] ?? "";
    ev = json['ev'] ?? "";
    sv = json['sv'];
    verCode = json['ver_code'];
    verCodeSendAt = json['ver_code_send_at'];
    ts = json['ts'];
    tv = json['tv'];
    tsc = json['tsc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_id'] = this.packageId;
    data['validity'] = this.validity;
    data['telegram_username'] = this.telegramUsername;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['ref_by'] = this.refBy;
    data['balance'] = this.balance;
    data['image'] = this.image;
    data['address'] = this.address;
    data['status'] = this.status;
    data['ev'] = this.ev;
    data['sv'] = this.sv;
    data['ver_code'] = this.verCode;
    data['ver_code_send_at'] = this.verCodeSendAt;
    data['ts'] = this.ts;
    data['tv'] = this.tv;
    data['tsc'] = this.tsc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
