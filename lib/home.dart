
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_signup/about_us.dart';
import 'package:signin_signup/google_map.dart';
import 'package:signin_signup/profile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;

  void signout() {
    FirebaseAuth.instance.signOut();
  }
   @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(217, 27, 27, 55),
        title: Text('Live Location of Buses', style: TextStyle(fontFamily: 'nunito_Sans',color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(217, 27, 27, 55),
              ),
              child: Center(child: Text("Logged in as ${user?.email ?? 'No user logged in'}", style: TextStyle(fontFamily: 'nunito_Sans', color: Colors.white),)),
            ),
            ListTile(
              title: const Text('Home', style: TextStyle(fontFamily: 'nunito_Sans',)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Profile', style: TextStyle(fontFamily: 'nunito_Sans',)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: const Text('About Us', style: TextStyle(fontFamily: 'nunito_Sans',)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            
            
            Row(
              children: [
                IconButton(onPressed: signout, icon: Icon(Icons.logout),
                
                ),
              ],
            )
          ],
        ),
      ),
      body: Maps()
    );
  }
}
