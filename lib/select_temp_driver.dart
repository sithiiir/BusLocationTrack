import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectDriverPage extends StatefulWidget {
  final String vehicleNumber;

  SelectDriverPage({required this.vehicleNumber});

  @override
  State<SelectDriverPage> createState() => _SelectDriverPageState();
}

class _SelectDriverPageState extends State<SelectDriverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Temporary Driver', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select a Driver:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('drivers').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final List<DocumentSnapshot> drivers = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: drivers.length,
                    itemBuilder: (context, index) {
                      final driver = drivers[index].data() as Map<String, dynamic>;
                      final driverName = driver['username'];

                      return GestureDetector(
                        onTap: () {
                           _storeTemporaryDriver(driverName);
                          print('Selected driver: $driverName');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(217, 217, 217, 224),
                            
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(driverName),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Future<void> _storeTemporaryDriver(String driverName) async {
  final vehicleNumber = widget.vehicleNumber;

  try {
      
    final driverSnapshot = await FirebaseFirestore.instance
        .collection('drivers')
        .where('username', isEqualTo: driverName)
        .limit(1)
        .get();
        if (driverSnapshot.docs.isEmpty) {
      
      throw 'Driver not found';
    }
    final driverData = driverSnapshot.docs.first.data() as Map<String, dynamic>;
    final driverEmail = driverData['email']; 
    
    
    final existingDriverSnapshot = await FirebaseFirestore.instance
        .collection('tempDriver')
        .where('vehicleNo', isEqualTo: vehicleNumber)
        .where('driverEmail', isEqualTo: driverEmail)
        .limit(5)
        .get();

    if (existingDriverSnapshot.docs.isNotEmpty) {
      
      await existingDriverSnapshot.docs.first.reference.delete();
    }

  

    
    await FirebaseFirestore.instance.collection('tempDriver').add({
      'driverEmail': driverEmail,
      'vehicleNo': vehicleNumber,

    });


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Temporary driver assigned successfully!'),
      ),
    );
    Navigator.pop(context);
  } catch (error) {

    print('Error storing temporary driver data: $error');

  }
}

}
