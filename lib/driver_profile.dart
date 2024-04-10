import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_signup/registered_buses.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  InputDecoration _customDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 208, 203, 203), width: 0.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(217, 27, 27, 55)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      fillColor: const Color.fromARGB(217, 217, 217, 224),
      filled: true,
    );
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("drivers").doc(currentUser?.email).snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final data = snapshot.data!.data() as Map<String,dynamic>;
            return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
                radius: 60, // Adjust the radius for the size of the circle
                backgroundImage: AssetImage('images/driver.jpg'),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true, // Set readOnly to prevent user editing
                decoration: _customDecoration('Username'),
                initialValue: data['username'], // Replace with actual username
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true, // Set readOnly to prevent user editing
                decoration: _customDecoration('Name'),
                initialValue:data['firstName'], // Replace with actual name
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true, // Set readOnly to prevent user editing
                decoration: _customDecoration('Address'),
                initialValue: data['address'], // Replace with actual address
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true, // Set readOnly to prevent user editing
                decoration: _customDecoration('Phone No'),
                initialValue: data['phoneNumber'], // Replace with actual phone number
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true, // Set readOnly to prevent user editing
                decoration: _customDecoration('Email'),
                initialValue:
                    currentUser?.email!, // Replace with actual email
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(217, 27, 27, 55), // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  textStyle: TextStyle(fontSize: 17),
                ),
                child: Text('See Registered Buses', style: TextStyle(fontFamily: 'nunito_Sans',)),
                onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisteredBuses()),
                  );
                },
              ),
                ],
              )
            ],
          ),
        ),
      );
          }else if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

      }),
    );
  }
}