import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final User user = FirebaseAuth.instance.currentUser;

  var dropdownValue='DAP';
  var category=1;

  var category_x="Fashion";

  final databaseReference = FirebaseFirestore.instance;

  var name;
  var desc;
  var quantity;
  var img_url;
  var price;
  var cat;

  final nameHolder1 = TextEditingController();
  final nameHolder2 = TextEditingController();
  final nameHolder3 = TextEditingController();
  final nameHolder4 = TextEditingController();
  final nameHolder5 = TextEditingController();
  final nameHolder6 = TextEditingController();
  final nameHolder7 = TextEditingController();

  clearTextInput(){

    nameHolder1.clear();
    nameHolder2.clear();
    nameHolder3.clear();
    nameHolder4.clear();
    nameHolder5.clear();
    nameHolder6.clear();
    nameHolder7.clear();

  }


  void createRecord(var name,var cat,var desc,var quantity,var price,var img_url,var timestamp,var disc,var brand) async {
    final User user = FirebaseAuth.instance.currentUser;
    var shop_hash=timestamp.toString()+(user.uid).toString();
    final snapShot = await FirebaseFirestore.instance.collection('Buisness_User').doc("${user.uid}").get();
    var gg;
    gg=snapShot.data()["Shop_name"];

    await databaseReference.collection("Categories")
        .doc("$cat").collection("Products").doc("$shop_hash")
        .set({
      "Product":name,
      "Category":cat,
      "Desc":desc,
      "Quantity":quantity,
      "Price":price,
      "Image":img_url,
      "Timestamp":timestamp,
      "shop_id":"${user.uid}",
      "Shop_name":gg,
      "shop_hash":shop_hash,
      "Discount":disc,
      "Brand":brand,
      "Rating":0,
      "Rating_Count":0,
      "Rating_Final":0,

    });
    await databaseReference.collection("All")
        .doc("$shop_hash")
        .set({
      "Product":name,
      "Category":cat,
      "Desc":desc,
      "Quantity":quantity,
      "Price":price,
      "Image":img_url,
      "Timestamp":timestamp,
      "shop_id":"${user.uid}",
      "Shop_name":gg,
      "shop_hash":shop_hash,
      "Discount":disc,
      "Brand":brand,
      "Rating":0,
      "Rating_Count":0,
      "Rating_Final":0,

    });

  }

  void statechange(var time)async{
    final snapShot = await FirebaseFirestore.instance.collection('Orders').doc("${user.uid}").collection("Items").doc("$time").get();
    var user_id=snapShot.data()["user_id"];
    final snapShot2 = await FirebaseFirestore.instance.collection('MyOrders').doc("$user_id").collection("Items").doc("$time").get();

    var check=snapShot.data()["Confirmed"];

//    var check2=snapShot.data()["Confirmed"];

    if(check==false){
      await databaseReference.collection('Orders').doc("${user.uid}").collection("Items").doc("$time")
          .update({
        "Confirmed":true,
          });
      await databaseReference..collection('MyOrders').doc("$user_id").collection("Items").doc("$time")
          .update({
        "Confirmed":true,
          });
    }


  }
  void statechange2(var time)async{
    final snapShot = await FirebaseFirestore.instance.collection('Orders').doc("${user.uid}").collection("Items").doc("$time").get();
    var user_id=snapShot.data()["user_id"];
    final snapShot2 = await FirebaseFirestore.instance.collection('MyOrders').doc("$user_id").collection("Items").doc("$time").get();


    var check1=snapShot.data()["Shipped"];
    var check2=snapShot.data()["Confirmed"];
//    var check2=snapShot.data()["Confirmed"];

    if(check1==false && check2==true){
      await databaseReference.collection('Orders').doc("${user.uid}").collection("Items").doc("$time")
          .update({
        "Shipped":true,
      });
      await databaseReference..collection('MyOrders').doc("$user_id").collection("Items").doc("$time")
          .update({
        "Shipped":true,
      });
    }


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
              Text("Shop",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.pink),),
              Text("Nest",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.amber[400]),),
            ],
          ),
          InkWell(
             onTap: (){
               Navigator.pushNamed(context, "/edit");
             },
              child: Icon(Icons.mode_edit,size: 35,))
        ],
      ),
      centerTitle: true,

    ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,8,0,8),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 4,
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Welcome,",style: TextStyle(color: Colors.amber,fontSize: 30,fontWeight: FontWeight.bold),),
                        Text("Shop",style: TextStyle(color: Colors.pink,fontSize: 30,fontWeight: FontWeight.bold),),
                      ],
                    )),
                  ),
                ),
              ),
              Container(
                height: 800,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Add Following Details To add Item ....',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[400]),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),

                        ),
                        child: TextField(
                          controller: nameHolder1,

                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.card_giftcard,color: Colors.black,),
                            hintText: "Name Of product",
                            hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 500,
                        height: 60,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          children: [
                            Icon(Icons.category),
                            SizedBox(width: 10,),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: category_x,

                                  items: [

                                    DropdownMenuItem(
                                      child: Text("Fashion",style: TextStyle(fontSize: 17,color: Colors.black)),
                                      value: "Fashion",

                                    ),
                                    DropdownMenuItem(
                                        child: Text("Mobile",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Mobile",
                                    ),
                                    DropdownMenuItem(
                                        child: Text("Electronics",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value:"Electronics",
                                    ),
                                    DropdownMenuItem(
                                        child: Text("Home",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Home"
                                    ),DropdownMenuItem(
                                        child: Text("Appliances",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Appliances"
                                    ),DropdownMenuItem(
                                        child: Text("Beauty",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Beauty"
                                    ),DropdownMenuItem(
                                        child: Text("Toys & baby",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Toys & baby"
                                    ),DropdownMenuItem(
                                        child: Text("Sports",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Sports"
                                    ),DropdownMenuItem(
                                        child: Text("Furniture",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Furniture"
                                    ),DropdownMenuItem(
                                        child: Text("Food & more",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Food & more"
                                    ),DropdownMenuItem(
                                        child: Text("Stationary",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Stationary"
                                    ),DropdownMenuItem(
                                        child: Text("Artifacts",style: TextStyle(fontSize: 17,color: Colors.black)),
                                        value: "Artifacts"
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                        category_x=value;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),

                        ),
                        child: TextField(
                          controller: nameHolder2,

                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description,color: Colors.black,),
                            hintText: "Description of Product",
                            hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),

                        ),
                        child: TextField(
                          controller: nameHolder3,

                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.add_box,color: Colors.black,),
                            hintText: "Quantity",
                            hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),

                        ),
                        child: TextField(
                          controller: nameHolder4,

                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.monetization_on,color: Colors.black,),
                            hintText: "Price",
                            hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                          ),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),

                        ),
                        child: TextField(
                          controller: nameHolder6,

                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.content_cut,color: Colors.black,),
                            hintText: "Discount",
                            hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                          ),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),

                        ),
                        child: TextField(
                          controller: nameHolder7,

                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.bookmark,color: Colors.black,),
                            hintText: "Brand",
                            hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                          ),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),

                        ),

                        child: TextField(
                          controller: nameHolder5,

                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.image,color: Colors.black,),
                            hintText: "Image Url",
                            hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),


                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      child: InkWell(
                        onTap: (){
                          createRecord(nameHolder1.text,category_x,nameHolder2.text,nameHolder3.text,nameHolder4.text,nameHolder5.text,DateTime.now().microsecondsSinceEpoch,nameHolder6.text,nameHolder7.text);
                          clearTextInput();
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.amberAccent[100],
                          shadowColor: Colors.red,
                          child: Center(child: Text('Add Item',style: GoogleFonts.raleway(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),)),
                          elevation: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Orders recived....."),
              ),
        StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Orders").doc("${user.uid}").collection("Items").snapshots(),

          builder: (context,snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: BouncingScrollPhysics(),

                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot = snapshot.data
                        .documents[index];

                    return Container(
                      height: 700,
                      child: Card(
                        elevation: 4,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,5,0),
                              child: Image.network(documentSnapshot["Image"],width: 140,height: 160,),
                            ),
                            Container(
                              width: 0.2,
                              height: double.maxFinite,
                              color: Colors.grey,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [


//                                            SizedBox(width: 1,)
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child:Column(
                                        children: [
                                          if(documentSnapshot["Product"].toString().length>80) Text("${documentSnapshot["Product"].toString().substring(0,79)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                          if(documentSnapshot["Product"].toString().length<=80) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                        ],
                                      )
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Total:", style: GoogleFonts.lato(fontSize:20,fontWeight: FontWeight.bold,color: Colors.pink[900])),
                                            ],
                                          ),
                                          SizedBox(height: 4,),
                                          Text("₹${documentSnapshot["price"].toString()}", style: GoogleFonts.lato(fontSize:18,fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4,),
                                          Row(
                                            children: [
                                              Text("Recipent:", style: GoogleFonts.lato(fontSize:20,fontWeight: FontWeight.bold,color: Colors.pink[900])),
                                            ],
                                          ),
                                          SizedBox(height: 4,),
                                          Text(documentSnapshot["user_name"].toString(), style: GoogleFonts.lato(fontSize:18,fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4,),
                                          Row(
                                            children: [
                                              Text("Phone No:", style: GoogleFonts.lato(fontSize:20,fontWeight: FontWeight.bold,color: Colors.pink[900])),
                                            ],
                                          ),
                                          SizedBox(height: 4,),
                                          Text( documentSnapshot["Phone"].toString(), style: GoogleFonts.lato(fontSize:18,fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4,),
                                          Row(
                                            children: [
                                              Text("Address:", style: GoogleFonts.lato(fontSize:20,fontWeight: FontWeight.bold,color: Colors.pink[900])),
                                            ],
                                          ),
                                          SizedBox(height: 4,),
                                          Text(documentSnapshot["Address"].toString(), style: GoogleFonts.lato(fontSize:18,fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4,),

                                        ],
                                      ),
                                    ),


                                    documentSnapshot["Confirmed"] ? Container(
                                      width: 320,
                                      child: RaisedButton(
                                        onPressed: (){

                                        },
                                        color:Colors.green[100],
                                        child: Text("Confirm Order",
                                          style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),
                                        ),
                                      ),
                                    ):Container(
                                      width: 320,
                                      child: RaisedButton(
                                        onPressed: (){
                                          statechange(documentSnapshot["Timestamp"]);
                                        },
                                        color:Colors.grey[100],
                                        child: Text("Confirm Order",
                                          style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),
                                        ),
                                      ),
                                    ),

                                    documentSnapshot["Shipped"] ? Container(
                                      width: 320,
                                      child: RaisedButton(
                                        onPressed: (){

                                        },
                                        color:Colors.green[100],
                                        child: Text("Order Shipped",
                                          style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),
                                        ),
                                      ),
                                    ):Container(
                                      width: 320,
                                      child: RaisedButton(
                                        onPressed: (){
                                          statechange2(documentSnapshot["Timestamp"]);
                                        },
                                        color:Colors.grey[100],
                                        child: Text("Order Shipped ",
                                          style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),
                                        ),
                                      ),
                                    ),
                                    documentSnapshot["Delivered"] ? Container(
                                      width: 320,
                                      child: RaisedButton(
                                        onPressed: (){

                                        },
                                        color:Colors.green[100],
                                        child: Text("Order Delivered",
                                          style: GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),
                                        ),
                                      ),
                                    ):Container(
                                      width: 320,
                                      child: RaisedButton(
                                        onPressed: (){
                                          statechange(documentSnapshot["Timestamp"]);
                                        },
                                        color:Colors.grey[100],
                                        child: Text("Order delivered",
                                          style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),
                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
          }
        )
          ],
          ),
        ),





        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          backgroundColor: Colors.grey[100],
          items: [
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "/home");
                  },
                  child: new Icon(Icons.home)),
              title: new Text('Home',
                style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold),),
            ),
            BottomNavigationBarItem(
              icon: InkWell(onTap: (){
                Navigator.pushNamed(context, "/Crop");
              },child: new Icon(Icons.favorite)),
              title: new Text('Wishlist',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
            ),
            BottomNavigationBarItem(
              icon: InkWell(onTap: (){
                Navigator.pushNamed(context, "/home_Weather");
              },child: new Icon(Icons.shopping_cart)),
              title: new Text('Cart',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
            ),
            BottomNavigationBarItem(
              icon: InkWell(onTap: (){
                Navigator.pushNamed(context, "/Dashboard");
              },child: new Icon(Icons.dashboard,color: Colors.red[900],)),
              title: new Text('Dashboard',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)),
            ),


          ],
        )
    );
  }
}
