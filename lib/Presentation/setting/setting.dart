import 'package:flutter/material.dart';
import 'package:weigh_master/Logic/auth_service.dart';
import 'package:weigh_master/Presentation/home/myproducts.dart';
import 'package:weigh_master/Presentation/home/service/ourcenter.dart';
import 'package:weigh_master/Presentation/home/warranty/warrenty_history.dart';
import 'package:weigh_master/Presentation/message/notification.dart';
import 'package:weigh_master/Presentation/setting/feedback.dart';
import 'package:weigh_master/Presentation/setting/profile.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSectionTitle('Profile'),
          _buildListItem(Icons.account_circle, 'Edit Profile', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }),
          _buildListItem(Icons.assignment, 'View Warranty', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WarrentyHistoryPage()),
            );
          }),
          _buildListItem(Icons.settings, 'Service Center', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CenterPage()),
            );
          }),
          _buildListItem(Icons.notifications, 'Notifications', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notificationn()),
            );
          }),
          _buildListItem(Icons.shopping_bag, 'My Products', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyProductsPage()),
            );
          }),
          // _buildListItem(Icons.history, 'My Activity', () {}),
          // _buildListItem(Icons.color_lens, 'Theme', () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => FeedbackPage()),
          // );
          // }),

          _buildListItem(Icons.feedback, 'Feedback', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedbackPage()),
            );
          }),
          _buildListItem(Icons.logout, 'Sign Out', () {
            AuthService().sighout(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => FeedbackPage()),
            // );
          }),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
