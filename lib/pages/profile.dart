import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Shop",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.pink),),
                Text("Nest",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.amber[400]),),
              ],
            ),
            Icon(Icons.perm_identity,size: 35,)
          ],
        ),
        centerTitle: true,

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").doc("${user.uid}").snapshots(),

          builder: (context,snapshot){
          if(snapshot.hasData){
                DocumentSnapshot documentSnapshot=snapshot.data;
                return Column(
                  children: [
                    Text(documentSnapshot["Name"]),
                    Text(documentSnapshot["Phone"]),
                    Text(documentSnapshot["Address"]),
                  ],
                );
                
          }
          },
      )
      );
  }
}
