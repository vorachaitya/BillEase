// ignore_for_file: non_constant_identifier_names

class ProductModel {
  String product_name;
  String barcode_id;
  int quantity;

  ProductModel(
      {required this.barcode_id,
      required this.product_name,
      required this.quantity});
}
