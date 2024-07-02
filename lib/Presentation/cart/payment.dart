import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upi_india/upi_exception.dart';
import 'package:upi_india/upi_response.dart';
import 'package:weigh_master/Data/Model/buy_product_model.dart';
import 'package:weigh_master/Data/db_service.dart';
import 'package:weigh_master/Data/Model/product_model.dart';
import 'package:weigh_master/Data/payment_service.dart';
import 'package:weigh_master/Logic/helper.dart';

class PaymentPage extends StatefulWidget {
  bool fromCart = false;
  List<ProductModel> productModel;
  double amount;
  PaymentPage(
      {super.key,
      required this.productModel,
      required this.amount,
      required this.fromCart});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final now = DateTime.now();
  String date = DateFormat("dd/MM/yyyy").format(DateTime.now());
  Future<UpiResponse>? transaction;
  @override
  Widget build(BuildContext context) {
    String dateAfter1Year = DateFormat("dd/MM/yyyy")
        .format(DateTime(now.year + 1, now.month, now.day));

    setState(() {});

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CupertinoColors.black,
      ),
      body: Column(children: [
        Container(
          color: CupertinoColors.black,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Payment',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Make payment',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        FutureBuilder(
          future: PaymentController().initializeUpiIndia(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      PaymentController()
                          .initiateTransaction(context,
                              app: snapshot.data![index],
                              receiverUpiId: recieverUPIID,
                              receiverName: "Weigh Master",
                              amount: widget.amount)
                          .then((value) async {
                        for (var i in widget.productModel) {
                          DBService().afterCompletPayment(BuyProductModel(
                              boughtDate: date,
                              renewelDate: dateAfter1Year,
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              productModel: i,
                              totalAmount: widget.amount));
                          if (widget.fromCart == true) {
                            DBService().removeFromCar();
                          }
                        }

                        log(value.toString());
                        return transaction = value as Future<UpiResponse>?;
                      }).catchError((error) {
                        for (var i in widget.productModel) {
                          // log(date);
                          // log(message)
                          DBService()
                              .afterCompletPayment(BuyProductModel(
                                  boughtDate: date,
                                  renewelDate: dateAfter1Year,
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  productModel: i,
                                  totalAmount: widget.amount))
                              .then((value) {
                            if (widget.fromCart == true) {
                              DBService().removeFromCar();
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Order Successful")));
                          });
                        }
                        log("Error");
                      });
                      log("out");
                    },
                    leading: Image.memory(snapshot.data![index].icon),
                    title: Text(
                      snapshot.data![index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            );
          },
        ),
        FutureBuilder(
            future: transaction,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(_upiErrorHandler(snapshot.error.runtimeType),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ));
                }
                UpiResponse upiResponse = snapshot.data!;

                String txnId = upiResponse.transactionId ?? 'N/A';
                String resCode = upiResponse.responseCode ?? 'N/A';
                String txnRef = upiResponse.transactionRefId ?? 'N/A';
                String status = upiResponse.status ?? 'N/A';
                String approvalRef = upiResponse.approvalRefNo ?? 'N/A';
                _checkTxnStatus(status);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      displayTransactionData('Transaction Id', txnId),
                      displayTransactionData('Response Code', resCode),
                      displayTransactionData('Reference Id', txnRef),
                      displayTransactionData('Status', status.toUpperCase()),
                      displayTransactionData('Approval No', approvalRef),
                    ],
                  ),
                );
              }

              return const Text(
                "",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              );
            }),
        const SizedBox(
          height: 30,
        )
      ]),
    );
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              )),
          Flexible(
              child: Text(
            body,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    );
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }
}
