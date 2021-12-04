import 'dart:convert';
//import 'package:agriease/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/pages/login.dart';



class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}


class _SignupState extends State<Signup> {
  final _formkey=GlobalKey<FormState>();
  var Email,Password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,


      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [

              Colors.limeAccent[200],

              Colors.teal[300],

            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50,),
//            Container(
//                child: Image.asset("lib/asset/login.png",width: 220,)
//            ),
            Text("Improving",style: GoogleFonts.courgette(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[900]),),
            Text("Agriculture for lives",style: GoogleFonts.courgette(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green[900]),),
            SizedBox(height: 45,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                InkWell(onTap:(){
                  Navigator.pushReplacement(context, SlideRightRoute(page: Login()));
                },child: Container(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sign In",style: GoogleFonts.zillaSlab(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[900]),),
                ))),

                Text("Sign Up",style: GoogleFonts.zillaSlab(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.green[900]
                ),),
              ],
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35.0,35,35,15),
                    child: TextFormField(
                      decoration: InputDecoration(icon:Icon(Icons.mail,color: Colors.white60,),labelText: "Enter Your Email",labelStyle: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[900])),
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[900]),
                      validator: (value){
                        if(value.isEmpty || !value.contains('@')){
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      onSaved: (value){
                        Email=value;
                      },
                    ),
                  )
                  ,Padding(
                    padding: const EdgeInsets.fromLTRB(35.0,15,35,15),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(icon:Icon(Icons.lock,color: Colors.white60,),labelText: "Enter Your Password",labelStyle: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[900])),
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[900]),
                      validator: (value){
                        if(value.isEmpty || value.length <= 5 ){
                          return 'Password must be greater than 5 chars';
                        }
                        return null;
                      },
                      onSaved: (value){
                        Password=value;
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: 320,
                    child: RaisedButton(
                      onPressed: signup,
                      color:Colors.green[100],
                      child: Text("SIGN UP",
                        style: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),
                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),

    );
  }
  Future<void> signup() async{
    final formState=_formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: Password);

        Navigator.pushReplacement(context, SlideRightRoute(page: Login()));
        //TODO : Navigate to home
      }catch(e){
        print(e.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(child: Text("ERROR OCCURED!!!",style: GoogleFonts.zillaSlab(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.red[400]),)),
                content: Text(e.message,style: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold),),
                actions: [
                  FlatButton(
                    child: Text("Ok",style: GoogleFonts.zillaSlab(fontSize: 22,fontWeight: FontWeight.bold),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }
}
