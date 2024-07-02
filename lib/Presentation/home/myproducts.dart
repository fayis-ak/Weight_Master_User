// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weigh_master/Data/Model/buy_product_model.dart';
// import 'package:weigh_master/Data/db_service.dart';

// import 'buy.dart';

// class MyProductsPage extends StatefulWidget {
//   late final Product product;
//   @override
//   _MyProductsPageState createState() => _MyProductsPageState();
// }

// class _MyProductsPageState extends State<MyProductsPage> {
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Products'),
//         backgroundColor: const Color.fromARGB(255, 163, 255, 255),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildTabItem(0, 'Bought'),
//                 _buildTabItem(1, 'Rented'),
//               ],
//             ),
//             Expanded(
//               child: selectedIndex == 0
//                   ? _buildProductList('Bought Products', 0)
//                   : _buildProductList('Rented Products', 1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabItem(int index, String text) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedIndex = index;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
//         decoration: BoxDecoration(
//           color: selectedIndex == index ? Colors.black : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: selectedIndex == index ? Colors.white : Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProductList(String title, int type) {
//     List<BuyProductModel> data = [];
//     return Consumer<DBService>(builder: (context, service, child) {
//       return FutureBuilder(
//           future: service.getMyBroughtProduct(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             if (type == 0) {
//               data = service.listOfBuy
//                   .where((element) => element.productModel.type == "Buy")
//                   .toList();
//             } else {
//               data = service.listOfBuy
//                   .where((element) => element.productModel.type == "Rent")
//                   .toList();
//             }

//             log(service.listOfBuy.length.toString());
//             return data.isEmpty
//                 ? const Center(
//                     child: Text("No Products"),
//                   )
//                 : ListView.separated(
//                     separatorBuilder: (context, index) => SizedBox(
//                       height: 20,
//                     ),
//                     itemCount: data.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         color: const Color.fromARGB(14, 8, 126, 139),
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 5.0, horizontal: 10.0),
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 100.0,
//                               height: 100.0,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                       data[index].productModel.image),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                             ),
//                             const SizedBox(width: 10.0),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     data[index].productModel.name,
//                                     style: const TextStyle(
//                                         fontSize: 18.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   const SizedBox(height: 5.0),
//                                   Text(
//                                     data[index].productModel.discription,
//                                     style: const TextStyle(
//                                         fontSize: 16.0, color: Colors.grey),
//                                   ),
//                                   const SizedBox(height: 5.0),
//                                   Text(
//                                     '\$ ${data[index].totalAmount.toString()}',
//                                     style: const TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//           });
//     });
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/Model/buy_product_model.dart';
import 'package:weigh_master/Data/db_service.dart';

import 'buy.dart';

class MyProductsPage extends StatefulWidget {
  late final Product product;

  @override
  _MyProductsPageState createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        backgroundColor: const Color.fromARGB(255, 163, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabItem(0, 'Bought'),
                _buildTabItem(1, 'Rented'),
              ],
            ),
            Expanded(
              child: selectedIndex == 0
                  ? _buildProductList('Bought Products', 0)
                  : _buildProductList('Rented Products', 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String text) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
          decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductList(String title, int type) {
    List<BuyProductModel> data = [];
    return Consumer<DBService>(builder: (context, service, child) {
      return FutureBuilder(
        future: service.getMyBroughtProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (type == 0) {
            data = service.listOfBuy
                .where((element) => element.productModel.type == "Buy")
                .toList();
          } else {
            data = service.listOfBuy
                .where((element) => element.productModel.type == "Rent")
                .toList();
          }

          log(service.listOfBuy.length.toString());
          return data.isEmpty
              ? const Center(
                  child: Text("No Products"),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
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
                                image: NetworkImage(
                                    data[index].productModel.image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].productModel.name,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  data[index].productModel.discription,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  '\$ ${data[index].totalAmount.toString()}',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      );
    });
  }
}
