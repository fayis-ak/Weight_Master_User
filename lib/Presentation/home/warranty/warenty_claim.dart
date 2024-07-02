import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/Model/buy_product_model.dart';
import 'package:weigh_master/Data/Model/warrenty_claim_model.dart';
import 'package:weigh_master/Data/db_service.dart';

class WarrentyClaimPage extends StatelessWidget {
  WarrentyClaimPage({super.key});
  var nameController = TextEditingController();
  var numberController = TextEditingController();

  var emailController = TextEditingController();

  // var invoiceController = TextEditingController();

  var additionalCommentController = TextEditingController();
  BuyProductModel? selectedItemData;
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warrenty Claim'),
        backgroundColor: const Color.fromARGB(255, 163, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),

                Consumer<DBService>(builder: (context, service, child) {
                  return FutureBuilder(
                      future: service.getMyBroughtProduct(),
                      builder: (context, snapshot) {
                        final data = service.listOfBuy;

                        return DropdownButtonFormField(
                            decoration: const InputDecoration(
                                hintText: "Select Product",
                                border: OutlineInputBorder()),
                            items: data
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child:
                                        Text(e.productModel.name.toString())))
                                .toList(),
                            onChanged: (value) {
                              selectedItemData = value!;
                            });
                      });
                }),
                const SizedBox(
                  height: 20,
                ),
                customeTextfield((value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                }, nameController, "Full Name"),
                const SizedBox(
                  height: 20,
                ),
                customeTextfield((value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                }, numberController, "Contact Number",
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                customeTextfield((value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                }, emailController, "Email Address"),
                const SizedBox(
                  height: 20,
                ),
                // customeTextfield((value) {
                //   if (value!.isEmpty) {
                //     return "Field is required";
                //   } else {
                //     return null;
                //   }
                // }, invoiceController, "Invoice Details"),
                // const SizedBox(
                //   height: 20,
                // ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const BeveledRectangleBorder()),
                      onPressed: () async {
                        await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050))
                            .then((value) {
                          selectedDate = value;
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Prefered Date"),
                          Icon(Icons.calendar_month)
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                customeTextfield((value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                }, additionalCommentController, "Additional Comment"),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedItemData != null && selectedDate != null) {
                          DBService()
                              .addNewWarrenty(
                                  WarrentyClaimModel(
                                    additionalComment:
                                        additionalCommentController.text,
                                    email: emailController.text,
                                    date: selectedDate.toString(),
                                    buymodel: selectedItemData!,
                                    name: nameController.text,
                                    number: numberController.text,
                                    productid: selectedItemData!.productModel.id
                                        .toString(),
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                    status: 'Pending',
                                  ),
                                  selectedItemData!.buyId.toString())
                              .then((value) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Successful!")));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content:
                                      Text("Somthing is missing for submit")));
                        }
                      }
                    },
                    child: const Text("Claim Warrenty"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customeTextfield(String? Function(String?)? validator,
      TextEditingController? controller, String? hintText,
      {TextInputType? keyboardType}) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          label: Text(hintText!), border: const OutlineInputBorder()),
    );
  }
}
