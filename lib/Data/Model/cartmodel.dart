import 'package:weigh_master/Data/Model/product_model.dart';

class CartModel {
  String ?id;
  ProductModel productModel;
  int quantity;

  CartModel(
      { this.id, required this.productModel, required this.quantity});

  Map<String, dynamic> toJson(productId) => {
        "id": productId,
        "productModel": productModel.toHson(productId),
        "quantity": quantity
      };

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json["id"],
        productModel: ProductModel.fromJson(json["productModel"]),
        quantity: json["quantity"]);
  }
}
