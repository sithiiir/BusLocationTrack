import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:signin_signup/welcom.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    home: WelcomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'nunito_Sans')
  ,
  ));
}


