import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/db_service.dart';

class Notificationn extends StatefulWidget {
  const Notificationn({super.key});

  @override
  State<Notificationn> createState() => _NotificationnState();
}

class _NotificationnState extends State<Notificationn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DBService>(builder: (context, service, child) {
        return FutureBuilder(
            future: service.getMyNotification(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = service.notificationList;
              return data.isEmpty
                  ? Center(
                      child: Text("No Notifications"),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(62, 143, 142, 142),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      // maxLines: 1,
                                      data[index].notiMessage,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text(
                                    data[index].date,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                                endIndent: 30,
                                indent: 30,
                              ),
                          itemCount: data.length),
                    );
            });
      }),
    );
  }
}
