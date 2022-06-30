// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, avoid_print, unused_local_variable, unnecessary_import, unnecessary_import, unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import'package:flutter/material.dart';

import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/sign_in.dart';
import 'package:chat/widgets/my_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth =  FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
             Container(
              height: 100,
              child:Image.asset('images/profile_image.png'),
             ),
             SizedBox(height: 40),
             // ignore: prefer_const_constructors
             TextField(
               keyboardType:TextInputType.emailAddress ,
               textAlign: TextAlign.center,
               onChanged: (value)
               { 
                 value = email;
                 
               },
               decoration:InputDecoration(label: Text('Email'),
               hintText: 'Enter your Email',
               contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
               border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
               enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.grey,width: 1,style: BorderStyle.solid)
               ),
               focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black,width: 2,style: BorderStyle.solid) ,
               ),
               
               ),
               
             
              ),
            SizedBox(height: 10),
             // ignore: prefer_const_constructors
             TextField(
               obscureText: true,
               textAlign: TextAlign.center,
               onChanged: (value)
               {
                 value = password;
               },
               decoration:InputDecoration(label: Text('password'),
               hintText: 'Enter your Password',
               contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
               border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
               enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.grey,width: 1,style: BorderStyle.solid)
               ),
               focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black,width: 2,style: BorderStyle.solid) ,
               ),
               
               ),
               
             
              ),
              SizedBox(height: 10),
              MyBotton(color:Colors.blue[800]! , title: 'Register', 
              onPressed: () async
              {
                setState(() {
                  showSpinner = true;
                });
                
                try
                {
                 final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                 Navigator.pushNamed(context, ChatScreen.screenRoute);
                 setState(() {
                   showSpinner = false;
                 });
                }
                catch(e)
                {
                   print(e);
                }
              }
              ),
             
           
           
      
           ],
      
          ),
        ),
      ) ,
      
    );
  }
}