import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:login_form/About.dart';
import 'package:login_form/Add.dart';
import 'package:login_form/AllProperty.dart';
import 'package:login_form/Categories.dart';
import 'package:login_form/Favourite.dart';
import 'package:login_form/Help.dart';
import 'package:login_form/Meetings.dart';
import 'package:login_form/Profile.dart';
import 'package:login_form/YourProperty.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'Login.dart';
import 'ProInfo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Properties');
  CollectionReference userData=FirebaseFirestore.instance.collection('Users');
  CollectionReference recentVisited=FirebaseFirestore.instance.collection("Users");
  bool isExist=false;
  late String recentCollectionName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        actions: [
          Container(
            decoration: BoxDecoration(color: Color(0xff3E5879).withValues(alpha:  0.1),borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              icon: Icon(Icons.home_work,color: Color(0xff213555),size: 20,),
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder){
                  return YourProperty();
                }));
            },),
          ),
          SizedBox(width: 10,),
          Container(
            decoration: BoxDecoration(color: Color(0xff3E5879).withValues(alpha:  0.1),borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              icon: Icon(Icons.calendar_month_rounded, color: Color(0xff213555),size: 20,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder){
                  return Meetings();
                }));
              },
            ),
          ),
        ],
        title: Text("Villa", style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 28,),),),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Color(0xffF5EFE7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 25,),
          Container(
            height: 140,width: double.infinity,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/profile_banner.png")),),
            child: StreamBuilder(
              stream: userData.doc(_auth.currentUser!.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData){
                  Map<String,dynamic> data=snapshot.data!.data() as Map<String,dynamic>;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 15,),
                      Container(
                        height: 55,width: 55,
                        decoration: BoxDecoration(image: DecorationImage(image: (data['pfpURL'].toString().isEmpty)?AssetImage("assets/images/ProfilePic.jpg"):NetworkImage(data['pfpURL']),fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['userName'], style: TextStyle(color: Colors.white, fontSize: 17)),
                          Text(data['email'],style: TextStyle(fontSize: 14, color: Colors.white),)
                        ],
                      )
                    ],
                  );
                } else if(snapshot.hasError){
                  return Text("Something went wrong");
                } else {
                  return Center(child: CircularProgressIndicator(color: Colors.white,),);
                }
              },
            )
          ),
          ListTile(
            title: const Text("Profile"),
            leading: const Icon(Boxicons.bx_user,color: Color(0xff213555),),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            },
          ),
          ListTile(
            title: const Text("Add Property"),
            leading: const Icon(Boxicons.bx_plus,color: Color(0xff213555),),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Add();
              }));
            },
          ),
          ListTile(
            title: const Text("Favourite"),
            leading: const Icon(Boxicons.bx_heart,color: Color(0xff213555),),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Favourite();
              }));
            },
          ),
          ListTile(
            title: const Text("Help"),
            leading: const Icon(Boxicons.bx_help_circle,color: Color(0xff213555),),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Help();
              }));
            },
          ),
          ListTile(
            title: const Text("About"),
            leading: const Icon(Boxicons.bx_info_circle,color: Color(0xff213555),),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return About();
              }));
            },
          ),
          ListTile(
            title: const Text("Log Out"),
            leading: const Icon(Boxicons.bx_log_out,color: Color(0xff213555),),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context)
              {
                return AlertDialog(
                  title: const Text("Confirm Logout"),
                  content: SizedBox(
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
            }
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Thank you for choosing Villa!",style: TextStyle(fontSize: 13),),
              Text("Developed by Rutvik",style: TextStyle(fontSize: 13),),
              Text("Version: 1.0.0",style: TextStyle(fontSize: 13),),
            ],
          ),
        ],
      )),

      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            SizedBox(
              height: 50,
              child: TextField(
                keyboardType: TextInputType.text,
                readOnly: false,
                decoration: InputDecoration(hintText: "Search",hintStyle: TextStyle(color: Colors.black.withValues(alpha:  0.5)),fillColor: const Color(0xffF8F5E9),filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Available Soon")));
                    },
                  ),
                ),),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder){
                      return Categories();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("See all",style: TextStyle(color: Colors.black.withValues(alpha:  0.5),fontSize: 15),),
                      Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Apartment Flat",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Apartment  Flat.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Apartment / Flat",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Villa Bungalow",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Villa  Bungalow.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Villa / Bungalow",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Townhouse",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Row House  Townhouse.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Townhouse",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Penthouse",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Penthouse.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Penthouse",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Studio Apartment",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Studio Apartment.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Studio Apartment",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Duplex Triplex",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Duplex  Triplex.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Duplex / Triplex",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ], 
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            StreamBuilder(
              stream: recentVisited.doc(_auth.currentUser!.uid).collection("Recent Visit").doc("Recent Visited Product").snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot){
                if(streamSnapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(color: Colors.white,),);
                } else if(streamSnapshot.hasError){
                  return Center(child: Text("Something went wrong"));
                } else if(!streamSnapshot.hasData || !streamSnapshot.data!.exists){
                  return Center(child: SizedBox(),);
                } else {
                  Map<String, dynamic> data=streamSnapshot.data!.data() as Map<String, dynamic>;
                  isExist=true;
                  recentCollectionName=data['propertyType'].toString();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recently visited", style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600),),
                      SizedBox(height: 8,),
                      Stack(
                        children: [
                          Container(
                            height: 160,width: double.infinity,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['propertyImageUrl']),fit: BoxFit.fitWidth),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                            height: 160,width: double.infinity,
                            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black,Colors.transparent],begin: Alignment.centerLeft,end: Alignment.centerRight),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['propertyName'],style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                                  SizedBox(height: 10,),
                                  Text("${data['propertyType']}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 2,),
                                  Text("${data['city']}, ${data['state']} ${data['zipCode']}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 160,
                            child:  GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (builder){
                                  return ProInfo(collection: data['propertyType'], documentId: data['propertyId']);
                                }));
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isExist?"Similar properties":"New properties",
                  style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder){
                      return AllProperty(collectionName: isExist?recentCollectionName:"Apartment");
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("See all",style: TextStyle(color: Colors.black.withValues(alpha:  0.5),fontSize: 15),),
                      Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 170,width: double.infinity,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection(isExist?recentCollectionName.toString():"Apartment").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  } else if(snapshot.hasError){
                    return Center(child: Text("Something went wrong"),);
                  } else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                    return Center(child: Text("No data yet"),);
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (itemBuilder, index){
                        DocumentSnapshot data=snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (builder){
                                return ProInfo(documentId: data.id, collection: data['propertyType'],);
                              }));
                            },
                            child: SizedBox(
                              height: 130,width: 130,
                              child: Column(
                                children: [
                                  Container(
                                    height: 120,width: 120,
                                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['propertyImageUrl']),fit: BoxFit.cover),borderRadius: BorderRadius.circular(5)),
                                  ),
                                  SizedBox(height: 5,),
                                  Expanded(
                                    child:  Text(data['propertyName'],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 5,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha:  0.1),
            ),
            SizedBox(height: 30,),
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
