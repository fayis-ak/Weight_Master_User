import 'package:weigh_master/Presentation/setting/feedback.dart';

class FeedbackModel {
  String uid;
  String? feedbackid;
  String username;
  String email;
  String experience;

  String suggession;
  FeedbackModel(
      {required this.email,
      required this.experience,
       this.feedbackid,
      required this.suggession,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson(id) {
    return {
      "uid": uid,
      "feedbackid": id,
      "username": username,
      "email": email,
      "experience": experience,
      "suggession": suggession
    };
  }

  factory FeedbackModel.fromjson(Map<String, dynamic> json) {
    return FeedbackModel(
        email: json["email"],
        experience: json["experience"],
        feedbackid: json["feedbackid"],
        suggession: json["suggession"],
        uid: json["uid"],
        username: json["username"]);
  }
}
