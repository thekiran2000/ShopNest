import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Myorder extends StatefulWidget {
  @override
  _MyorderState createState() => _MyorderState();
}

class _MyorderState extends State<Myorder> {
  var userdata;
  var cat_name;

  void func(var str,var cat){
    Navigator.pushNamed(context, "/productinfo",arguments: {
      "hash":str,
      "cat":cat,
    });
  }
  final databaseReference = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser;

  void adddetails(var name,var cat,var quantity,var price,var img_url,var timestamp,var disc,var brand,var shop_hash,var rating,var rating_count,var shop_id,var shopname) async{




    await databaseReference.collection("Wish")
        .doc("${user.uid}").collection("Items").doc("$shop_hash")
        .set({
      "Product":name,
      "Category":cat,
//      "Desc":desc,
      "Quantity":quantity,
      "Price":price,
      "Image":img_url,
      "Timestamp":timestamp,
      "shop_id":shop_id,
      "Shop_name":shopname,
      "shop_hash":shop_hash,
      "Discount":disc,
      "Brand":brand,
      "Rating":rating,
      "Rating_Count":rating_count,

    });
  }
  var dash=false;
  void checkheart(var name,var cat,var quantity,var price,var img_url,var timestamp,var disc,var brand,var hash,var rating,var rating_count,var shop_id,var shopname) async{
    final snapShot = await FirebaseFirestore.instance.collection('Wish').doc("${user.uid}").collection("Items").doc("$hash").get();
    if(snapShot.exists){
      Remove(hash);
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(milliseconds: 700), () {
              Navigator.of(context).pop(true);
            });
            return Padding(
              padding: const EdgeInsets.fromLTRB(0.0,0,0,500),
              child: AlertDialog(
                backgroundColor: Colors.red[600],
                elevation: 0,

                title: Center(child: Row(
                  children: [
                    Text('Removed Sucessfully!!!',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: CupertinoColors.white),),
                    SizedBox(width: 10,),
                    Icon(Icons.cancel,color: CupertinoColors.white,),
                  ],
                )),
              ),
            );
          });
    }
    else{
      adddetails(name, cat, quantity, price, img_url, timestamp, disc, brand, hash, rating, rating_count, shop_id, shopname);
      showDialog(

          context: context,
          builder: (context) {
            Future.delayed(Duration(milliseconds: 700), () {
              Navigator.of(context).pop(true);
            });
            return Padding(
              padding: const EdgeInsets.fromLTRB(0.0,0,0,500),
              child: AlertDialog(
                elevation: 0,
                backgroundColor: Colors.green,
                title: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Added Sucessfully!!!',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: CupertinoColors.white),),
                    SizedBox(width: 10,),
                    Icon(Icons.thumb_up,color: CupertinoColors.white,),
                  ],
                )),
              ),
            );
          });
    }
  }
  void Remove (var hash) async {
    await databaseReference.collection("Wish")
        .doc("${user.uid}").collection("Items").doc("$hash")
        .delete();
  }


  var dropdownValue="1";

  void statechange(var time,var shopid)async{
//      final snapShot = await FirebaseFirestore.instance.collection('Orders').doc("${user.uid}").collection("Items").doc("$time").get();
//      var user_id=snapShot.data()["user_id"];
    final snapShot = await FirebaseFirestore.instance.collection('MyOrders').doc("${user.uid}").collection("Items").doc("$time").get();

    var check=snapShot.data()["Delivered"];
    var check1=snapShot.data()["Shipped"];

//    var check2=snapShot.data()["Confirmed"];

    if(check==false && check1==true){
      await databaseReference.collection('Orders').doc("$shopid").collection("Items").doc("$time")
          .update({
        "Delivered":true,
      });
      await databaseReference.collection('MyOrders').doc("${user.uid}").collection("Items").doc("$time")
          .update({
        "Delivered":true,
      });
    }


  }
  var rate=1;

  void rate_update(var time,var cat,var hash) async{

    final snapShot = await FirebaseFirestore.instance.collection('MyOrders').doc("${user.uid}").collection("Items").doc("$time").get();

    var check=snapShot.data()["Rating"];
    var check1=snapShot.data()["Rating_Count"];
    var check2=snapShot.data()["Rating_final"];

    check=check+rate;
    check1=check1+1;
    if(check!=0){
      check2=(check/check1).floor();
    }



    await databaseReference.collection('MyOrders').doc("${user.uid}").collection("Items").doc("$time")
        .update({
      "Rating":check,
      "Rating_Count":check1,
      "Rating_Final":check2,
      "Rated":true,
    });
    await databaseReference.collection('Categories').doc("$cat").collection("Products").doc("$hash")
        .update({
      "Rating":check,
      "Rating_Count":check1,
      "Rating_Final":check2,

    });
    await databaseReference.collection('All').doc("$hash")
        .update({
      "Rating":check,
      "Rating_Count":check1,
      "Rating_Final":check2,

    });

  }


  @override
  Widget build(BuildContext context) {


//    void statechange2(var time)async{
//      final snapShot = await FirebaseFirestore.instance.collection('Orders').doc("${user.uid}").collection("Items").doc("$time").get();
//      var user_id=snapShot.data()["user_id"];
//      final snapShot2 = await FirebaseFirestore.instance.collection('MyOrders').doc("$user_id").collection("Items").doc("$time").get();
//
//
//      var check1=snapShot.data()["Shipped"];
////    var check2=snapShot.data()["Confirmed"];
//
//      if(check1==false){
//        await databaseReference.collection('Orders').doc("${user.uid}").collection("Items").doc("$time")
//            .update({
//          "Shipped":true,
//        });
//        await databaseReference..collection('MyOrders').doc("$user_id").collection("Items").doc("$time")
//            .update({
//          "Shipped":true,
//        });
//      }
//
//
//    }


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
        stream: FirebaseFirestore.instance.collection("MyOrders").doc("${user.uid}").collection("Items").snapshots(),

        builder: (context,snapshot){
          if(snapshot.hasData){


            return ListView.builder(
                physics: BouncingScrollPhysics(),

                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  DocumentSnapshot documentSnapshot=snapshot.data.documents[index];


                  return StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("Categories").doc(documentSnapshot["Category"]).collection("Products").doc(documentSnapshot["Product_id"]).snapshots(),
                        builder: (context,snapshot) {
                          if (snapshot.hasData) {
                            DocumentSnapshot documentSnapshot2 = snapshot.data;
                            return Container(
                              height: 540,
                              child: InkWell(
                                onTap: () {
//                        func(documentSnapshot["shop_hash"],cat_name);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
//                                            Image.network(
//                                              documentSnapshot["Image"],
//                                              width: 130, height: 130,),
                                            CachedNetworkImage(
                                              imageUrl:documentSnapshot["Image"],
                                              width: 130,
                                              height: 130,

                                              placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Column(
                                                  children: [


                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons
                                                                .location_on,
                                                              color: Colors
                                                                  .pink[900],
                                                              size: 18,),
                                                            SizedBox(width: 3,),
                                                            Text(
                                                                documentSnapshot["Shop_name"],
                                                                style: GoogleFonts
                                                                    .raleway(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight
                                                                        .bold))
                                                          ],
                                                        ),

                                                        InkWell(


                                                            onTap: () {
//                                                    checkheart(documentSnapshot["Product"],documentSnapshot["Category"],documentSnapshot["Quantity"],documentSnapshot["Price"],documentSnapshot["Image"],DateTime.now().microsecondsSinceEpoch,documentSnapshot["Discount"],documentSnapshot["Brand"],documentSnapshot["shop_hash"],documentSnapshot["Rating"],documentSnapshot["Rating_Count"],documentSnapshot["shop_id"],documentSnapshot["Shop_name"]);
//                                                if(dash==true)Remove(documentSnapshot["shop_hash"]);
//                                                if(dash==false)adddetails(documentSnapshot["Product"],documentSnapshot["Category"],documentSnapshot["Quantity"],documentSnapshot["Price"],documentSnapshot["Image"],DateTime.now().microsecondsSinceEpoch,documentSnapshot["Discount"],documentSnapshot["Brand"],documentSnapshot["shop_hash"],documentSnapshot["Rating"],documentSnapshot["Rating_Count"],documentSnapshot["shop_id"],documentSnapshot["Shop_name"]);
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Icon(Icons
                                                                    .favorite_border,
                                                                  color: Colors
                                                                      .red[900],),

                                                              ],
                                                            ))
                                                      ],
                                                    ), Padding(
                                                      padding: const EdgeInsets
                                                          .all(3.0),
                                                      child: Column(
                                                        children: [
                                                          if(documentSnapshot["Product"].toString().length>80) Text("${documentSnapshot["Product"].toString().substring(0,79)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                          if(documentSnapshot["Product"].toString().length<=80) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                        ],
                                                      )
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: Row(
                                                        children: [
                                                          if(documentSnapshot2["Rating_Final"] ==
                                                              0)Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                            ],
                                                          ),
                                                          if(documentSnapshot2["Rating_Final"] ==
                                                              1)Row(
                                                            children: [
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                            ],
                                                          ),
                                                          if(documentSnapshot2["Rating_Final"] ==
                                                              2)Row(
                                                            children: [
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                            ],
                                                          ),
                                                          if(documentSnapshot2["Rating_Final"] ==
                                                              3)Row(
                                                            children: [
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                            ],
                                                          ),
                                                          if(documentSnapshot2["Rating_Final"] ==
                                                              4)Row(
                                                            children: [
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons
                                                                  .star_border,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 21,),
                                                            ],
                                                          ),
                                                          if(documentSnapshot2["Rating_Final"] ==
                                                              5)Row(
                                                            children: [
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .amber[900],
                                                                size: 26,),
                                                            ],
                                                          ),

                                                          Text("  ("),
                                                          Text(
                                                              documentSnapshot["Rating_Count"]
                                                                  .toString()),
                                                          Text(")"),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(4.0),
                                                      child: Row(
                                                        children: [
                                                          Text("₹",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[900],
                                                                fontWeight: FontWeight
                                                                    .bold),),
                                                          Text(
                                                            documentSnapshot["price"]
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .lato(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .red[900],
                                                                fontWeight: FontWeight
                                                                    .bold),),


                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(4.0),
                                                      child: Row(
                                                        children: [
                                                          Text("Save ₹"),
                                                          Text(
                                                              documentSnapshot["Discount"]
                                                                  .toString()),
                                                        ],
                                                      ),
                                                    )


                                                  ],
                                                ),
                                              ),

                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 20,),
                                        documentSnapshot["Confirmed"]
                                            ? Container(
                                          width: 320,
                                          child: RaisedButton(
                                            onPressed: () {

                                            },

                                            color: Colors.green[100],
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [

                                                Text("Confirm Order",
                                                  style: GoogleFonts.raleway(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .blueGrey[900]),
                                                ),
                                                SizedBox(width: 30,),
                                                Icon(Icons.assignment_turned_in,
                                                  color: Colors.cyan[900],
                                                  size: 20,),
                                              ],
                                            ),
                                          ),
                                        )
                                            : Container(
                                          width: 320,
                                          child: RaisedButton(
                                            onPressed: () {
//                                    statechange(documentSnapshot["Timestamp"]);
                                            },
                                            color: Colors.grey[100],
                                            child: Text("Confirm Order",
                                              style: GoogleFonts.raleway(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey[900]),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: 1.5,
                                            height: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        documentSnapshot["Shipped"] ? Container(
                                          width: 320,
                                          child: RaisedButton(
                                            onPressed: () {

                                            },
                                            color: Colors.green[100],
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text("Order Shipped",
                                                  style: GoogleFonts.raleway(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .blueGrey[900]),
                                                ),
                                                SizedBox(width: 30,),
                                                Icon(Icons.assignment_turned_in,
                                                  color: Colors.cyan[900],
                                                  size: 20,),
                                              ],
                                            ),
                                          ),
                                        ) : Container(
                                          width: 320,
                                          child: RaisedButton(
                                            onPressed: () {
//                                    statechange2(documentSnapshot["Timestamp"]);
                                            },
                                            color: Colors.grey[100],
                                            child: Text("Order Shipped ",
                                              style: GoogleFonts.raleway(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey[900]),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: 1.5,
                                            height: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        documentSnapshot["Delivered"]
                                            ? Container(
                                          width: 320,
                                          child: RaisedButton(
                                            onPressed: () {

                                            },
                                            color: Colors.green[100],
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text("Order Delivered",
                                                  style: GoogleFonts.raleway(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .blueGrey[900]),
                                                ),
                                                SizedBox(width: 30,),
                                                Icon(Icons.assignment_turned_in,
                                                  color: Colors.cyan[900],
                                                  size: 20,),
                                              ],
                                            ),
                                          ),
                                        )
                                            : Container(
                                          width: 320,
                                          child: RaisedButton(
                                            onPressed: () {
                                              statechange(
                                                  documentSnapshot["Timestamp"],
                                                  documentSnapshot["shop_id"]);
                                            },
                                            color: Colors.grey[100],
                                            child: Text("Order delivered",
                                              style: GoogleFonts.raleway(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey[900]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        documentSnapshot["Rated"] ? SizedBox(
                                          height: 0,) :
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: [
                                              Container(
                                                width: 160,

                                                child: RaisedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (
                                                            BuildContext context) {
                                                          return AlertDialog(
                                                            title: Center(
                                                                child: Text(
                                                                  "Rate The Product!!!",
                                                                  style: GoogleFonts
                                                                      .zillaSlab(
                                                                      fontSize: 23,
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .green[400]),)),
                                                            content: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(8.0),
                                                              child: Container(
                                                                width: 500,
                                                                height: 60,
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 10.0,
                                                                    right: 10.0),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        10.0),
                                                                    color: Colors
                                                                        .grey[100],
                                                                    border: Border
                                                                        .all(
                                                                        color: Colors
                                                                            .grey)),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .rate_review),
                                                                    SizedBox(
                                                                      width: 10,),
                                                                    DropdownButtonHideUnderline(
                                                                      child: DropdownButton(
                                                                          value: rate,
                                                                          items: [

                                                                            DropdownMenuItem(
                                                                              child: Text(
                                                                                  "1",
                                                                                  style: TextStyle(
                                                                                      fontSize: 17,
                                                                                      color: Colors
                                                                                          .black)),
                                                                              value: 1,

                                                                            ),
                                                                            DropdownMenuItem(
                                                                                child: Text(
                                                                                    "2",
                                                                                    style: TextStyle(
                                                                                        fontSize: 17,
                                                                                        color: Colors
                                                                                            .black)),
                                                                                value: 2
                                                                            ),
                                                                            DropdownMenuItem(
                                                                                child: Text(
                                                                                    "3",
                                                                                    style: TextStyle(
                                                                                        fontSize: 17,
                                                                                        color: Colors
                                                                                            .black)),
                                                                                value: 3
                                                                            ),
                                                                            DropdownMenuItem(
                                                                                child: Text(
                                                                                    "4",
                                                                                    style: TextStyle(
                                                                                        fontSize: 17,
                                                                                        color: Colors
                                                                                            .black)),
                                                                                value: 4
                                                                            ),
                                                                            DropdownMenuItem(
                                                                                child: Text(
                                                                                    "5",
                                                                                    style: TextStyle(
                                                                                        fontSize: 17,
                                                                                        color: Colors
                                                                                            .black)),
                                                                                value: 5

                                                                            )
                                                                          ],
                                                                          onChanged: (
                                                                              value) {
                                                                            setState(() {
                                                                              rate =
                                                                                  value;
                                                                            });
                                                                          }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            actions: [
                                                              FlatButton(
                                                                child: Text(
                                                                  " Rate ",
                                                                  style: GoogleFonts
                                                                      .zillaSlab(
                                                                      fontSize: 22,
                                                                      fontWeight: FontWeight
                                                                          .bold),),
                                                                onPressed: () {
                                                                  rate_update(
                                                                      documentSnapshot['Timestamp'],
                                                                      documentSnapshot['Category'],
                                                                      documentSnapshot['Product_id']);
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  color: Colors.amber[200],

                                                  child: Text("Rate Order",
                                                    style: GoogleFonts.raleway(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .blueGrey[900]),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],

                                    ),
                                  ),
                                ),
                              ),
                            );

                        }
                          if (!snapshot.hasData){
                            print('test phrase');
                            return Text("");
                          }
                        }
                  );


                }


            );
          }
          if (!snapshot.hasData){
            print('test phrase');
            return Text("");
          }

        },

      ),
    );
  }
}

