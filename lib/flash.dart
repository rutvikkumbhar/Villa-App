import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_form/Home.dart';
import 'Login.dart';

class Flash extends StatefulWidget {
  const Flash({super.key});

  @override
  State<Flash> createState() => _FlashState();
}

class _FlashState extends State<Flash> {

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    Timer(const Duration(seconds: 2),() {
      if(user!=null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder){
          return Home();
        }));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return Login();
          },),);
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,width: 50,
              decoration: BoxDecoration(image: const DecorationImage(image: AssetImage("assets/images/app_logo.png"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(50)),
            ),
            Text("Villa",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 25,color: Colors.black.withValues(alpha:  0.6)),),),
          ],
        ),
      ),
    );
  }
}
