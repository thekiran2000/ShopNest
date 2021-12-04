import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductInfo extends StatefulWidget {
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  var userdata;
  var cat_name;
  var cat_name1;

//  var ratingfinal;
  final databaseReference = FirebaseFirestore.instance;

  void adddetails(var name,var cat,var quantity,var price,var img_url,var timestamp,var disc,var brand,var shop_hash,var rating,var rating_count,var shop_id,var shopname,var ratingfinal) async{

    final User user = FirebaseAuth.instance.currentUser;



    await databaseReference.collection("Cart")
        .doc("${user.uid}").collection("Items").doc("$timestamp")
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
      "Rating_Final":ratingfinal,

    });
  }


  @override
  Widget build(BuildContext context) {
    userdata=ModalRoute.of(context).settings.arguments;
    cat_name=userdata['hash'];
    cat_name1=userdata['cat'];


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
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Categories").doc("$cat_name1").collection("Products").doc("$cat_name").snapshots(),

          builder: (context,snapshot){
          if(snapshot.hasData){
            DocumentSnapshot documentSnapshot=snapshot.data;
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on,color: Colors.pink[900],size: 18,),
                        SizedBox(width: 3,),
                        Text(documentSnapshot["Shop_name"],style:GoogleFonts.raleway(fontSize: 14,fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 8,),
                    Text(documentSnapshot["Brand"],style:GoogleFonts.raleway(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.blueGrey[900])),
                    SizedBox(height: 10,),
                    Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 15,fontWeight: FontWeight.bold)),
                    Column(
                      children: [
                        Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl:documentSnapshot["Image"],
                            width: 270,
                            height: 270,

                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(documentSnapshot["Rating_Final"]==0)Row(
                                children: [
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                ],
                              ),
                              if(documentSnapshot["Rating_Final"]==1)Row(
                                children: [
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                ],
                              ),if(documentSnapshot["Rating_Final"]==2)Row(
                                children: [
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                ],
                              ),if(documentSnapshot["Rating_Final"]==3)Row(
                                children: [
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                ],
                              ),if(documentSnapshot["Rating_Final"]==4)Row(
                                children: [
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star_border,color: Colors.amber[900],size: 24,),
                                ],
                              ),if(documentSnapshot["Rating_Final"]==5)Row(
                                children: [
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 30,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 24,),
                                  Icon(Icons.star,color: Colors.amber[900],size: 24,),
                                ],
                              ),

                              Text("  ("),
                              Text(documentSnapshot["Rating_Count"].toString()),
                              Text(")"),


                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0,10,5,1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("M.R.P : ",style: GoogleFonts.raleway(color: Colors.red[900],fontWeight: FontWeight.bold,fontSize: 18),),
                                  Text("₹",style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.bold,fontSize: 20),),
                                  SizedBox(width: 5,),
                                  Text((int.parse(documentSnapshot["Price"].toString())-int.parse(documentSnapshot["Discount"].toString())).toString(),style: GoogleFonts.lato(fontSize: 26,color: Colors.red[900],fontWeight: FontWeight.bold),),


                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  SizedBox(width: 55,),
                                  Text("  ₹",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 18),),
                                  Text(documentSnapshot["Price"].toString(), style: GoogleFonts.lato(fontSize:15,decoration: TextDecoration.lineThrough,)),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Row(
                                      children: [
                                        Text("    Save ₹"),
                                        Text(documentSnapshot["Discount"].toString()),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8,),
                              Text("FREE delivery",style: GoogleFonts.raleway(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blueGrey[500]),),
                              Text("Within four days",style: GoogleFonts.raleway(fontSize: 16,color: Colors.blueGrey[700]),),
                            ],
                          ),
                        ),

                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          elevation: 0,
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Text("Description:",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.pink[900]),),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(2.0),
                                   child: Text(documentSnapshot["Desc"],style: GoogleFonts.raleway(fontSize: 18,letterSpacing: 0.2,wordSpacing: 5),),
                                 )
                               ],
                             ),
                           ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                      child: Row(
                        children: [
                          Text("Total: ",style: GoogleFonts.raleway(color: Colors.red[900],fontWeight: FontWeight.bold,fontSize: 18),),
                          Text("₹",style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(width: 5,),
                          Text((int.parse(documentSnapshot["Price"].toString())-int.parse(documentSnapshot["Discount"].toString())).toString(),style: GoogleFonts.lato(fontSize: 26,color: Colors.red[900],fontWeight: FontWeight.bold),),


                        ],
                      ),
                    ),
                    if(int.parse(documentSnapshot["Quantity"])>0)Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                      child: Text("In Stock",style: GoogleFonts.raleway(color: Colors.cyan[900],fontWeight: FontWeight.bold,fontSize: 18),),
                    ),
                    if(int.parse(documentSnapshot["Quantity"])==0)Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                      child: Text("Out of Stock",style: GoogleFonts.raleway(color: Colors.pink[900],fontWeight: FontWeight.bold,fontSize: 18),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                      child: Text("Sold by: ${documentSnapshot["Shop_name"]} and fulfiled by ShopNest.",style: GoogleFonts.raleway(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 18),),
                    ),
                    SizedBox(height: 20,),
                    if(int.parse(documentSnapshot["Quantity"])>=1)Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey)),
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 350,
                                color: Colors.grey[100],
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(height: 8,),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on,color: Colors.pink[900],size: 18,),
                                            SizedBox(width: 3,),
                                            Text(documentSnapshot["Shop_name"],style:GoogleFonts.raleway(fontSize: 14,fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                                        child: Text(documentSnapshot["Brand"],style:GoogleFonts.raleway(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.blueGrey[900])),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                                        child: Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 15,fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                                        child: Row(
                                          children: [
                                            Text("Total: ",style: GoogleFonts.raleway(color: Colors.red[900],fontWeight: FontWeight.bold,fontSize: 18),),
                                            Text("₹",style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.bold,fontSize: 20),),
                                            SizedBox(width: 5,),
                                            Text((int.parse(documentSnapshot["Price"].toString())-int.parse(documentSnapshot["Discount"].toString())).toString(),style: GoogleFonts.lato(fontSize: 26,color: Colors.red[900],fontWeight: FontWeight.bold),),


                                          ],
                                        ),
                                      ),
                                      if(int.parse(documentSnapshot["Quantity"])>0)Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                                        child: Text("In Stock",style: GoogleFonts.raleway(color: Colors.cyan[900],fontWeight: FontWeight.bold,fontSize: 18),),
                                      ),
                                      if(int.parse(documentSnapshot["Quantity"])==0)Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                                        child: Text("Out of Stock",style: GoogleFonts.raleway(color: Colors.pink[900],fontWeight: FontWeight.bold,fontSize: 18),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0,2,2,2),
                                        child: Text("Sold by: ${documentSnapshot["Shop_name"]} and fulfiled by ShopNest.",style: GoogleFonts.raleway(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 18),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,12,0,2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: Colors.grey[100],
                                                  border: Border.all(color: Colors.grey)),
                                              height: 50,
                                              child :InkWell(
                                                onTap:(){
                                                  Navigator.pop(context);
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  color: Colors.amber[400],

                                                  child: Center(child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.cancel),
                                                        SizedBox(width: 2,),
                                                        Text('  Cancel      ',style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),),
                                                      ],
                                                    ),
                                                  )),
                                                  elevation: 2,
                                                ),
                                              ),
                                            ),Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: Colors.grey[100],
                                                  border: Border.all(color: Colors.grey)),
                                              height: 50,
                                              child :InkWell(
                                                onTap:(){

                                                  adddetails(documentSnapshot["Product"],documentSnapshot["Category"],documentSnapshot["Quantity"],documentSnapshot["Price"],documentSnapshot["Image"],DateTime.now().microsecondsSinceEpoch,documentSnapshot["Discount"],documentSnapshot["Brand"],documentSnapshot["shop_hash"],documentSnapshot["Rating"],documentSnapshot["Rating_Count"],documentSnapshot["shop_id"],documentSnapshot["Shop_name"],documentSnapshot["Rating_Final"]);
                                                  Navigator.pop(context);
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  color: Colors.amber[300],

                                                  child: Center(child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.shopping_cart),
                                                        SizedBox(width: 2,),
                                                        Text('Add to cart',style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),),
                                                      ],
                                                    ),
                                                  )),
                                                  elevation: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.amber[700],
                          shadowColor: Colors.red,
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart),
                              SizedBox(width: 10,),
                              Text('Add To Cart',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),),
                            ],
                          )),
                          elevation: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 7,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey)),
                      height: 50,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "/cart");
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.amber[300],
                          shadowColor: Colors.red,
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart),
                              SizedBox(width: 10,),
                              Text('Go To Cart',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),),
                            ],
                          )),
                          elevation: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );

          }
          if (!snapshot.hasData){
            print('test phrase');
            return Text("");
          }
          },
          ),
      )
    );
  }
}
