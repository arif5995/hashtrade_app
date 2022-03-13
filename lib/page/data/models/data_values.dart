class DataValues {
  List<String>? hasImage;
  String? title;
  String? descriptionNic;
  String? catatan;
  String? image;

  DataValues(
      {this.hasImage,
      this.title,
      this.descriptionNic,
      this.catatan,
      this.image});

  DataValues.fromJson(Map<String, dynamic> json) {
    hasImage = json['has_image'].cast<String>();
    title = json['title'];
    descriptionNic = json['description_nic'];
    catatan = json['catatan'] ?? "";
    image = json['image'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_image'] = this.hasImage;
    data['title'] = this.title;
    data['description_nic'] = this.descriptionNic;
    data['catatan'] = this.catatan;
    data['image'] = this.image;
    return data;
  }
}
