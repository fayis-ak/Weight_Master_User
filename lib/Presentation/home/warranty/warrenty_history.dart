import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/db_service.dart';

class WarrentyHistoryPage extends StatelessWidget {
  const WarrentyHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warrenty History'),
        backgroundColor: const Color.fromARGB(255, 163, 255, 255),
      ),
      body: Consumer<DBService>(builder: (context, service, child) {
        return FutureBuilder(
            future: service.getcurrentUserWarrentyHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = service.currentUserWarrentyHistory;
              return data.isEmpty
                  ? const Center(
                      child: Text("No Data"),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                      data[index].buymodel.productModel.image),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].buymodel.productModel.name,
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                        "Compalint: ${data[index].additionalComment}"),
                                    Text("Date: ${data[index].date}")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                      itemCount: data.length);
            });
      }),
    );
  }
}
