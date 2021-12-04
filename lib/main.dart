
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shopnest/pages/Cart.dart';
import 'package:shopnest/pages/Dashboard.dart';
import 'package:shopnest/pages/Flash.dart';
import 'package:shopnest/pages/Setting.dart';
import 'package:shopnest/pages/auth_service.dart';
import 'package:shopnest/pages/edit.dart';
import 'package:shopnest/pages/home.dart';
import 'package:shopnest/pages/login.dart';
import 'package:shopnest/pages/myorder.dart';
import 'package:shopnest/pages/popular.dart';
import 'package:shopnest/pages/product_info.dart';
import 'package:shopnest/pages/productview.dart';
import 'package:shopnest/pages/profile.dart';
import 'package:shopnest/pages/register.dart';
import 'package:shopnest/pages/voucher.dart';
import 'package:shopnest/pages/wish.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider<Auth_serve>(
        create: (_)=>Auth_serve(FirebaseAuth.instance),
      ),
      StreamProvider(create: (context)=> context.read<Auth_serve>().authStateChanges)
    ],
    child: MaterialApp(
      initialRoute: '/aoth',
      routes: {
        "/home":(context)=>Home(),
        "/Dashboard":(context)=>Dashboard(),
        "/login": (context)=>Login(),
        "/signup": (context)=>Signup(),
        "/aoth": (context)=>Aoth(),
        "/productview": (context)=>Products(),
        "/productinfo": (context)=>ProductInfo(),
        "/settings": (context)=>Settings(),
        "/cart": (context)=>Cart(),
        "/wish": (context)=>Wish(),
        "/myorder": (context)=>Myorder(),
        "/popular": (context)=>Popular(),
        "/voucher": (context)=>Voucher(),
        "/flash": (context)=>Flash(),
        "/edit": (context)=>Edit(),
//        "/profile": (context)=>Profile(),



      },
    ),
  ));
}

class Aoth extends StatelessWidget {

  const Aoth({
    Key key,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if(firebaseUser != null){
      return Home();
    }

    else{
      return Login();
    }
  }
}
