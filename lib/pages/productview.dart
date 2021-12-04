import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
      "Rating_Final":rating_count,

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
                    Text('Removed Sucessfully!!!',style: GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold,color: CupertinoColors.white),),
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


  @override
  Widget build(BuildContext context) {
    userdata=ModalRoute.of(context).settings.arguments;
    cat_name=userdata['Category'];


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
        stream: FirebaseFirestore.instance.collection("Categories").doc("$cat_name").collection("Products").snapshots(),

        builder: (context,snapshot){
          if(snapshot.hasData){


            return ListView.builder(
                physics: BouncingScrollPhysics(),

                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  DocumentSnapshot documentSnapshot=snapshot.data.documents[index];


                  return Container(
                    height: 250,
                    child: InkWell(
                      onTap: (){
                        func(documentSnapshot["shop_hash"],cat_name);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
//                             Image.network(documentSnapshot["Image"],),
                              CachedNetworkImage(
                                imageUrl:documentSnapshot["Image"],
                                width: 160,

                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.location_on,color: Colors.pink[900],size: 18,),
                                              SizedBox(width: 3,),
                                              Text(documentSnapshot["Shop_name"],style:GoogleFonts.raleway(fontSize: 14,fontWeight: FontWeight.bold))
                                            ],
                                          ),

                                          InkWell(


                                              onTap: (){
                                                  checkheart(documentSnapshot["Product"],documentSnapshot["Category"],documentSnapshot["Quantity"],documentSnapshot["Price"],documentSnapshot["Image"],DateTime.now().microsecondsSinceEpoch,documentSnapshot["Discount"],documentSnapshot["Brand"],documentSnapshot["shop_hash"],documentSnapshot["Rating"],documentSnapshot["Rating_Count"],documentSnapshot["shop_id"],documentSnapshot["Shop_name"]);
//                                                if(dash==true)Remove(documentSnapshot["shop_hash"]);
//                                                if(dash==false)adddetails(documentSnapshot["Product"],documentSnapshot["Category"],documentSnapshot["Quantity"],documentSnapshot["Price"],documentSnapshot["Image"],DateTime.now().microsecondsSinceEpoch,documentSnapshot["Discount"],documentSnapshot["Brand"],documentSnapshot["shop_hash"],documentSnapshot["Rating"],documentSnapshot["Rating_Count"],documentSnapshot["shop_id"],documentSnapshot["Shop_name"]);
                                              },
                                              child: Column(
                                                children: [
                                                  Icon(Icons.favorite_border,color: Colors.red[900],),

                                                ],
                                              ))
                                        ],
                                      ),Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Column(
                                          children: [
                                            if(documentSnapshot["Product"].toString().length>70) Text("${documentSnapshot["Product"].toString().substring(0,69)}...",style:GoogleFonts.raleway(fontSize: 15,fontWeight: FontWeight.bold)),
                                            if(documentSnapshot["Product"].toString().length<=70) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 15,fontWeight: FontWeight.bold)),
                                          ],
                                        )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            if(documentSnapshot["Rating_Final"]==0)Row(
                                              children: [
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                              ],
                                            ),
                                            if(documentSnapshot["Rating_Final"]==1)Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                              ],
                                            ),if(documentSnapshot["Rating_Final"]==2)Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                              ],
                                            ),if(documentSnapshot["Rating_Final"]==3)Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                              ],
                                            ),if(documentSnapshot["Rating_Final"]==4)Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star_border,color: Colors.amber[900],size: 21,),
                                              ],
                                            ),if(documentSnapshot["Rating_Final"]==5)Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                                Icon(Icons.star,color: Colors.amber[900],size: 26,),
                                              ],
                                            ),

                                            Text("  ("),
                                            Text(documentSnapshot["Rating_Count"].toString()),
                                            Text(")"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Text("₹",style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.bold),),
                                            Text((int.parse(documentSnapshot["Price"].toString())-int.parse(documentSnapshot["Discount"].toString())).toString(),style: GoogleFonts.lato(fontSize: 18,color: Colors.red[900],fontWeight: FontWeight.bold),),
                                            Text("  "),
                                            Text(documentSnapshot["Price"].toString(), style: GoogleFonts.lato(fontSize:18,decoration: TextDecoration.lineThrough)),

                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Text("Save ₹"),
                                            Text(documentSnapshot["Discount"].toString()),
                                          ],
                                        ),
                                      )



                                    ],
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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