import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  InputDecoration _customDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black,),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 208, 203, 203), width: 0.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(217, 27, 27, 55), width: 2.0),
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
        stream: FirebaseFirestore.instance.collection("users").doc(currentUser?.email).snapshots(),
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
                radius: 60, 
                backgroundImage: AssetImage('images/person.png'),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true, 
                decoration: _customDecoration('Username'),
                initialValue: data['username'], 
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true, 
                decoration: _customDecoration('Name'),
                initialValue:data['firstName'], 
              ),
              // SizedBox(height: 20),
              // TextFormField(
              //   readOnly: true, 
              //   decoration: _customDecoration('Address'),
              //   initialValue: data['address'], 
              // ),
              // SizedBox(height: 20),
              // TextFormField(
              //   readOnly: true, 
              //   decoration: _customDecoration('Phone No'),
              //   initialValue: data['phoneNumber'], 
              // ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true, 
                decoration: _customDecoration('Email'),
                initialValue:
                    currentUser?.email!, 
              ),
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
