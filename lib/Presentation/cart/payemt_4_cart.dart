import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/Model/cartmodel.dart';
import 'package:weigh_master/Data/db_service.dart';
import 'package:weigh_master/Data/Model/product_model.dart';
import 'package:weigh_master/Presentation/cart/payment.dart';

class ProceedPayemntForCart extends StatelessWidget {
  List<CartModel> cartModelList;

  ProceedPayemntForCart({
    super.key,
    required this.cartModelList,
  });
  double totalAmount = 0;
  List<ProductModel> productModelList = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    for (var i in cartModelList) {
      productModelList.add(i.productModel);
      totalAmount += double.parse(i.productModel.rate) * i.quantity;
      log(totalAmount.toString());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proceed Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<DBService>(builder: (context, servive, child) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 2,
                // height: 200,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: size.height * .17,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 139, 171, 179)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                height: size.height * .17,
                                width: size.width * .24,
                                child: Image.network(
                                  cartModelList[index].productModel.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    cartModelList[index].productModel.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22),
                                  ),
                                  Text(
                                    "₹ ${double.parse(cartModelList[index].productModel.rate).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                    itemCount: cartModelList.length),
              ),
              SizedBox(
                height: size.height * .1,
              ),
              Container(
                width: double.infinity,
                height: size.height * .17,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 179, 213, 222)),
                child: FutureBuilder(
                    future: servive.fetchCurrentUser(),
                    builder: (context, snashot) {
                      if (snashot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Shipping Address",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          servive.currentModel!.address == ""
                              ? const Text("Address not Found")
                              : Text(
                                  servive.currentModel!.address,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: size.height * .1,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                height: size.height * .17,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 179, 213, 222)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Invoice Details",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Product Cost :"),
                        Text("₹ ${totalAmount}")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Shipping fee :"), Text("₹ 00.0")],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total :",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "₹ ${totalAmount}",
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: SizedBox(
          height: 70,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      fromCart: true,
                        productModel: productModelList, amount: totalAmount)));
              },
              child: const Text("Proceed to Payment"))),
    );
  }
}
