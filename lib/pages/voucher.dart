import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class Voucher extends StatefulWidget {
  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
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
      body:
      Center(child: CachedNetworkImage(
    imageUrl:"https://i.giphy.com/media/XqpnXaeZPnupy/giphy.webp",


      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),),
    );
  }
}
