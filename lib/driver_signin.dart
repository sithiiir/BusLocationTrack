// DriverSignIn.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin_signup/admin_user_select.dart';


class DriverSignIn extends StatefulWidget {
  const DriverSignIn({Key? key}) : super(key: key);

  @override
  _DriverSignInState createState() => _DriverSignInState();
}

class _DriverSignInState extends State<DriverSignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void clearPassFields() {
    passwordController.clear();
    emailController.clear();
    
   
  }

  void signIn() async {
  try {
  
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    
  } on FirebaseAuthException catch (e) {
    
    print('Sign-in error: ${e.code}');

    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign-in failed: Incorrect email or password"),
          ),
        );
        clearPassFields();
    
  }
}
 

   InputDecoration _customDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black, ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 208, 203, 203), width: 0.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(217, 27, 27, 55), width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      fillColor: Color.fromARGB(217, 217, 217, 224),
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Sign In', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white),
        
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Welcome Driver!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'nunito_Sans',)),
                Text("Sign in to your account", style: TextStyle(fontSize: 16, fontFamily: 'nunito_Sans')),
                SizedBox(height: 100),
                TextField(
                  controller: emailController,
                  decoration: _customDecoration(
                    'Email',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: _customDecoration(
                    'Password',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(217, 27, 27, 55), 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: TextStyle(fontSize: 18, fontFamily: 'nunito_Sans',),
                  ),
                  onPressed: () {
                    signIn();
                  },
                  child: Text('Sign In', style: TextStyle(fontFamily: 'nunito_Sans',)),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  thickness: 4,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(child: Text("Or",)),
                
                TextButton(
                  child: Text('Register Now', style: TextStyle(fontSize: 16, )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminUserSelect()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
