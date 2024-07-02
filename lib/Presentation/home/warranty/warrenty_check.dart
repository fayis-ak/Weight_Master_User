import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/Model/buy_product_model.dart';
import 'package:weigh_master/Data/db_service.dart';

class WarrentyCheckPage extends StatefulWidget {
  WarrentyCheckPage({super.key});

  @override
  State<WarrentyCheckPage> createState() => _WarrentyCheckPageState();
}

class _WarrentyCheckPageState extends State<WarrentyCheckPage> {
  BuyProductModel? selectedModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warrenty Check'),
        backgroundColor: const Color.fromARGB(255, 163, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<DBService>(builder: (context, service, child) {
          return FutureBuilder(
              future: service.getMyBroughtProduct(),
              builder: (context, snaphsot) {
                if (snaphsot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = service.listOfBuy;
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                            hintText: "Select ", border: OutlineInputBorder()),
                        items: data
                            .map((e) => DropdownMenuItem(
                                value: e, child: Text(e.productModel.name)))
                            .toList(),
                        onChanged: (selected) {
                          setState(() {
                            selectedModel = selected;
                          });
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    selectedModel != null
                        ? ExpansionTile(
                            title: Text(
                              selectedModel!.productModel.name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            children: [
                                Image.network(
                                    selectedModel!.productModel.image),
                                Text(
                                  "Warrenty until : ${selectedModel!.productModel.warrentyDate.substring(0, 10)}",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                Text(
                                  "Renewel until : ${selectedModel!.renewelDate}",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                              ])
                        : Expanded(
                            child: Center(
                              child: const Text(
                                "Pick a product from you bought for checking Warrenty",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                  ],
                );
              });
        }),
      ),
    );
  }
}
