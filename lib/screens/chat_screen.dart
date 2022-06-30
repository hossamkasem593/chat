// ignore: duplicate_ignore
// ignore_for_file: prefer_const_constructors, unused_import, unused_import, avoid_print, unused_local_variable

// ignore: avoid_web_libraries_in_flutter

import 'package:chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
late User  signInUser;
final _firestore = FirebaseFirestore.instance;
class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();  
  final _auth = FirebaseAuth.instance;
  
  String? messageText;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
   
  void getCurrentUser()
  {
   
    try
    {
 final user = _auth.currentUser;
    if (user != null)
    { 
      signInUser = user;
      print(signInUser.email);
          }
    }catch(e)
    {
      print(e);
    }
    
      
    
  }
   void messageStreams() async
   {
     await for(var snapshot in  _firestore.collection('messages').snapshots())
     {
       for(var message in snapshot.docs)
       {
         message.data();
       }
     }


      

   }
//  void getMessage() async
//  {
   
   
//    final messages = await  _firestore.collection('messages').get();
//    for( var message in   messages.docs)
//    {
//      print(message.data());
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/profile_image.png',
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Message Me'),
          ],
        ),
        actions: [
          IconButton(onPressed: () {
            _auth.signOut();
            Navigator.pop(context);
          }, icon: Icon(Icons.close)
              // add here logout function
              ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Colors.orange, width: 2, style: BorderStyle.solid),
                ),
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) 
                    {
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      hintText: 'Weite message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                     
                    onPressed: () {
                      messageTextController.clear();
                      messageStreams();
                       _firestore.collection('collectionPath').add({
                        'text' : messageText,
                        'sender' : signInUser.email,
                         'time' : FieldValue.serverTimestamp(),
                       }
                     );
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
               stream: _firestore.collection('messages').orderBy('time').snapshots(),
               builder: (context,snapshot)
               {

                List<MessageLine>  messagesWidgets = [                  
                ];
                if(!snapshot.hasData)
                  {
                   return Center(

                     child: CircularProgressIndicator(
                       backgroundColor: Colors.blue,
                     ),
                   );
                  }
               final   messages = snapshot.data!.docs.reversed;
               for(var message in messages)
               {
                 final messageText = message.get('text');
                 final messageSender = message.get('sender');
                 final currentUser = signInUser.email;
                
                 final messageWidget = MessageLine(
                   sender: messageSender,
                   text: messageText,
                   isMe: currentUser == messageSender,
                   );

               }
               return Expanded(
                 child: ListView(
                   reverse: true,
                   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                   children: messagesWidgets,
                 ),
               );
               
               },
               );
               
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({ this.text,this.sender , required this.isMe ,Key? key}) : super(key: key);
   final String? text;
   final String? sender;
   final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),


      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment:isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
          children: [
            Text('$sender',style: TextStyle(fontSize: 15,color: Colors.yellow[900]),),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
              ),
              color:isMe ? Colors.blue : Colors.white,
              child: Text('$text  ',style: TextStyle(fontSize: 15,color: isMe? Colors.white:Colors.black),)),
          ],
        ),
      ),
    );
                
               }
  }
