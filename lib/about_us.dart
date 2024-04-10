import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App logo or image
            Image.asset(
              'images/AppLogo.jpeg',
              width: 150,
            ),
            SizedBox(height: 20),
            // App name and description
            Text(
              'Bus Tracking App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to our bus tracking app. This app helps you track the location of buses in real-time and allows you to generate QR codes for your journey. Simply add your beginning and destination points, and the conductor can scan the QR code to charge you for the journey.',
              textAlign: TextAlign.center, 
            ),
            SizedBox(height: 20),
            // Team or organization information
            Text(
              'Developed by: Your Team/Organization Name',
              style: TextStyle(fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 10),
            Text(
              'Contact us: example@example.com',
              style: TextStyle(fontWeight: FontWeight.bold, ),
            ),
          ],
        ),
      ),
    );
  }
}
