import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master/Data/Model/cartmodel.dart';
import 'package:weigh_master/Data/Model/product_model.dart';
import 'package:weigh_master/Presentation/cart/payemt_4_cart.dart';
import 'package:weigh_master/Presentation/cart/proceed_payment.dart';
import 'package:weigh_master/Presentation/home/buy.dart';

class CartPage extends StatelessWidget {
  CartPage({
    Key? key,
  }) : super(key: key);
  List<CartModel> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("User Collection")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Cart")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              final data = snapshot.data!.docs;

              list = data.map((e) {
                return CartModel.fromJson(e.data());
              }).toList();

              log(list.length.toString());

              return data.isEmpty
                  ? Center(
                      child: Text("Cart is empty"),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        // final product = cart.items[index];
                        return ListTile(
                          leading: Image.network(
                            data[index]["productModel"]["image"],
                            width: 50,
                            height: 50,
                          ),
                          title: Text(data[index]["productModel"]["name"]),
                          subtitle: Text(
                              '\$${data[index]["productModel"]["rate"]}*${data[index]["quantity"]}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("User Collection")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("Cart")
                                  .doc(data[index].id)
                                  .delete()
                                  .then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Product removed from cart'),
                                ));
                              });
                            },
                          ),
                        );
                      },
                    );
            } else {
              return Center(
                child: Text("Loading.."),
              );
            }
          }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () {
                print(list.length);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProceedPayemntForCart(
                          cartModelList: list,
                        )));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Proceed to purchase'),
                ));
              },
              child: const Text('Proceed to Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}
