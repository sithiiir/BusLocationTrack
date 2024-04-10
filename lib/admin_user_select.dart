import 'package:flutter/material.dart';

import 'package:signin_signup/driver_signup.dart';
import 'package:signin_signup/signup.dart';

class AdminUserSelect extends StatefulWidget {
  @override
  State<AdminUserSelect> createState() => _AdminUserSelectState();
}

class _AdminUserSelectState extends State<AdminUserSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 100),
              Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'nunito_Sans',),
                ),
              ),
              SizedBox(height: 40), // Space between text and logo
              CircleAvatar(
                radius: 100, // Adjust the size of the logo
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    'images/AppLogo.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 50), // Space between logo and button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(217, 27, 27, 55), // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: TextStyle(fontSize: 18, fontFamily: 'nunito_Sans',),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text('Register as User'),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(217, 27, 27, 55), // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: TextStyle(fontSize: 18, fontFamily: 'nunito_Sans',),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DriverSignUP()),
                  );
                },
                child: Text('Register as Driver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
