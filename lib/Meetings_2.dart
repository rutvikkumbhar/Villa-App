import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Meetings_2 extends StatefulWidget {
  const Meetings_2({super.key});

  @override
  State<Meetings_2> createState() => _Meetings_2State();
}

class _Meetings_2State extends State<Meetings_2> {
  
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('SCHEDULES');
  final FirebaseAuth _auth=FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text("Requested"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 15),
        child: StreamBuilder(
          stream: collectionReference.where('buyerId', isEqualTo: _auth.currentUser!.uid).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: Color(0xff213555),),);
            } else if(snapshot.hasError) {
              return Center(child: Text("Something went wrong!"),);
            } else if(snapshot.hasData==false || snapshot.data!.docs.isEmpty){
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/Animations/EmptyCart.json",height: 200,width: 200,repeat: true),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Text("No meetings yet... commitment issues?",textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black.withValues(alpha:  0.5),fontSize: 17,fontWeight: FontWeight.w700),),
                  ),
                  SizedBox(height: 80,),
                ],
              ),);
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (itemBuilder, index){
                  DocumentSnapshot data=snapshot.data!.docs[index];
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Color(0xffD8C4B6).withValues(alpha:  0.4),borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,width: 130,
                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['propertyImageUrl']),fit: BoxFit.cover),borderRadius: BorderRadius.circular(5)),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(data['propertyName'],
                                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black.withValues(alpha:  0.9)),),
                                    SizedBox(height: 3,),
                                    Text(data['propertyType'],
                                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black.withValues(alpha:  0.7)),),
                                    SizedBox(height: 3,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.calendar_month_rounded,size: 18,color: Color(0xff213555),),
                                        SizedBox(width: 5,),
                                        Text("${data['scheduleDate']} | ${data['scheduleTime']}",
                                          style:TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w400),)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Buyer: ${data['buyerName']}",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black.withValues(alpha:  0.8)),),
                              data['status']=="ACCEPTED"?Text("📞 +91 ${data['buyerNumber']}",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black.withValues(alpha:  0.8)),):const SizedBox(),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("Location: ${data['address']}",
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black.withValues( alpha: 0.8)),),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: data['status']=="ACCEPTED"?Color(0xff4CAF50)
                                          :data['status']=="REJECTED"?Color(0xffF44336) :Colors.orange,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30,right: 30,top: 10),
                                    child: Text( data['status']=="ACCEPTED"?"Accepted"
                                        :data['status']=="REJECTED"?"Rejected" :"Pending",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500),),
                                  ),
                                ),
                              ]
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}