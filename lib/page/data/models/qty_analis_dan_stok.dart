class QtyAnalisStok {
  String? stok;
  String? analisis;

  QtyAnalisStok({this.stok, this.analisis});

  QtyAnalisStok.fromJson(Map<String, dynamic> json) {
    stok = json['stok'].toString();
    analisis = json['analisis'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stok'] = this.stok;
    data['analisis'] = this.analisis;
    return data;
  }
}
