import 'package:flutter/material.dart';
import 'package:weigh_master/Presentation/home/service/ourcenter.dart';
import 'package:weigh_master/Presentation/home/warranty/warenty_claim.dart';
import 'package:weigh_master/Presentation/home/warranty/warrenty_check.dart';
import 'package:weigh_master/Presentation/home/warranty/warrenty_history.dart';
import 'package:weigh_master/Presentation/setting/feedback.dart';

class WarrantyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: const Color.fromARGB(255, 100, 250, 250),
        title: Text('Warranty'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WarrantyButton(
              imagePath: 'assets/warranty_claim.png',
              text: 'Warranty Claim',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WarrentyClaimPage()));
              },
            ),
            SizedBox(height: 20),
            WarrantyButton(
              imagePath: 'assets/warranty_check.png',
              text: 'Warranty Check',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WarrentyCheckPage()));
              },
            ),
            SizedBox(height: 20),
            WarrantyButton(
              imagePath: 'assets/history.png',
              text: 'Warranty History',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WarrentyHistoryPage()));
              },
            ),
            SizedBox(height: 20),
            WarrantyButton(
              imagePath: 'assets/Our center.png',
              text: 'Our Center',
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CenterPage()));
              },
            ),
            SizedBox(height: 20),
            WarrantyButton(
              imagePath: 'assets/feedback.png',
              text: 'Feedback',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WarrantyButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;
  const WarrantyButton({
    required this.imagePath,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(400, 100)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 60,
            height: 60,
          ),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
