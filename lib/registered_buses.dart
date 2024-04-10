import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_signup/bus_profile.dart';

class RegisteredBuses extends StatefulWidget {
  const RegisteredBuses({super.key});

  @override
  State<RegisteredBuses> createState() => _RegisteredBusesState();
}

class _RegisteredBusesState extends State<RegisteredBuses> {
  final user = FirebaseAuth.instance.currentUser;
  String? driverName;
  String? driverAddress;
  String? driverPhoneNumber;
   @override
  void initState() {
    super.initState();
    // Call a method to fetch driver details when the widget is initialized
    fetchDriverDetails();
  }
 void fetchDriverDetails() async {
  try {
    // Retrieve the current user's email
    String? userEmail = user?.email; // Use null-aware access

    // Ensure userEmail is not null
    if (userEmail != null) {
      // Query Firestore to fetch the driver's document based on the email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('drivers')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      // Check if the query returned any documents
      if (querySnapshot.docs.isNotEmpty) {
        // Extract driver details from the document
        var driverData = querySnapshot.docs.first.data() as Map<String, dynamic>; // Cast as Map<String, dynamic>

        // Check for required fields before updating the state
        if (driverData.containsKey('firstName') && driverData.containsKey('address') && driverData.containsKey('phoneNumber')) {
          setState(() {
            driverName = driverData['firstName'];
            driverAddress = driverData['address'];
            driverPhoneNumber = driverData['phoneNumber'];
          });
        } else {
          // Handle missing fields
          print('Some driver details are missing.');
        }
      } else {
        // Handle no documents found
        print('No driver details found for the given email.');
      }
    } else {
      // Handle null userEmail
      print('User email is null.');
    }
  } catch (e) {
    // Handle any errors that occur during the fetch
    print('An error occurred while fetching driver details: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Buses', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(217, 27, 27, 55),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Driver name: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    Text(driverName ?? '', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text('Address: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    Text(driverAddress ?? '', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text('Phone number: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    Text(driverPhoneNumber ?? '', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('buses')
            .where('driverEmail', isEqualTo: user?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (context, index) {
                  DocumentSnapshot bus = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BusProfile(vehicleNumber: bus['vehicleNo']),
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(217, 217, 217, 224),
                      ),
                      child: Text(
                        bus['vehicleNo'], // Display the vehicle number
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
          ),
          
        ],
      ),
    );
  }
}
