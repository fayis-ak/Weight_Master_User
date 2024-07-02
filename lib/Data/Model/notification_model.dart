class NotificationModel {
  String uid;
  String notiMessage;
  String? notiId;
  String date;

  NotificationModel(
      {required this.date,
       this.notiId,
      required this.notiMessage,
      required this.uid});

  Map<String, dynamic> toJson(id) =>
      {"uid": uid, "notiMessage": notiMessage, "notiId": id, "date": date};

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        date: json["date"],
        notiId: json["notiId"],
        notiMessage: json["notiMessage"],
        uid: json["uid"]);
  }
}
