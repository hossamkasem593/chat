// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_null_comparison, avoid_print

import 'package:chat/screens/chat_screen.dart';
import 'package:chat/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class SigninScreen extends StatefulWidget {
 static const String screenRoute = 'signin_screen';
 

  const SigninScreen({ Key? key }) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ModalProgressHUD(
         inAsyncCall: showSpinner,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
               Container(
              height: 100,
              child:Image.asset('images/profile_image.png'),
             ),
             SizedBox(height: 40),
          TextField(
               keyboardType: TextInputType.emailAddress,
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
         SizedBox(height: 20),
          TextField(
               obscureText: true,
               textAlign: TextAlign.center,
               onChanged: (value){
       
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
         SizedBox(height: 20,),
         MyBotton(color: Colors.blue, title: 'Sign in', onPressed: ()async{  
            setState(() {
              showSpinner = true;
              
              });

               try
               {
                final user =await _auth.signInWithEmailAndPassword(email: email, password: password);
                 if(user != null)
                 {
                   Navigator.pushNamed(context, ChatScreen.screenRoute);
                  setState(() {
              showSpinner = false;
              
              });
 
                 }
               }catch(e){
                 print(e);
               }
       
         }),
       
       
         ]),
       ),
    );
  }
}