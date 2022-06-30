// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:chat/screens/registration_screen.dart';
import 'package:chat/screens/sign_in.dart';
import 'package:chat/widgets/my_button.dart';
import 'package:flutter/material.dart';

class WelcomeScereen extends StatelessWidget {
  static const String screenRoute = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           Column(
             children: [
               Container(
                 height: 100,
                child: Image.asset('images/profile_image.png'),
                 ),
               Text('MessageMe',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900,color: Colors.blueAccent),),
             ],
           ),
         SizedBox(height: 30),
         newMethod(context),
         SizedBox(height: 30),
         MyBotton(color:Colors.blue, title:'Register', onPressed: ()
         {
          Navigator.pushNamed(context, RegistrationScreen.screenRoute);
         }
           ),
          ],            
          
        ),
           
        ),
        
     
    );
  }

  MyBotton newMethod(BuildContext context) {
    return MyBotton(color:Colors.yellow[900]!, title:'Sign in', onPressed: ()
       {
         Navigator.pushNamed(context, SigninScreen.screenRoute);
         
       }
       );
  }
}

