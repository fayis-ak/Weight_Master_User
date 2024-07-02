import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master/Data/db_service.dart';
import 'package:weigh_master/Data/Model/product_model.dart';
import 'package:weigh_master/Presentation/home/productpage.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Cart {
  List<Product> items = [];

  // void addToCart(Product product) {
  //   items.add(product);
  // }

  // void removeProduct(Product product) {
  //   items.remove(product);
  // }
}

class BuyPage extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: DBService().getProducts("Buy"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;

              return Container(
                color: Colors.grey[200],
                child: data.isEmpty
                    ? const Center(
                        child: Text(
                          "No Product",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          // ProductModel.fromJson(data[index].data() as Map<String ,dynamic>);
                          // final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              log(data[index]["id"]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductBuyingPage(
                                        productModel: ProductModel(
                                          warrentyDate: data[index]["warrentyDate"],
                                            discription: data[index]
                                                ["discription"],
                                            image: data[index]["image"],
                                            name: data[index]["name"],
                                            rate:
                                                data[index]["rate"].toString(),
                                            type: data[index]["type"],
                                            id: data[index]["id"]))),
                              );
                            },
                            child: Container(
                              color: const Color.fromARGB(14, 8, 126, 139),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(data[index]["image"]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index]["name"],
                                          style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          data[index]["discription"],
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          '\$ ${data[index]["rate"].toString()}',
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              );
            } else {
              return const Center(child: Text("Loading..."));
            }
          }),
    );
  }
}
