import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master/Data/Model/cartmodel.dart';
import 'package:weigh_master/Data/db_service.dart';
import 'package:weigh_master/Data/Model/product_model.dart';
import 'package:weigh_master/Presentation/cart/cart.dart';
import 'package:weigh_master/Presentation/cart/proceed_payment.dart';
import 'package:weigh_master/Presentation/home/buy.dart';

class ProductBuyingPage extends StatefulWidget {
  final ProductModel productModel;
  final Cart cart = Cart();

  ProductBuyingPage({Key? key, required this.productModel}) : super(key: key);

  @override
  _ProductBuyingPageState createState() => _ProductBuyingPageState();
}

class _ProductBuyingPageState extends State<ProductBuyingPage> {
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

  // void addToCart() {
  //   widget.cart.addToCart(widget.product);
  //   print('Product added to cart: ${widget.product.name}');
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => CartPage(cart: widget.cart)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
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
                    }),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              widget.productModel.name,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '\$${widget.productModel.rate}',
                      style: const TextStyle(
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
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: incrementQuantity,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      log(widget.productModel.id.toString());
                      DBService()
                          .addProductToCart(CartModel(
                              productModel: widget.productModel,
                              quantity: quantity))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Add to cart successful")));
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(350, 50)),
                    ),
                    child:
                        const Text('Add to Cart', textAlign: TextAlign.center),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProceedpayemtPage(
                                productModel: widget.productModel,
                                quantity: quantity,
                              )));
                      print('Product bought');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green, // Adjust the color as needed
                    ),
                    child: const Text('Buy', textAlign: TextAlign.center),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
