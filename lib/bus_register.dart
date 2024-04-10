import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class BusRegiter extends StatefulWidget {
  const BusRegiter({
    super.key,
  });

  @override
  State<BusRegiter> createState() => _BusRegiterState();
}

class _BusRegiterState extends State<BusRegiter> {
  final busNameController = TextEditingController();
  final mnfYearController = TextEditingController();
  final registeredYController = TextEditingController();
  final vehicleNoController = TextEditingController();
  final routePermissionNoController = TextEditingController();
  final routeNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final ownerPhoneController = TextEditingController();
  final ownerAddressController = TextEditingController();
  final driverUnameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  void clearTextFields() {
    busNameController.clear();
    mnfYearController.clear();
    registeredYController.clear();
    vehicleNoController.clear();
    routePermissionNoController.clear();
    routeNameController.clear();
    ownerNameController.clear();
    ownerPhoneController.clear();
    ownerAddressController.clear();
    driverUnameController.clear();
    busNameController.clear();
   
  }

  void registerBus(BuildContext context) async {
    try {
      String? userEmail = user!.email;
      await FirebaseFirestore.instance.collection('buses').add({
        'driverEmail': userEmail,
        'busName': busNameController.text,
        'mnfYear': mnfYearController.text,
        'registeredY': registeredYController.text,
        'vehicleNo': vehicleNoController.text,
        'routePermission': routePermissionNoController.text,
        'routeName': routeNameController.text,
        'ownerName': ownerNameController.text,
        'ownerPhone': ownerPhoneController.text,
        'ownerAddress': ownerAddressController.text,
        'driverUname': driverUnameController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registered successfully'),
          duration: Duration(seconds: 2), // Adjust as needed
        ),
      );
      clearTextFields();
      FocusScope.of(context).unfocus();
      
    } catch (error) {
      // Handle error
      print('Error registering bus: $error');
    }
  }

  InputDecoration _customDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register your Bus', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white,)
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: busNameController,
                decoration: _customDecoration('Bus Model'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: mnfYearController,
                decoration: _customDecoration('Manufactured Year'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: registeredYController,
                decoration: _customDecoration('Registered Year'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: vehicleNoController,
                decoration: _customDecoration('Vehicle Number'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: routePermissionNoController,
                decoration: _customDecoration('Route Permission Number'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: routeNameController,
                decoration: _customDecoration('Route name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: ownerNameController,
                decoration: _customDecoration('Owner Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: ownerPhoneController,
                decoration: _customDecoration('Owner Phone Number'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: ownerAddressController,
                decoration: _customDecoration('Owner Address'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: driverUnameController,
                decoration: _customDecoration('Driver Username'),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(217, 27, 27, 55), // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Register'),
                onPressed: () {
                  registerBus(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
