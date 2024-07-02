import 'package:weigh_master/Data/Model/buy_product_model.dart';

class WarrentyClaimModel {
  String productid;
  String uid;
  String? warrentyId;
  String name;
  String number;
  String email;
  BuyProductModel buymodel;
  String date;
  String additionalComment;
  String status;

  WarrentyClaimModel({
    required this.additionalComment,
    required this.email,
    required this.date,
    required this.buymodel,
    required this.name,
    required this.number,
    required this.productid,
    required this.uid,
    this.warrentyId,
    required this.status,
  });
  Map<String, dynamic> toJson(id, buyid) => {
        "productid": productid,
        "uid": uid,
        "warrentyId": id,
        "name": name,
        "number": number,
        "email": email,
        "buymodel": buymodel.toJson(id),
        "date": date,
        "additionalComment": additionalComment,
        'status': status,
      };

  factory WarrentyClaimModel.fromjson(Map<String, dynamic> json) {
    return WarrentyClaimModel(
      additionalComment: json["additionalComment"],
      email: json["email"],
      date: json["date"],
      buymodel: BuyProductModel.fromjson(json["buymodel"]),
      name: json["name"],
      number: json["number"],
      productid: json["productid"],
      uid: json["uid"],
      warrentyId: json["warrentyId"],
      status: json['status'],
    );
  }
}
