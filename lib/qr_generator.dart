import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorPage extends StatefulWidget {
  final String? driverEmail;
  final String? vehicleNumber;

  const QrGeneratorPage({Key? key, this.driverEmail, this.vehicleNumber}) : super(key: key);

  @override
  State<QrGeneratorPage> createState() => _QrGeneratorPageState();
}

class _QrGeneratorPageState extends State<QrGeneratorPage> {
  String _routeName = '';
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

 void initState() {
    super.initState();
    _fetchRouteName();
  }

  Future<void> _fetchRouteName() async {
    if (widget.vehicleNumber == null) {
      return; 
    }

    final docSnapshot = await FirebaseFirestore.instance
        .collection('buses')
        .where('vehicleNo', isEqualTo: widget.vehicleNumber)
        .get()
        .then((querySnapshot) => querySnapshot.docs.isNotEmpty
            ? querySnapshot.docs.first
            : null);

    if (docSnapshot != null) {
      setState(() {
        _routeName = docSnapshot['routeName']; 
      });
    }
  }
  String data1 = "";
  String data2 = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator', style: TextStyle(fontFamily: 'nunito_Sans',color: Colors.white)),
        backgroundColor: const Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              Text(
                'Vehicle Number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'nunito_Sans',),
              ),
              Text(
                widget.vehicleNumber ?? 'N/A',
                style: TextStyle(fontSize: 24, fontFamily: 'nunito_Sans',),
              ),
              SizedBox(height: 20),
               Text(
                  'Route Name:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'nunito_Sans',),
                ),
                Text(
                  _routeName,
                  style: TextStyle(fontSize: 20, fontFamily: 'nunito_Sans',),
                ),
                 SizedBox(height: 20),
                 TextField(
                  controller: _fromController,
                  onChanged: (value) => setState(() {
                    data1 = value;
                  }), 
                  decoration: InputDecoration(
                    labelText: 'From:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _toController,
                  onChanged: (value) => setState(() {
                    data2 = value;
                  }), 
                  decoration: InputDecoration(
                    labelText: 'To:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
            child: QrImageView(
              data: data1+'-'+data2,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
         
            ],
          ),
        ),
      ),
    ),
    );
  }


}