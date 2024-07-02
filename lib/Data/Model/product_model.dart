class ProductModel {
  String? id;
  String name;
  String discription;
  String type;
  String rate;
  String image;
  String warrentyDate;

  ProductModel(
      {required this.discription,
      this.id,
      required this.warrentyDate,
      required this.image,
      required this.name,
      required this.rate,
      required this.type});
  Map<String, dynamic> toHson(id) => {
        "id": id,
        "image": image,
        "name": name,
        "discription": discription,
        "type": type,
        "rate": rate,"warrentyDate":warrentyDate
      };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      warrentyDate: json["warrentyDate"],
        image: json["image"],
        discription: json["discription"],
        id: json["id"],
        name: json["name"],
        rate: json["rate"],
        type: json["type"]);
  }
}
