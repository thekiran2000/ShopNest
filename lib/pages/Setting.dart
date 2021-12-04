import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

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

  void createRecord(var name,var add,var phone) async {
    final User user = FirebaseAuth.instance.currentUser;

    final snapShot = await FirebaseFirestore.instance.collection('Users').doc("${user.uid}").get();

    if(snapShot.exists){
      await databaseReference.collection("Users")
          .doc("${user.uid}")
          .update({
        "Name":name,
        "Address":add,
        "Phone":phone,

        "user_id":user.uid,


      });

    }
    else{
      await databaseReference.collection("Users")
          .doc("${user.uid}")
          .set({
        "Name":name,
        "Address":add,
        "Phone":phone,

        "user_id":user.uid,


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
            Icon(Icons.perm_identity,size: 35,)
          ],
        ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

            Container(
              height: 700,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Add personal details....',style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[400]),),
                  ),
                  SizedBox(height: 10,),
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
                          prefixIcon: Icon(Icons.perm_identity,color: Colors.black,),
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      decoration: BoxDecoration(

                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.0),

                      ),
                      child: TextField(
                        maxLines: 5,

                        controller: nameHolder2,


                        cursorColor: Colors.black,
                        decoration: InputDecoration(

                          prefixIcon: Icon(Icons.location_on,color: Colors.black,),
                          hintText: "Address",

                          hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
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
                          prefixIcon: Icon(Icons.phone,color: Colors.black,),
                          hintText: "Phone number",
                          hintStyle: TextStyle(color: Colors.black,fontSize: 17,),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    height: 50,
                    width: 200,
                    child: InkWell(
                      onTap: (){
                        createRecord(nameHolder1.text,nameHolder2.text,nameHolder3.text);
                        clearTextInput();
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.amberAccent[100],
                        shadowColor: Colors.red,
                        child: Center(child: Text('Submit',style: GoogleFonts.raleway(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),)),
                        elevation: 8,
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
  }
}
