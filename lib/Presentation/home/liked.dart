import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/db_service.dart';

class ViewLikedPage extends StatelessWidget {
  const ViewLikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 100, 250, 250),
        automaticallyImplyLeading: false,
        title: const Text('My Favorate'),
      ),
      body: Consumer<DBService>(builder: (context, service, child) {
        return FutureBuilder(
            future: service.getMyAllFav(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // if (snapshot.hasData) {
              final data = service.favList;
              return data.isEmpty
                  ? const Center(
                      child: Text(
                        "No Favorates",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          // final product = products[index];
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
                                      image: NetworkImage(data[index].image),
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data[index].name,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                service.removeFromMyFav(
                                                    data[index].id, true);
                                              },
                                              icon: Icon(Icons.remove))
                                        ],
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        data[index].discription,
                                        style: const TextStyle(
                                            fontSize: 16.0, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        '\$ ${data[index].rate.toString()}',
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
                      ),
                    );
              // } else {
              //   return const Center(child: Text("Loading..."));
            });
      }),
    );
  }
}
