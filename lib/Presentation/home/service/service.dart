import 'package:flutter/material.dart';
import 'package:weigh_master/Presentation/home/service/ourcenter.dart';
import 'package:weigh_master/Presentation/home/service/service_appoinment.dart';
import 'package:weigh_master/Presentation/home/service/service_history.dart';
import 'package:weigh_master/Presentation/setting/feedback.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 100, 250, 250),
        title: const Text('Service '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ServiceButton(
              imagePath: 'assets/service_appointment.png',
              text: 'Service Appointment',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ServiceAppoinmentPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            ServiceButton(
              imagePath: 'assets/history.png',
              text: 'Service History',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceHstoryPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            ServiceButton(
              imagePath: 'assets/Our center.png',
              text: 'Our Center',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CenterPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            ServiceButton(
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

class ServiceButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;
  const ServiceButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(const Size(400, 100)),
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
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
