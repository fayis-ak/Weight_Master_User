import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master/Data/db_service.dart';
import 'package:weigh_master/Data/Model/product_model.dart';
import 'package:weigh_master/Presentation/cart/payment.dart';
import 'package:weigh_master/Presentation/home/rent.dart';

class ProductRentPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductRentPage({Key? key, required this.productModel})
      : super(key: key);

  @override
  _ProductRentPageState createState() => _ProductRentPageState();
}

class _ProductRentPageState extends State<ProductRentPage> {
  int quantity = 1;
  bool isLiked = false;

  void incrementQuantity() {
    setState(() {
      if (quantity < 15) {
        quantity++;
      }
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18 / 13,
                  child: Container(
                    color: Colors.grey[300],
                    child: Image.network(
                      widget.productModel.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("User Collection")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("My Fav")
                        .doc(widget.productModel.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.data() != null) {
                          isLiked = true;
                        } else {
                          isLiked = false;
                          log("oop");
                        }

                        return IconButton(
                          icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border),
                          onPressed: () {
                            if (snapshot.data!.data() != null) {
                              DBService().removeFromMyFav(
                                  widget.productModel.id, false);
                            } else {
                              DBService().addToMyFav(widget.productModel);
                            }

                            // setState(() {
                            //   isLiked = !isLiked;
                            // });
                            // print(
                            //     'Product ${widget.productModel.name} ${isLiked ? 'liked' : 'unliked'}');
                          },
                        );
                      } else {
                        return SizedBox();
                      }
                    })
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              widget.productModel.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '\$${double.parse(widget.productModel.rate).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: decrementQuantity,
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 20.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: incrementQuantity,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentPage(
                        fromCart: false,
                        productModel: [widget.productModel],
                        amount: double.parse(widget.productModel.rate) *
                            quantity)));
                print('prodcutModel added to cart');
              },
              child: Text('Proceed for Rent'),
            ),
          ],
        ),
      ),
    );
  }
}
