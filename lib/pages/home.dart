import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  var finale;
  List <Widget> kia;

  Future <List<Map<dynamic, dynamic>>> getCollection() async{
    List<DocumentSnapshot> templist;
    List<Map<dynamic, dynamic>> list = new List();
    CollectionReference collectionRef = FirebaseFirestore.instance.collection("All");
    QuerySnapshot collectionSnapshot = await collectionRef.get();

    templist = collectionSnapshot.docs; // <--- ERROR

    list = templist.map((DocumentSnapshot docSnapshot){
      return docSnapshot.data;
    }).cast<Map>().toList();

    print(list);
    return list;
  }



//  void ohyesabhi(var query)async{
//    List<DocumentSnapshot> documentList = (await FirebaseFirestore.instance
//        .collection("All")
//        .where("Product", isGreaterThanOrEqualTo: query.toString())
//        .get())
//        .docs;
//
//    finale=documentList;
//
//    print(finale[21].data()["Brand"]);
//    print(finale.length);
//  }

//  void queryValues() async{
////        await FirebaseFirestore.instance
////        .collection("All")
////        .snapshots()
////        .listen((snapshot) {
////
////          snapshot.docs.forEach((doc) =>
////
////          );
////    });
//
//    CollectionReference _documentRef=await FirebaseFirestore.instance.collection("All");
//
//    _documentRef.get().then((ds){
//      if(ds!=null){
//        ds.docs.forEach((value){
//
//          print(value.data()["Brand"]);
//          if(value.data()["Brand"].toString()=='Skybags'){
//
//            kia[i];
//          }
//
//
////            print(value.data());
//
//
//
//        });
//      }
//    });
//
//
//  }

  final nameHolder1 = TextEditingController();

  final User user = FirebaseAuth.instance.currentUser;
//  final snapShot = await FirebaseFirestore.instance.collection('${user.email}').doc("$spendtype").get();
  var dash=false;
  void func() async{

    final snapShot = await FirebaseFirestore.instance.collection('Buisness_User').doc("${user.uid}").get();
    if (snapShot.exists){
        setState(() {
          dash=true;
        });

    }
    else{
      setState(() {
        dash=false;
      });

    }
  }

  bool isyes=false;
  var query="";
  final databaseReference = FirebaseFirestore.instance;




//  Widget thisis() {
//      return StreamBuilder(
//          stream: FirebaseFirestore.instance.collection("All").where(
//              "Product", isGreaterThanOrEqualTo: nameHolder1.text).snapshots(),
//
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              return ListView.builder(
//                  physics: BouncingScrollPhysics(),
//
//                  shrinkWrap: true,
//                  itemCount: snapshot.data.documents.length,
//                  itemBuilder: (context, index) {
//                    DocumentSnapshot documentSnapshot12 = snapshot.data.documents[index];
//
//                    return Text(documentSnapshot12["Product"]);
//                  }
//              );
//            }
//          }
//      );
//    }



  void searchthis(){

    setState(() {
      isyes=true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func();
  }


  void cat_name(var str){
    Navigator.pushNamed(context, "/productview",arguments: {
      "Category":str,
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':signOut();
      break;
      case 'Settings':Navigator.pushNamed(context, "/settings");
      break;
//      case 'Theme':changetheme();
//      break;
      case 'Profile':
        showModalBottomSheet<void>(

          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 400,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Users").doc("${user.uid}").snapshots(),

                builder: (context,snapshot){
                  if(snapshot.hasData){
                    DocumentSnapshot documentSnapshot=snapshot.data;
                    return Column(
                      children: [
                        Center(child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Personal Information",style: GoogleFonts.raleway(color: Colors.redAccent[700],fontSize: 20,fontWeight: FontWeight.bold),),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.pink[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,

                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Center(child: Text(documentSnapshot["Name"],style: GoogleFonts.raleway(fontSize: 19,fontWeight: FontWeight.bold),)),
                                  )
                              ),
                            ),
                          ),
                        ),Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                              color: Colors.cyan[500],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Center(child: Text(documentSnapshot["Phone"],style: GoogleFonts.lato(fontSize: 19,fontWeight: FontWeight.bold),)),
                                  )
                              ),
                            ),
                          ),
                        ),Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                              color: Colors.amber[500],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Center(child: Text(documentSnapshot["Address"],style: GoogleFonts.raleway(fontSize: 19,fontWeight: FontWeight.bold),)),
                                  )
                              ),
                            ),
                          ),
                        ),

                      ],
                    );

                  }
                },
              ),
            );
          },
        );

      break;
    }
  }
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,

            colors: [
              Colors.green[100],
              Colors.greenAccent,
              Colors.lightGreenAccent,
              Colors.lightGreen,
              Colors.green[300],
            ],
          ),
        ),
        child: new AlertDialog(
          title: new Text('Are you sure?',style: GoogleFonts.zillaSlab(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.green[900]),),
          content: new Text('Do you want to exit an App',style: GoogleFonts.zillaSlab(fontSize: 20,color: Colors.green[900]),),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO",style: GoogleFonts.zillaSlab(fontSize: 20,color: Colors.green[900]),),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES",style: GoogleFonts.zillaSlab(fontSize: 20,color: Colors.green[900]),),
              ),
            ),
          ],
        ),
      ),
    ) ??
        false;
  }





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: Container(
//        color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white, //This will change the drawer background to blue.
                //other styles
              ),
              child: Drawer(

                elevation: 20,



                child: Column(
                  children: [
                      Image.asset("assets/logo.jpeg",height: 250,width:double.infinity),
                      Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.pink[500], Colors.amber[100]]
                            )
                        ),


                        child: FlatButton(onPressed: (){

                          Navigator.pushNamed(context, "/myorder");
                        },

//                        color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Myorders",style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold),),
                          ),


                        ),
                      ),
                    SizedBox(height: 10,),
                        Container(
                        width: double.infinity,
                        height: 45,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.bottomLeft,
                                  colors: [Colors.pink[500], Colors.amber[100]]
                              )
                          ),

                          child: FlatButton(onPressed: (){

                          Navigator.pushNamed(context, "/wish");
                         },




                          child: Text("MyWishlist",style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold),),


                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.pink[500], Colors.amber[100]]
                            )
                        ),

                        child: FlatButton(onPressed: (){

                          Navigator.pushNamed(context, "/cart");
                        },
//                        elevation: 4,
//                        color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("MyCart",style: GoogleFonts.raleway(fontSize: 18,fontWeight: FontWeight.bold),),
                          ),


                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
//            Icon(Icons.perm_identity,size: 35,)
            ],
          ),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings','Profile'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],

        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,3,8,2),
                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0),

                  ),

                  child: TextField(


                    controller: nameHolder1,
                    decoration: InputDecoration(

                      prefixIcon: InkWell(
                        onTap: (){
//                           var ii;
//                           getCollection();
//                           print(ii[0].data()["Brand"]);
                        },
                      child: Icon(Icons.search,color: Colors.black,)),
                      hintText: "What would you like to buy?",
                      hintStyle: TextStyle(color: Colors.black,fontSize: 17),
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius. circular(15.0),
                      ),

                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 170.0,
                    width:380,
                    child: Carousel(
                      images: [

                        NetworkImage("https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/Samsung/SamsungM/M12/LP/Launch/PC/M12_LP_PC_51.jpg"),
                        NetworkImage("https://images-eu.ssl-images-amazon.com/images/G/31/img18/Audio/JBL/valentines/1099164_JBLvalentines_1340x777_1.jpg"),
                        NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoYwrT_y2SuBoilATblnsvQ_DNDKf_ORP8rg&usqp=CAU"),
                        NetworkImage("https://i.gadgets360cdn.com/large/jio_hotstar_offer_1591500059056.jpg"),
                        NetworkImage("https://image.freepik.com/free-vector/special-offer-modern-sale-banner-template_1017-20667.jpg"),
                        NetworkImage("https://cdn.grabon.in/gograbon/images/web-images/uploads/1602057770316/dussehra-offers.jpg"),
                        NetworkImage("https://assorted.downloads.oppo.com/static/archives/images/in/diwali-offer/offers-mobile.png"),
//                        NetworkImage("https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/Samsung/SamsungM/M12/LP/Launch/PC/M12_LP_PC_51.jpg"),


                      ],
                      dotSize: 5.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.lightGreenAccent,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.purple.withOpacity(0),
                      borderRadius: true,
                      animationDuration: Duration(seconds: 1),
                    )
                ),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 70,
                        width: 100,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "/popular");
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),

                            child: Icon(Icons.account_balance,size: 29,color: Colors.pink,),
                          ),
                        ),
                      ),
                      Text("Popular")
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 70,
                        width: 100,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "/flash");
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),

                            child: Icon(Icons.alarm,size: 29,color: Colors.amber,),
                          ),
                        ),
                      ),
                      Text("Flash sell")
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 70,
                        width: 100,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "/voucher");
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),

                            child: Icon(Icons.card_giftcard,size: 29,color: Colors.cyan,),
                          ),
                        ),
                      ),
                      Text("Voucher")
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.grey[100],
                  elevation: 10,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text("Categories",style: TextStyle(color: Colors.blueGrey[600],fontSize: 18,fontWeight: FontWeight.bold),),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Fashion");
                        },
                        child: Card(
                          child: Column(
                          children: [

                            CachedNetworkImage(
                              imageUrl:"https://media.vanityfair.com/photos/55ef2bb0fad0d98d444cdb61/master/w_1600%2Cc_limit/fashion-illustrators-meagan-morrison-chiara-ferragni.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Fashion",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ), Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Mobile");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://www.mobilityindia.com/wp-content/uploads/2021/01/LAVA-Z6.jpg",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://www.mobilityindia.com/wp-content/uploads/2021/01/LAVA-Z6.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Mobile",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ), Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Electronics");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://i.pinimg.com/originals/41/03/e4/4103e408acd9ab178616f6954d8fe769.jpg",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://i.pinimg.com/originals/41/03/e4/4103e408acd9ab178616f6954d8fe769.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Electronics",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ),
                  ],
                ),
              ),Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Home");
                        },

                        child: Card(child: Column(
                          children: [
//                          Image.network("https://i2-prod.gloucestershirelive.co.uk/incoming/article2388909.ece/ALTERNATES/s1200b/1_Poundland-Promotion.jpg",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://i2-prod.gloucestershirelive.co.uk/incoming/article2388909.ece/ALTERNATES/s1200b/1_Poundland-Promotion.jpg",
                              height: 124,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Home",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ), Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Appliances");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjtehuUYSiCwNsS78GX9mlnLSNigH_mej_Zw&usqp=CAU",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjtehuUYSiCwNsS78GX9mlnLSNigH_mej_Zw&usqp=CAU",
                              height: 124,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Appliances",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ), Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Beauty");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://www.creativenaturesuperfoods.co.uk/wp-content/uploads/2019/01/Cosmetic.jpg",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://www.creativenaturesuperfoods.co.uk/wp-content/uploads/2019/01/Cosmetic.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Beauty",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ),
                  ],
                ),
              ),Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Toys & baby");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://i.ebayimg.com/thumbs/images/g/u9wAAOSwvhte8t2w/s-l300.jpg",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://i.ebayimg.com/thumbs/images/g/u9wAAOSwvhte8t2w/s-l300.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Toys & baby",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ), Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Sports");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://media.istockphoto.com/vectors/set-of-sports-equipment-vector-id543180996?k=6&m=543180996&s=612x612&w=0&h=_rt5-aSraJl4hkZVpKJOg2SPMnMrgEbgWAKyRkoXqyE=",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://media.istockphoto.com/vectors/set-of-sports-equipment-vector-id543180996?k=6&m=543180996&s=612x612&w=0&h=_rt5-aSraJl4hkZVpKJOg2SPMnMrgEbgWAKyRkoXqyE=",
                              height: 124,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Sports",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ), Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Furniture");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://images-na.ssl-images-amazon.com/images/I/61MAzfI%2B4vL._SX425_.jpg",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://images-na.ssl-images-amazon.com/images/I/61MAzfI%2B4vL._SX425_.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Furniture",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ),
                  ],
                ),
              ),Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Food & more");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://4.imimg.com/data4/YD/CB/MY-3845829/center-seal-pouch-500x500.jpg",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://4.imimg.com/data4/YD/CB/MY-3845829/center-seal-pouch-500x500.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Food & more",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ), Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Stationary");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("https://www.fermoylens.ie/wp-content/uploads/2019/07/stationary-2.jpg",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://www.fermoylens.ie/wp-content/uploads/2019/07/stationary-2.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Stationary",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ), Container(
                      height: 170,
                      width: 118,
                      child: InkWell(
                        onTap: (){
                          cat_name("Artifacts");
                        },
                        child: Card(child: Column(
                          children: [
//                          Image.network("",height: 124,),
                            CachedNetworkImage(
                              imageUrl:"https://heritagehandicraft.com/wp-content/uploads/2019/06/craft-map.jpg",
                              height: 124,

                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Artifacts",style: GoogleFonts.redressed(fontSize: 23),),
                            ),
                          ],
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Categories").doc("Fashion").collection("Products").snapshots(),

                  builder: (context,snapshot){
                  if(snapshot.hasData) {

                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];

                    return  Column(
                      children: [
                        Container(


                          child: Card(
                            color: Colors.pink[800],


                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Fashion",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap:(){
                            cat_name(documentSnapshot["Category"]);
                          },
                          child: Card(
                            elevation:2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
                              child: Row(
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
                                            CachedNetworkImage(
                                              imageUrl:documentSnapshot["Image"],
                                              height: 330,
                                              width: 170,

                                              placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                            Column(
                                              children: [
                                                if(documentSnapshot["Product"].toString().length>15) Text("${documentSnapshot["Product"].toString().substring(0,15)}...",style:GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold)),
                                                if(documentSnapshot["Product"].toString().length<=15) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold)),
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Column(
                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
                                                  CachedNetworkImage(
                                                    imageUrl:documentSnapshot1["Image"],
                                                    height: 150,
                                                    width: 140,

                                                    placeholder: (context, url) => CircularProgressIndicator(),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),
                                                  Column(
                                                    children: [
                                                      if(documentSnapshot1["Product"].toString().length>12) Text("${documentSnapshot1["Product"].toString().substring(0,12)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                      if(documentSnapshot1["Product"].toString().length<=12) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
                                                  CachedNetworkImage(
                                                    imageUrl:documentSnapshot2["Image"],
                                                    height: 150,
                                                    width: 140,

                                                    placeholder: (context, url) => CircularProgressIndicator(),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),


                                                  Column(
                                                    children: [
                                                      if(documentSnapshot2["Product"].toString().length>12) Text("${documentSnapshot2["Product"].toString().substring(0,12)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                      if(documentSnapshot2["Product"].toString().length<=12) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),









                                        ],
                                      ),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );


                  }
                  if (!snapshot.hasData){
                    print('test phrase');
                    return Text("");
                  }
                  }
              ),StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Categories").doc("Mobile").collection("Products").snapshots(),

                  builder: (context,snapshot){
                  if(snapshot.hasData) {

                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];

                    return  Column(
                      children: [
                        Container(


                          child: Card(
                            color: Colors.pink[800],


                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Mobile",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap:(){
                            cat_name(documentSnapshot["Category"]);
                          },
                          child: Card(
                            elevation:2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
                              child: Row(
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
                                            CachedNetworkImage(
                                              imageUrl:documentSnapshot["Image"],
                                              height: 330,
                                              width: 170,

                                              placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                            Column(
                                              children: [
                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Column(
                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
                                                  CachedNetworkImage(
                                                    imageUrl:documentSnapshot1["Image"],
                                                    height: 150,
                                                    width: 140,

                                                    placeholder: (context, url) => CircularProgressIndicator(),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),

                                                  Column(
                                                    children: [
                                                      if(documentSnapshot1["Product"].toString().length>12) Text("${documentSnapshot1["Product"].toString().substring(0,12)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                      if(documentSnapshot1["Product"].toString().length<=12) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
                                                  CachedNetworkImage(
                                                    imageUrl:documentSnapshot2["Image"],
                                                    height: 150,
                                                    width: 140,

                                                    placeholder: (context, url) => CircularProgressIndicator(),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),
                                                  Column(
                                                    children: [
                                                      if(documentSnapshot2["Product"].toString().length>12) Text("${documentSnapshot2["Product"].toString().substring(0,12)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                      if(documentSnapshot2["Product"].toString().length<=12) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),









                                        ],
                                      ),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );


                  }
                  if (!snapshot.hasData){
                    print('test phrase');
                    return Text("");
                  }
                  }
              ),StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Categories").doc("Electronics").collection("Products").snapshots(),

                  builder: (context,snapshot){
                  if(snapshot.hasData) {

                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];

                    return  Column(
                      children: [
                        Container(


                          child: Card(
                            color: Colors.pink[800],


                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Electronics",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap:(){
                            cat_name(documentSnapshot["Category"]);
                          },
                          child: Card(
                            elevation:2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
                              child: Row(
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
                                            CachedNetworkImage(
                                              imageUrl:documentSnapshot["Image"],
                                              height: 330,
                                              width: 170,

                                              placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                            Column(
                                              children: [
                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Column(
                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
                                                  CachedNetworkImage(
                                                    imageUrl:documentSnapshot1["Image"],
                                                    height: 150,
                                                    width: 140,

                                                    placeholder: (context, url) => CircularProgressIndicator(),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),
                                                  Column(
                                                    children: [
                                                      if(documentSnapshot1["Product"].toString().length>12) Text("${documentSnapshot1["Product"].toString().substring(0,12)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                      if(documentSnapshot1["Product"].toString().length<=12) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
                                                  CachedNetworkImage(
                                                    imageUrl:documentSnapshot2["Image"],
                                                    height: 150,
                                                    width: 140,

                                                    placeholder: (context, url) => CircularProgressIndicator(),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),
                                                  Column(
                                                    children: [
                                                      if(documentSnapshot2["Product"].toString().length>12) Text("${documentSnapshot2["Product"].toString().substring(0,12)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                      if(documentSnapshot2["Product"].toString().length<=12) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),









                                        ],
                                      ),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );


                  }
                  if (!snapshot.hasData){
                    print('test phrase');
                    return Text("");
                  }
                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Home").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Home",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Appliances").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Appliances",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Beauty").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Beauty",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Toys & baby").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Toys & baby",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Sports").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Sports",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Furniture").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Furniture",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Food & more").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Food & more",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Stationary").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Stationary",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),StreamBuilder(
//                  stream: FirebaseFirestore.instance.collection("Categories").doc("Artifacts").collection("Products").snapshots(),
//
//                  builder: (context,snapshot){
//                  if(snapshot.hasData) {
//
//                    DocumentSnapshot documentSnapshot=snapshot.data.documents[0];
//                    DocumentSnapshot documentSnapshot1=snapshot.data.documents[1];
//                    DocumentSnapshot documentSnapshot2=snapshot.data.documents[2];
//
//                    return  Column(
//                      children: [
//                        Container(
//
//
//                          child: Card(
//                            color: Colors.pink[800],
//
//
//                            child: Center(child: Padding(
//                              padding: const EdgeInsets.all(15.0),
//                              child: Text("Artifacts",style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
//                            )),
//                          ),
//                        ),
//                        InkWell(
//                          onTap:(){
//                            cat_name(documentSnapshot["Category"]);
//                          },
//                          child: Card(
//                            elevation:2,
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(8,2,2,2),
//                              child: Row(
//                                children: [
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Card(
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(4.0),
//                                        child: Column(
//                                          children: [
//                                            Image.network(documentSnapshot["Image"],height: 330,width: 170,),
//                                            Column(
//                                              children: [
//                                                if(documentSnapshot["Product"].toString().length>20) Text("${documentSnapshot["Product"].toString().substring(0,19)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                if(documentSnapshot["Product"].toString().length<=20) Text(documentSnapshot["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                              ],
//                                            )
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Column(
//                                        children: [
//                                          Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(3.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot1["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot1["Product"].toString().length>17) Text("${documentSnapshot1["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot1["Product"].toString().length<=17) Text(documentSnapshot1["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),Card(
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(8.0),
//                                              child: Column(
//                                                children: [
//                                                  Image.network(documentSnapshot2["Image"],height: 150,width: 140,),
//                                                  Column(
//                                                    children: [
//                                                      if(documentSnapshot2["Product"].toString().length>17) Text("${documentSnapshot2["Product"].toString().substring(0,17)}...",style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                      if(documentSnapshot2["Product"].toString().length<=17) Text(documentSnapshot2["Product"],style:GoogleFonts.raleway(fontSize: 17,fontWeight: FontWeight.bold)),
//                                                    ],
//                                                  )
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//
//
//
//
//
//
//
//
//
//                                        ],
//                                      ),
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//
//                  }
//                  if (!snapshot.hasData){
//                    print('test phrase');
//                    return Text("");
//                  }
//                  }
//              ),
              )
            ],
          ),
        ),
          bottomNavigationBar: dash  ?  BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            backgroundColor: Colors.grey[100],
            items: [
              BottomNavigationBarItem(
                icon: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/");
                    },
                    child: new Icon(Icons.home,color: Colors.red[900],)),
                title: new Text('Home',
                  style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
              ),
              BottomNavigationBarItem(
                icon: InkWell(onTap: (){
                  Navigator.pushNamed(context, "/wish");
                },child: new Icon(Icons.favorite)),
                title: new Text('Wishlist',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
              ),
              BottomNavigationBarItem(
                icon: InkWell(onTap: (){
                  Navigator.pushNamed(context, "/cart");
                },child: new Icon(Icons.shopping_cart)),
                title: new Text('Cart',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
              ),

              BottomNavigationBarItem(
                icon: InkWell(onTap: (){
                  Navigator.pushNamed(context, "/Dashboard");
                },child: new Icon(Icons.dashboard)),
                title: new Text('Dashboard',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
              ),


            ],
          ):BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            backgroundColor: Colors.grey[100],
            items: [
              BottomNavigationBarItem(
                icon: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/");
                    },
                    child: new Icon(Icons.home,color: Colors.red[900],)),
                title: new Text('Home',
                  style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
              ),
              BottomNavigationBarItem(
                icon: InkWell(onTap: (){
                  Navigator.pushNamed(context, "/wish");
                },child: new Icon(Icons.favorite)),
                title: new Text('Wishlist',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
              ),
              BottomNavigationBarItem(
                icon: InkWell(onTap: (){
                  Navigator.pushNamed(context, "/cart");
                },child: new Icon(Icons.shopping_cart)),
                title: new Text('Cart',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
              ),

//            BottomNavigationBarItem(
//              icon: InkWell(onTap: (){
//                Navigator.pushNamed(context, "/Dashboard");
//              },child: new Icon(Icons.dashboard)),
//              title: new Text('Dashboard',style: GoogleFonts.zillaSlab(fontSize: 15,fontWeight: FontWeight.bold)),
//            ),


            ],
          )
      ),
    );

  }
  Future signOut() async{
    try{
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, "/login");
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}
