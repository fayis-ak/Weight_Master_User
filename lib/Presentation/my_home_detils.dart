import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/db_service.dart';
import 'package:weigh_master/Presentation/home/buy.dart';
import 'package:weigh_master/Presentation/home/liked.dart';
import 'package:weigh_master/Presentation/home/more.dart';
import 'package:weigh_master/Presentation/home/myproducts.dart';
import 'package:weigh_master/Presentation/home/renewaldate.dart';
import 'package:weigh_master/Presentation/home/rent.dart';
import 'package:weigh_master/Presentation/home/service/service.dart';
import 'package:weigh_master/Presentation/home/warranty/warranty.dart';

class MyHomeDetails extends StatefulWidget {
  const MyHomeDetails({Key? key}) : super(key: key);

  @override
  State<MyHomeDetails> createState() => _MyHomeDetailsState();
}

class _MyHomeDetailsState extends State<MyHomeDetails> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _imageUrls = [
    'assets/offer.jpg',
    'assets/offer2.jpg',
    'assets/offer3.jpg',
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _startAutoScroll();
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  // void _startAutoScroll() {
  //   Timer.periodic(const Duration(seconds: 6), (timer) {
  //     if (_currentPage < _imageUrls.length - 1) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }
  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: CarouselSlider(
                items: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      _imageUrls[0],
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      _imageUrls[1],
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      _imageUrls[2],
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
                options: CarouselOptions(
                  // height: 400,
                  // aspectRatio: 16 / 9,
                  // viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
          ) // SizedBox(
          //   height: 200,
          //   child: PageView.builder(
          //     controller: _pageController,
          //     itemCount: _imageUrls.length,
          //     itemBuilder: (context, index) {
          //       return Image.asset(
          //         _imageUrls[index],
          //         fit: BoxFit.fill,
          //       );
          //     },
          //     onPageChanged: (int page) {
          //       setState(() {
          //         _currentPage = page;
          //       });
          //     },
          //   ),
          // ),,
          ,
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/buy.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BuyPage(),
                          ),
                        );
                      },
                    ),
                    const Text('BUY'),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/rent.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RentPage(),
                          ),
                        );
                      },
                    ),
                    const Text('RENT'),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/like.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewLikedPage()));
                      },
                    ),
                    const Text('   Liked \nProducts'),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/more.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const More(),
                          ),
                        );
                      },
                    ),
                    const Text('MORE'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/Myproduct.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyProductsPage(),
                          ),
                        );
                      },
                    ),
                    const Text('Product \n   Info'),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/renewaldate.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RenewalDatePage(),
                          ),
                        );
                      },
                    ),
                    const Text('Renewal \n   Date'),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/service1.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ServicePage(),
                          ),
                        );
                      },
                    ),
                    const Text('Service'),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/warrantyy.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WarrantyPage(),
                          ),
                        );
                      },
                    ),
                    const Text('Warranty'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Consumer<DBService>(builder: (context, servicer, child) {
            return FutureBuilder(
                future: servicer.getDataForHomeDisplay(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // return Center(
                  //   child: Container(
                  //     color: const Color.fromARGB(255, 235, 202, 202),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Colors.white,
                  //           width: 2,
                  //         ),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Column(
                  //               children: [
                  //                 Container(
                  //                   width: 200,
                  //                   height: 93,
                  //                   color: Colors.orange,
                  //                   child: Center(
                  //                     child: Text(
                  //                       '${servicer.warrentyCount} Warranty',
                  //                       style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 15,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 20,
                  //                 ),
                  //                 Container(
                  //                   width: 200,
                  //                   height: 63,
                  //                   color: Colors.orange,
                  //                   child: Center(
                  //                     child: Text(
                  //                       '${servicer.serviceitem} Service',
                  //                       style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 15,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             Column(
                  //               children: [
                  //                 Container(
                  //                   width: 200,
                  //                   height: 90,
                  //                   color: Colors.orange,
                  //                   child: Center(
                  //                     child: Text(
                  //                       '${servicer.totalProduct} My products',
                  //                       style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 15,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 20,
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Container(
                  //                       width: 100,
                  //                       height: 63,
                  //                       color: Colors.orange,
                  //                       child: Center(
                  //                         child: Text(
                  //                           '${servicer.buyed} Buyed',
                  //                           style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 15,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       width: 100,
                  //                       height: 63,
                  //                       color: Colors.orange,
                  //                       child: Center(
                  //                         child: Text(
                  //                           '${servicer.rented} Rented',
                  //                           style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 15,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );
                  return Center(
                    child: Container(
                      color: const Color.fromARGB(255, 235, 202, 202),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 93,
                                      color: Colors.orange,
                                      child: Center(
                                        child: Text(
                                          '${servicer.warrentyCount} Warranty',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 200,
                                      height: 63,
                                      color: Colors.orange,
                                      child: Center(
                                        child: Text(
                                          '${servicer.serviceitem} Service',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 90,
                                      color: Colors.orange,
                                      child: Center(
                                        child: Text(
                                          '${servicer.totalProduct} My products',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 63,
                                            color: Colors.orange,
                                            child: Center(
                                              child: Text(
                                                '${servicer.buyed} Buyed',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 63,
                                            color: Colors.orange,
                                            child: Center(
                                              child: Text(
                                                '${servicer.rented} Rented',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
        ],
      ),
    );
  }
}
