import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  Razorpay razorpay;
//  TextEditingController textEditingController = new TextEditingController();


  final User user = FirebaseAuth.instance.currentUser;
  String firstHalf;
  final databaseReference = FirebaseFirestore.instance;
  void Remove (var time) async {
    await databaseReference.collection("Cart")
        .doc("${user.uid}").collection("Items").doc("$time")
        .delete();
  }

  void orderrecieved(var time)async{
    final User user = FirebaseAuth.instance.currentUser;
//    var shop_hash=timestamp.toString()+(user.uid).toString();


    await databaseReference.collection("Orders")
        .doc("$shopid").collection("Items").doc("$time")
        .set({
      'Product': product_name ,
      'user_name':name,
      'user_id':user.uid,
      'Phone':phone,
      'Address':add,
      'Image': image,
      'price': price,
      "Timestamp":time,
      "shop_id":shopid,
      "Product_id":product_id,
      "Confirmed":false,
      "Shipped":false,
      "Delivered":false,
    });
    await databaseReference.collection("MyOrders")
        .doc("${user.uid}").collection("Items").doc("$time")
        .set({
      'Product': product_name ,
      "Shop_name":shopname,
      'Phone':phone,
      'Address':add,
      'Image': image,
      'price': price,
      "Timestamp":time,
      "shop_id":shopid,
      "Product_id":product_id,
      "Rating":rating,
      "Rating_Count":ratingcount,
      "Rating_Final":ratingfinal,
      "Discount":discount,
      "Confirmed":false,
      "Shipped":false,
      "Delivered":false,
      "Rated":false,
      "Category":cat,
    });
  }

  var add="";
  var product_name="";
  var name="";
  var phone="";
  var shopid;
  var price;
  var image;
  var product_id;
  var discount;
  var shopname;
  var rating;
  var ratingcount;
  var ratingfinal;
  var cat;



  void addreess()async{
    final User user = FirebaseAuth.instance.currentUser;
//  final snapShot = await FirebaseFirestore.instance.collection('${user.email}').doc("$spendtype").get();
    final snapShot = await FirebaseFirestore.instance.collection('Users').doc("${user.uid}").get();

    add=snapShot.data()["Address"];
    name=snapShot.data()["Name"];
    phone=snapShot.data()["Phone"];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addreess();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(var amt){
    var options = {
      "key" : "rzp_test_GX6qClzYjXFCyC",
      "amount" : amt*100,
      "name" : "$name",
      "description" : "Payment for the some random product",
      "prefill" : {
        "contact" : "$phone",
        "email" : "${user.email}"
      },
      "external" : {
        "wallets" : ["paytm"]
      },

    };

    try{
      razorpay.open(options);


    }catch(e){
      print(e.toString());
    }

  }
  var timestamp;



  void _handlerPaymentSuccess(PaymentSuccessResponse response) {
//    print("Pament success");

    quantity();
    orderrecieved(DateTime.now().microsecondsSinceEpoch);
    Remove(timestamp);


    Navigator.pushNamed(context, "/wish");
    Toast.show("Pament success", context);
  }

  void handlerErrorFailure(){
    print("Pament error");
    Toast.show("Pament error", context);
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  void quantity()async{
    final snapShot = await FirebaseFirestore.instance.collection('Categories').doc("$cat").collection("Products").doc('$product_id').get();
    var quantity=int.parse(snapShot.data()['Quantity']);
    setState(() {
      quantity=quantity-1;
    });
    await databaseReference.collection("Categories")
        .doc("$cat")
        .collection("Products")
        .doc("$product_id")
        .update({
      'Quantity':quantity.toString(),
    });
//    await databaseReference.collection("Cart")
//        .doc("${user.uid}")
//        .collection("Items")
//        .doc("$timestamp")
//        .update({
//      'Quantity':quantity.toString(),
//    });

  }


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
                Text("My",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.pink),),
                Text("Cart",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.amber[400]),),
              ],
            ),
            Icon(Icons.perm_identity,size: 35,)
          ],
        ),
        centerTitle: true,

      ),
      body: ListView(
          physics: BouncingScrollPhysics(),
        children:[StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Cart").doc("${user.uid}").collection("Items").snapshots(),

          builder: (context,snapshot){
            if(snapshot.hasData){


              return ListView.builder(

                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot documentSnapshot=snapshot.data.documents[index];


                    return Container(
                      height: 260,
                      child: Card(
                        elevation: 1,

                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [

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

                                                  Text(documentSnapshot["Shop_name"],style:GoogleFonts.raleway(fontSize: 14,fontWeight: FontWeight.bold),),
                                                ],
                                              ),

                                            ],
                                          ),Padding(
                                            padding: const EdgeInsets.all(3.0),

                                            child:Column(
                                              children: [
                                                if(documentSnapshot["Product"].toString().length>50) Text("${documentSnapshot["Product"].toString().substring(0,49)}...",style:GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold)),
                                                if(documentSnapshot["Product"].toString().length<=50) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold)),
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
                                          ),




                                        ],
                                      ),
                                    ),

                                  ),
//                                  Image.network(documentSnapshot["Image"],width: 120,height: 120,),
                                  CachedNetworkImage(
                                    imageUrl:documentSnapshot["Image"],
                                    width: 120,
                                    height: 120,

                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                            height: 800,
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
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Text("User Name:",style: GoogleFonts.raleway(fontSize: 20,color: Colors.pink[900],fontWeight: FontWeight.bold),),
                                                  ),
                                                  Container(
                                                    width:double.infinity,
                                                    child: Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Text("$name",style: GoogleFonts.raleway(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)),
                                                      ),
                                                    ),
                                                  ),Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Text("Phone number:",style: GoogleFonts.raleway(fontSize: 20,color: Colors.pink[900],fontWeight: FontWeight.bold),),
                                                  ),
                                                  Container(
                                                    width:double.infinity,
                                                    child: Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Text("$phone",style: GoogleFonts.lato(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)),
                                                      ),
                                                    ),
                                                  ),Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Text("Delivered to:",style: GoogleFonts.raleway(fontSize: 20,color: Colors.pink[900],fontWeight: FontWeight.bold),),
                                                  ),
                                                  Container(
                                                    child: Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text("$add",style: GoogleFonts.raleway(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)),
                                                      ),
                                                    ),
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
                                                                    Text('Cash on delivery',style: GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),),
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
//                                                            adddetails(documentSnapshot["Product"],documentSnapshot["Category"],documentSnapshot["Quantity"],documentSnapshot["Price"],documentSnapshot["Image"],DateTime.now().microsecondsSinceEpoch,documentSnapshot["Discount"],documentSnapshot["Brand"],documentSnapshot["shop_hash"],documentSnapshot["Rating"],documentSnapshot["Rating_Count"],documentSnapshot["shop_id"],documentSnapshot["Shop_name"]);
                                                              Navigator.pop(context);
                                                            },
                                                            child: InkWell(
                                                              onTap: (){
                                                                setState(() {
                                                                        timestamp=documentSnapshot["Timestamp"];
                                                                        product_id=documentSnapshot["shop_hash"];
                                                                        product_name=documentSnapshot["Product"];
                                                                        shopid=documentSnapshot["shop_id"];
                                                                        price=int.parse(documentSnapshot['Price'])-int.parse(documentSnapshot['Discount']);
                                                                        discount=documentSnapshot["Discount"];
                                                                        image=documentSnapshot["Image"];
                                                                        shopname=documentSnapshot["Shop_name"];
                                                                        rating=documentSnapshot["Rating"];
                                                                        ratingcount=documentSnapshot["Rating_Count"];
                                                                        ratingfinal=documentSnapshot["Rating_Final"];
                                                                        shopname=documentSnapshot["Shop_name"];
                                                                        cat=documentSnapshot["Category"];
                                                                });
                                                                openCheckout((int.parse(documentSnapshot["Price"]))-(int.parse(documentSnapshot["Discount"])));
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
                                                                      Text('Online payment',style: GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),),
                                                                    ],
                                                                  ),
                                                                )),
                                                                elevation: 2,
                                                              ),
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
                                        );
                                      },
                                    );
                                  },
                                  child:Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.amber[300],
                                    shadowColor: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.shopping_cart),
                                          SizedBox(width: 10,),
                                          Text('Place order',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),),
                                        ],
                                      )),
                                    ),
                                    elevation: 2,
                                  ),
                                ),
                                SizedBox(width: 30,),
                                InkWell(
                                  onTap: (){
                                    Remove(documentSnapshot["Timestamp"]);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.amber[300],
                                    shadowColor: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.delete),
                                          SizedBox(width: 10,),
                                          Text('Remove',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),),
                                        ],
                                      )),
                                    ),
                                    elevation: 2,
                                  ),
                                ),
                              ],
                            )
                          ],
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
  ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        backgroundColor: Colors.grey[100],
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/home");
                },
                child: new Icon(Icons.home,)),
            title: new Text('Home',
              style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold,),),
          ),
          BottomNavigationBarItem(
            icon: InkWell(onTap: (){
              Navigator.pushNamed(context, "/wish");
            },child: new Icon(Icons.favorite,)),
            title: new Text('Wishlist',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
          ),
          BottomNavigationBarItem(
            icon: InkWell(onTap: (){
              Navigator.pushNamed(context, "/cart");
            },child: new Icon(Icons.shopping_cart,color: Colors.red[900],)),
            title: new Text('Cart',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)),
          ),

//            BottomNavigationBarItem(
//              icon: InkWell(onTap: (){
//                Navigator.pushNamed(context, "/Dashboard");
//              },child: new Icon(Icons.dashboard)),
//              title: new Text('Dashboard',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
//            ),


        ],
      ),
    );
  }
}
