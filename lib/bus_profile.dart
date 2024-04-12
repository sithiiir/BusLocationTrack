import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signin_signup/select_temp_driver.dart';

class BusProfile extends StatefulWidget {
  final String vehicleNumber;

  BusProfile({required this.vehicleNumber});

  @override
  State<BusProfile> createState() => _BusProfileState();
}

class _BusProfileState extends State<BusProfile> {
    String busModel = "";
  String manufactureYear = "";
  String registeredYear = "";
  String routePermissionNumber = "";
  String ownerName = "";
  String driverUname = "";

  @override
  void initState() {
    super.initState();
    _fetchBusDetails();
  }

  Future<void> _fetchBusDetails() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('buses')
      .where('vehicleNo', isEqualTo: widget.vehicleNumber)
      .get();

  try {
    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data() as Map<String, dynamic>; 
      setState(() {
        busModel = data['busName'] ?? ""; 
        manufactureYear = data['mnfYear'] ?? "";
        registeredYear = data['registeredY'] ?? "";
        routePermissionNumber = data['routePermission'] ?? "";
        ownerName = data['ownerName'] ?? "";
        driverUname = data['driverUname'] ?? "";
      });
    } else {
      print("No bus found with vehicle number: ${widget.vehicleNumber}");
    }
  } catch (e) {
    print("Error fetching bus details: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 200.0),
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(217, 27, 27, 55),
                
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Bus Model: ',
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      Text(busModel ?? '', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Manufacture Year: ',
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      Text(manufactureYear ?? '', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Registered Year: ',
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      Text(registeredYear?? '', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Vehicle Number: ',
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      Text(widget.vehicleNumber, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Route Permission Number: ',
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      Text(routePermissionNumber ?? '', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Owner Name: ',
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      Text(ownerName ?? '', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Driver UserName: ',
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      Text(driverUname ?? '', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  
                  
                  
                ],
                
              )
              
              
            ),
            ElevatedButton(
              
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: const Color.fromARGB(217, 27, 27, 55), 
                  foregroundColor: Colors.white, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 21.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Change driver', style: TextStyle(color: Colors.white, fontFamily: 'nunito_Sans',)),
                onPressed: () {
                  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectDriverPage(vehicleNumber: widget.vehicleNumber)),
    );
                },
              ),
          ],
        ),
      ),
      
      
      
    );
  }
}
