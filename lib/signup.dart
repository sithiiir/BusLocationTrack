import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_signup/auth_page.dart';
import 'package:signin_signup/signin.dart';

class SignupPage extends StatefulWidget {
   
  const SignupPage({super.key,});
  

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  
  void clearPassFields() {
    passwordController.clear();
    confirmPasswordController.clear();

  }
 
  void signUp() async {
    

    if (passwordController.text == confirmPasswordController.text) {
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      FirebaseFirestore.instance.collection('users').doc(userCredential.user!.email).set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'username': usernameController.text,
        'address': addressController.text,
        'email': emailController.text,
        'phoneNumber': phoneNumberController.text,
        
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Welcome'),
            content: Text('User Registered successfully', style: TextStyle(fontSize: 20, fontFamily: 'nunito_Sans')),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthPage()),
                  );
                  
                },
              ),
            ],
          );
        },
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          duration: Duration(seconds: 2),
          // Adjust as needed
        ),
      );
      clearPassFields();
    }
  }

  InputDecoration _customDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black, fontFamily: 'nunito_Sans',),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(217, 217, 217, 224), width: 0.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(217, 27, 27, 55), width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      fillColor: const Color.fromARGB(217, 217, 217, 224),
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup', style: TextStyle(fontFamily: 'nunito_Sans',color: Colors.white,)),
        backgroundColor: Color.fromARGB(217, 27, 27, 55),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: _customDecoration('First Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: lastNameController,
                decoration: _customDecoration('Last Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: usernameController,
                decoration: _customDecoration('Username'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: addressController,
                decoration: _customDecoration('Address'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
                decoration: _customDecoration('Email'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: phoneNumberController,
                decoration: _customDecoration('Phone Number'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: _customDecoration('Password'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: confirmPasswordController,
                decoration: _customDecoration('Confirm Password'),
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(217, 27, 27, 55), // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Sign Up', style: TextStyle(fontFamily: 'nunito_Sans',)),
                onPressed: () {
                  signUp();
                },
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: Text('Already have an account?', style: TextStyle(fontFamily: 'nunito_Sans',))),
              TextButton(
                child: Text('Sign In'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
