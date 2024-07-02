import 'package:weigh_master/Data/Model/product_model.dart';

class BuyProductModel {
  String? buyId;
  ProductModel productModel;
  double totalAmount;
  String uid;
  String boughtDate;
  String renewelDate;
  // int quantity;
  BuyProductModel({
    this.buyId,
    required this.uid,
    required this.boughtDate,
    required this.renewelDate,
    required this.productModel,
    required this.totalAmount,
  });
  Map<String, dynamic> toJson(id) => {
        "buyId": id,
        "boughtDate": boughtDate,
        "renewelDate": renewelDate,
        "uid": uid,
        "productModel": productModel.toHson(productModel.id),
        "totalAmount": totalAmount,
      };

  factory BuyProductModel.fromjson(Map<String, dynamic> json) {
    return BuyProductModel(
        renewelDate: json["renewelDate"],
        boughtDate: json["boughtDate"],
        uid: json["uid"],
        productModel: ProductModel.fromJson(json["productModel"]),
        totalAmount: json["totalAmount"],
        buyId: json["buyId"]);
  }
}
