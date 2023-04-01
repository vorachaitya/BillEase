// ignore_for_file: hash_and_equals

class ItemModel {
  String barCode;
  String name;
  String price;
  String? qt;

  ItemModel(
      {required this.barCode,
      required this.name,
      required this.price,
      this.qt});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    String barCode = json.keys.first;
    List<String> values = json[barCode];
    return ItemModel(barCode: barCode, name: values[0], price: values[1]);
  }

  @override
  int get hashCode => int.parse(barCode);
}
