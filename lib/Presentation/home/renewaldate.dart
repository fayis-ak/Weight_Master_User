import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/db_service.dart';

class RenewalDatePage extends StatelessWidget {
  const RenewalDatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weigh Machine Renewal'),
        backgroundColor: const Color.fromARGB(255, 163, 255, 255),
      ),
      body: Consumer<DBService>(builder: (context, service, child) {
        return FutureBuilder(
            future: service.getMyBroughtProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = service.listOfBuy;
              return service.listOfBuy.isEmpty
                  ? const Center(
                      child: Text("No Product"),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          height: 100,
                          color: const Color.fromARGB(185, 239, 247, 255),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                    data[index].productModel.image),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].productModel.name,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    "Date :${data[index].renewelDate}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: data.length);
            });
      }),
    );
  }
}
