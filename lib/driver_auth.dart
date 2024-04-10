// DriverAuth.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin_signup/driver_page.dart';
import 'package:signin_signup/driver_signin.dart';


class DriverAuth extends StatelessWidget {
  const DriverAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return DriverSignIn();
            }
            return DriverPage(); // Redirect to driver's homepage or dashboard
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
