import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'ProInfo.dart';

class AllProperty extends StatefulWidget {

  final String collectionName;
  const AllProperty({super.key, required this.collectionName});
  @override
  State<AllProperty> createState() => _AllPropertyState();
}

class _AllPropertyState extends State<AllProperty> {
  
  FirebaseAuth _auth=FirebaseAuth.instance;
  CollectionReference reference=FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text(widget.collectionName,style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(widget.collectionName.toString()).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Color(0xff213555),),);
          } else if(snapshot.hasError){
            return Center(child: Text("Something went wrong!"),);
          } else if(snapshot.hasData==false || snapshot.data!.docs.isEmpty){
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/Animations/OutOfStock.json",height: 200,width: 200,repeat: true),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Text("Oops! Nothing’s listed here right now.",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black.withValues(alpha:  0.5),fontSize: 17,fontWeight: FontWeight.w700),),
                ),
                SizedBox(height: 80,),
              ],
            ),);
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                DocumentSnapshot data=snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder) {
                        return ProInfo(collection: widget.collectionName,documentId: data.id,);
                      }));
                      CollectionReference recentVisit=reference.doc(_auth.currentUser!.uid).collection("Recent Visit");
                      recentVisit.doc("Recent Visited Product").set(data.data());
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(colors: [Color(0xffE8DFCA).withValues(alpha:  1),Color(0xffF5EFE7)],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 110,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(image: NetworkImage(data['propertyImageUrl']), fit: BoxFit.cover)),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['propertyName'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87),),
                                    Text("${data['propertyType']} | ${data['city']}, ${data['state']} ${data['zipCode']}", style: TextStyle(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.w500),),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}