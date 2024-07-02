import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weigh_master/Data/Model/buy_product_model.dart';
import 'package:weigh_master/Data/Model/cartmodel.dart';
import 'package:weigh_master/Data/Model/feedback_model.dart';
import 'package:weigh_master/Data/Model/notification_model.dart';
import 'package:weigh_master/Data/Model/product_model.dart';
import 'package:weigh_master/Data/Model/service_model.dart';
import 'package:weigh_master/Data/Model/user_model.dart';
import 'package:weigh_master/Data/Model/warrenty_claim_model.dart';
import 'package:weigh_master/Presentation/setting/feedback.dart';

class DBService with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  Future addUser(uid, UserModel userModel) async {
    db.collection("User Collection").doc(uid).set(userModel.toJson());
  }

  getProducts(String type) {
    return db
        .collection("Product Data")
        .where("type", isEqualTo: type)
        .snapshots();
  }

  Future addProductToCart(CartModel cartModel) async {
    await db
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart")
        .doc(cartModel.productModel.id)
        .set(cartModel.toJson(cartModel.productModel.id));
  }

  UserModel? currentModel;
  fetchCurrentUser() async {
    final snashot = await FirebaseFirestore.instance
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    log(snashot.data()!.toString());
    currentModel = UserModel.fromJson(snashot.data()!);
  }

  editProfile(String name) async {
    await FirebaseFirestore.instance
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"address": name});
    notifyListeners();
  }

  Future afterCompletPayment(BuyProductModel buyProductModel) async {
    final doc = db.collection("My Orders").doc();
    await doc.set(buyProductModel.toJson(doc.id));
    String date = DateFormat("dd/m/yyyy").format(DateTime.now());
    addNotification(NotificationModel(
        date: date,
        notiMessage:
            "Your request for ${buyProductModel.productModel.type} ${buyProductModel.productModel.name} is Done",
        uid: FirebaseAuth.instance.currentUser!.uid));
    // notifyListeners();
  }

  removeFromCar() async {
    final collection = await db
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart")
        .get();
    for (var i in collection.docs) {
      _delete(i);
    }
  }

  _delete(QueryDocumentSnapshot<Map<String, dynamic>> i) {
    db
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart")
        .doc(i.data()["id"])
        .delete();
  }

  addToMyFav(ProductModel productModel) async {
    db
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Fav")
        .doc(productModel.id)
        .set(productModel.toHson(productModel.id));
  }

  removeFromMyFav(id, bool listen) async {
    db
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Fav")
        .doc(id)
        .delete();
    if (listen == true) {
      notifyListeners();
    }
  }

  List<ProductModel> favList = [];
  getMyAllFav() async {
    final snapshot = await db
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Fav")
        .get();
    // log("message");
    // log(snapshot.docs.length.toString());
    favList =
        snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
  }

  Future<bool> checkIsFavOrNot(id) async {
    final snapshot = await db
        .collection("User Collection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Fav")
        .doc(id)
        .get();
    if (snapshot.exists) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  List<BuyProductModel> listOfBuy = [];
  Future getMyBroughtProduct() async {
    final snapshot = await db
        .collection("My Orders")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    // log(snapshot.docs.length.toString());
    listOfBuy = snapshot.docs.map((e) {
      return BuyProductModel.fromjson(e.data());
    }).toList();
    // snapshot.where("productModel",isEqualTo: )
  }

  addFeedBack(FeedbackModel feedbackModel) async {
    final docs = db.collection("Feedback").doc();
    docs.set(feedbackModel.toJson(docs.id));
  }

  List<FeedbackModel> listOFFeedback = [];
  Future getAllFeedBack() async {
    Stream<QuerySnapshot> snapshot = db.collection("Feedback").snapshots();
    // List<FeedbackModel> list = [];
    return snapshot.listen((event) {
      listOFFeedback = event.docs.map((doc) {
        return FeedbackModel.fromjson(doc.data() as Map<String, dynamic>);
      }).toList();
      // notifyListeners();
      // listOFFeedback = List.from(list);
    });
  }

  Future addNewWarrenty(WarrentyClaimModel warrentyClaimModel, buyId) async {
    await db.collection("Warrenty Claim").doc(buyId).set(
        warrentyClaimModel.toJson(buyId, warrentyClaimModel.buymodel.buyId));
    String date = DateFormat("dd/m/yyyy").format(DateTime.now());
    addNotification(NotificationModel(
        date: date,
        notiMessage:
            "Your request for registering warrenty for   ${warrentyClaimModel.buymodel.productModel.name} is Done",
        uid: FirebaseAuth.instance.currentUser!.uid));
  }

  // getDataFroHome(){
  //   return db.collection(collectionPath)
  // }
  List<WarrentyClaimModel> currentUserWarrentyHistory = [];
  Future getcurrentUserWarrentyHistory() async {
    final snap = await db
        .collection("Warrenty Claim")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    log(snap.docs.length.toString());
    currentUserWarrentyHistory =
        snap.docs.map((e) => WarrentyClaimModel.fromjson(e.data())).toList();
  }

  Future addAppoinment(ServiceModel serviceModel, buyId) async {
    await db
        .collection("Service Appoinments")
        .doc(buyId)
        .set(serviceModel.toJson(buyId, serviceModel.buymodel.buyId));
    String date = DateFormat("dd/m/yyyy").format(DateTime.now());
    addNotification(NotificationModel(
        date: date,
        notiMessage:
            "Your request for Service appoinmet on ${serviceModel.date.substring(0, 10)} is Done",
        uid: FirebaseAuth.instance.currentUser!.uid));
  }

  List<ServiceModel> currentUserServiceHistory = [];
  Future getcurrentUserServiceHistory() async {
    final snap = await db
        .collection("Service Appoinments")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    log(snap.docs.length.toString());
    currentUserServiceHistory =
        snap.docs.map((e) => ServiceModel.fromjson(e.data())).toList();
  }

  addNotification(NotificationModel notificationModel) async {
    final docs = db.collection("Notifications").doc();
    docs.set(notificationModel.toJson(docs.id));
  }

  List<NotificationModel> notificationList = [];
  getMyNotification() async {
    final snapshot = await db
        .collection("Notifications")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    notificationList =
        snapshot.docs.map((e) => NotificationModel.fromJson(e.data())).toList();
  }

  int warrentyCount = 0;
  int totalProduct = 0;
  int buyed = 0;
  int rented = 0;
  int serviceitem = 0;
  getDataForHomeDisplay() async {
    //  total profuct count
    final productSnapshot = await db.collection("Product Data").get();
    totalProduct = productSnapshot.docs.length;

    // totsl buy and rent count
    final myorderSnapshot = await db
        .collection("My Orders")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    //buy
    buyed = 0;
    rented = 0;
    for (var i in myorderSnapshot.docs) {
      if (i["productModel"]["type"] == "Buy") {
        // Buy
        buyed++;
      } else {
        //Rent
        rented++;
      }
    }

    // total Services
    final serviceSnapshot = await db
        .collection("Service Appoinments")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    serviceitem = serviceSnapshot.docs.length;

    //  warrenty
    final warrentySnapshot = await db
        .collection("Warrenty Claim")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    warrentyCount = warrentySnapshot.docs.length;
  }
}
