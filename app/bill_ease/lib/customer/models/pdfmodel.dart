class PDFModel {
  String name = "";
  String timestamp = "";
  String ipfsLink = "";
  String total = "";

  PDFModel(
      {required this.name,
      required this.timestamp,
      required this.ipfsLink,
      required this.total});

  factory PDFModel.fromMap(map) {
    return PDFModel(
      name: map['name'],
      total: map['total'],
      ipfsLink: map['ipfsLink'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'total': total,
      'ipfsLink': ipfsLink,
      'timestamp': timestamp,
    };
  }
}
