import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_form/About.dart';
import 'package:login_form/Add.dart';
import 'package:login_form/Favourite.dart';
import 'package:login_form/Help.dart';
import 'package:login_form/Meetings.dart';
import 'package:lottie/lottie.dart';
import 'Login.dart';
import 'ProfileEdit.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text("Profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xffE8DFCA),Color(0xffF5EFE6)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(5),),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: StreamBuilder(
                  stream: collectionReference.doc(_auth.currentUser!.uid).snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                    if(snapshot.hasData){
                      Map<String, dynamic> data=snapshot.data!.data() as Map<String, dynamic>;
                      return ListTile(
                        leading: Container(
                          height: 80,width: 56,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Color(0xff213555)),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: CircleAvatar(
                              backgroundImage: (data['pfpURL'].toString().isEmpty)?AssetImage("assets/images/ProfilePic.jpg"):NetworkImage(data['pfpURL'])),
                          ),
                        ),
                        title: Text(data['userName'],style: TextStyle(color: Colors.black,fontSize: 18),),
                        subtitle: Text(data['email'],style: TextStyle(color: Colors.black.withValues(alpha:  0.7),fontSize: 13),),
                      );
                    } else if(snapshot.hasError){
                      return Center(child: Text("Something went wrong"),);
                    } else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                )
              ),
            ),
            SizedBox(height: 26,),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(colors: [Color(0xffE8DFCA),Color(0xffF5EFE6)],begin: Alignment.topCenter,end: Alignment.bottomCenter),),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("My Account"),
                      subtitle: Text("Make changes to your account"),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff213555),),
                      leading: Icon(Boxicons.bx_user,color: Color(0xff213555),size: 20,),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(builder){
                          return ProfileEdit();
                        }));
                      },
                    ),
                    ListTile(
                      title: Text("Saved Property"),
                      subtitle: Text("Manage your saved property"),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff213555),),
                      leading: Icon(Icons.favorite_border_rounded,color: Color(0xff213555),size: 20,),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return Favourite();
                        }));
                      },
                    ),
                    ListTile(
                      leading: Icon(Boxicons.bx_calendar,color: Color(0xff213555),size: 20,),
                      title: Text("Your Schedule",),
                      subtitle: Text("See, where's your next property will be!"),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff213555),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return Meetings();
                        }));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.add,color: Color(0xff213555),size: 20,),
                      title: Text("Add Property"),
                      subtitle: Text("Start your own market",),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff213555),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return Add();
                        }));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout_outlined,color: Color(0xff213555),size: 20,),
                      title: Text("Log out"),
                      subtitle: Text("Your account will not be deleted!",),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff213555),),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context)
                            {
                              return AlertDialog(
                                title: const Text("Confirm Logout"),
                                content: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset("assets/Animations/Sad Animation.json", height: 100, width: 100, repeat: true, fit: BoxFit.fill),
                                    ],
                                  ),
                                ),
                                backgroundColor: const Color(0xffF5EFE6),
                                actions: [
                                  Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xff4F6F52)),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextButton(
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 7, right: 7),
                                        child: Text("Cancel", style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 45,
                                    decoration: BoxDecoration(color: const Color(0xff213555),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextButton(
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 7, right: 7),
                                        child: Text("Log Out", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),),
                                      ),
                                      onPressed: () {
                                        _auth.signOut();
                                        Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (context) => Login()),
                                              (Route<dynamic> route) => false,);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications_active_outlined,color: Color(0xff213555),size: 20,),
                      title: Text("Help & Support",),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff213555),),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return Help();
                        }));
                      },
                    ),
                    SizedBox(height: 15,),
                    ListTile(
                      leading: Icon(Icons.info_outline_rounded,color: Color(0xff213555),size: 20,),
                      title: Text("About App"),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff213555),),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder) {
                          return About();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Villa",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 25,color: Colors.black.withValues(alpha:  0.2)),),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
