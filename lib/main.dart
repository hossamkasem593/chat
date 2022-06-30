// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, duplicate_import

import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:chat/screens/sign_in.dart';
import 'package:chat/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  final _fireStore = FirebaseFirestore.instance;
  WidgetsFlutterBinding.ensureInitialized();
   await  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      // home: WelcomeScereen(),
      initialRoute: _auth.currentUser != null ? ChatScreen.screenRoute: WelcomeScereen.screenRoute ,
      routes: 
      {
        WelcomeScereen.screenRoute:(context) => WelcomeScereen(),
        SigninScreen.screenRoute:(context) => SigninScreen(),
         RegistrationScreen.screenRoute:(context) => RegistrationScreen(),
         ChatScreen.screenRoute:(context) => ChatScreen(),
         
      },
       
    );
  }
}


