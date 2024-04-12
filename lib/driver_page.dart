import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:signin_signup/bus_register.dart';
import 'package:signin_signup/driver_profile.dart';


class DriverPage extends StatefulWidget {
  const DriverPage({super.key});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  final user = FirebaseAuth.instance.currentUser;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Driver Page', style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(217, 27, 27, 55),
          iconTheme: IconThemeData(color: Colors.white) ,
          
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(217, 27, 27, 55),
                ),
                child: Center(child: Text("Hello  ${user?.email ?? 'No user logged in'}", style: TextStyle(color: Colors.white,))),
              ),
              ListTile(
                title: const Text('Home',),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DriverPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Profile',),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DriverProfile()),
                  );
                },
              ),
              ListTile(
                title: const Text('Register a Bus',),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BusRegiter()),
                  );
                },
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: signOut,
                    icon: Icon(Icons.logout),
                  ),
                ],
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top :20.0),
          child: Center(
            child: Column(
              children: [
                Text("Welcome Driver",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,)),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(217, 27, 27, 55), // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 29.0),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Add my location',),
                  onPressed: () {
                    _addLocation();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(217, 27, 27, 55),// Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Enable Live Location', ),
                  onPressed: () {
                    _enableLocation();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(217, 27, 27, 55), // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 21.0),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Stop Live Location', ),
                  onPressed: () {
                    _stopLocation();
                  },
                ),
                SizedBox(height: 50),
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('location')
                        .doc(user?.email)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Text('Location is not enabled yet.');
                      }
          
                      final Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
          
                      final String name = data['name'].toString();
                      final String latitude = data['latitude'].toString();
                      final String longitude = data['longitude'].toString();
          
                      return ListView(
                        children: [
                          ListTile(
                            title: Text(name),
                            subtitle: Row(
                              children: [
                                Text(latitude),
                                SizedBox(width: 10),
                                Text(longitude),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _addLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('location')
          .doc(user?.email)
          .set({
        'name': '',
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _enableLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance
          .collection('location')
          .doc(user?.email)
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'Driver'
      }, SetOptions(merge: true));
    });
  }

  _stopLocation() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
