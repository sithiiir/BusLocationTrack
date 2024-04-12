import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:signin_signup/qr_generator.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  AssetBundle? configuration; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('location').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final markers = snapshot.data!.docs.map((locationDoc) async {
            final tempDriverDoc = await FirebaseFirestore.instance
                .collection('tempDriver')
                .where('driverEmail', isEqualTo: locationDoc.id)
                .get();
            final vehicleNumber = tempDriverDoc.docs.isNotEmpty
                ? tempDriverDoc.docs.first['vehicleNo']
                : 'N/A';
                final BitmapDescriptor markerIcon = await _getMarkerIcon();

            return Marker(
              markerId: MarkerId(locationDoc.id),
              position: LatLng(locationDoc['latitude'], locationDoc['longitude']),
              icon: markerIcon,
              
              infoWindow: InfoWindow(
                title: 'Vehicle Number: $vehicleNumber',
              ),
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrGeneratorPage(driverEmail: locationDoc.id, vehicleNumber: vehicleNumber),
                  ),
                );
              },
            );
          }).toList();
           return FutureBuilder<List<Marker>>(
            future: Future.wait(markers), 
            builder: (context, AsyncSnapshot<List<Marker>> markerSnapshot) {
              if (!markerSnapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
          return GoogleMap(
            mapType: MapType.normal,
            markers: Set<Marker>.of(markerSnapshot.data!),
            initialCameraPosition: CameraPosition(
              target: LatLng(
                
                snapshot.data!.docs[0]['latitude'], 
                snapshot.data!.docs[0]['longitude'], 
              ),
              zoom: 14.47,
            ),
            onMapCreated: (GoogleMapController controller) async {
              setState(() {
                _controller = controller;
                _added = true;
              });
            },
          );
        },
      );
        },
      ),
    );
  }
  Future<BitmapDescriptor> _getMarkerIcon() async {
  
  final ByteData data = await rootBundle.load('images/bus.png');
  final ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: 100,  
    targetHeight: 100, 
  );
  final ui.FrameInfo fi = await codec.getNextFrame();

  
  final Uint8List byteData = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  
  return BitmapDescriptor.fromBytes(byteData);
}


}
