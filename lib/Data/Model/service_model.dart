import 'package:weigh_master/Data/Model/buy_product_model.dart';

class ServiceModel {
  String productid;
  String uid;
  String? serviceId;
  String name;
  String number;
  String email;
  BuyProductModel buymodel;
  String date;
  String compalaint;
  String status;

  ServiceModel({
    required this.compalaint,
    required this.email,
    required this.date,
    required this.buymodel,
    required this.name,
    required this.number,
    required this.productid,
    required this.uid,
    this.serviceId,
    required this.status,
  });
  Map<String, dynamic> toJson(id, buyid) => {
        "productid": productid,
        "uid": uid,
        "serviceId": id,
        "name": name,
        "number": number,
        "email": email,
        "buymodel": buymodel.toJson(id),
        "date": date,
        "compalaint": compalaint,
        'status': status,
      };

  factory ServiceModel.fromjson(Map<String, dynamic> json) {
    return ServiceModel(
      compalaint: json["compalaint"],
      email: json["email"],
      date: json["date"],
      buymodel: BuyProductModel.fromjson(json["buymodel"]),
      name: json["name"],
      number: json["number"],
      productid: json["productid"],
      uid: json["uid"],
      serviceId: json["serviceId"],
      status: json['status']
    );
  }
}
