import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:weigh_master/Data/db_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<DBService>(builder: (context, servicer, child) {
        return FutureBuilder(
            future: servicer.fetchCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 60,
                      // backgroundImage: NetworkImage(
                      //     'assets/profile_image.jpg'), // Make sure to provide the correct path to your image asset
                    ),
                    const SizedBox(height: 20),
                    Text(
                      servicer.currentModel!.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // const Text(
                    //   'Software Engineer',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text(servicer.currentModel!.email),
                    ),
                    // const ListTile(
                    //   leading: Icon(Icons.phone),
                    //   title: Text('+1 (123) 456-7890'),
                    // ),
                    servicer.currentModel!.address == ""
                        ? SizedBox()
                        : ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(servicer.currentModel!.address),
                          ),
                    const SizedBox(height: 20),
                    servicer.currentModel!.address == ""
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: addressController,
                                  onFieldSubmitted: (value) {},
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                      hintText: "Address",
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    servicer
                                        .editProfile(addressController.text);
                                  },
                                  child: Text("Submit"))
                            ],
                          )
                        : SizedBox()
                    // SizedBox()
                    //     : ElevatedButton(
                    //         onPressed: () {
                    //           // Add functionality for edit button
                    //         },
                    //         child: const Text('Add Address'),
                    //       ),
                  ],
                ),
              );
              // } else {
              //   return const Center(
              //     child: Text("error"),
              //   );
              // }
            });
      }),
    );
  }
}

// class ProfileBody extends StatelessWidget {
//   const ProfileBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData getTheme() {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
