import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class YourProperty extends StatefulWidget {

  const YourProperty({super.key});

  @override
  State<YourProperty> createState() => _YourPropertyState();
}

class _YourPropertyState extends State<YourProperty> {
  final FirebaseAuth _auth=FirebaseAuth.instance;

  CollectionReference ref=FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text("Your Properties"),
      ),
      body: StreamBuilder(
        stream: ref.doc(_auth.currentUser!.uid).collection('User Properties').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Color(0xff213555),),);
          } else if(snapshot.hasError){
            return Center(child: Text("Something went wrong"),);
          } else if(snapshot.hasData==false || snapshot.data!.docs.isEmpty){
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/Animations/EmptyCart.json",height: 200,width: 200,repeat: true),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Text("Looks empty! Add your first property to get started.",textAlign: TextAlign.center,
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
               return Padding(
                 padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                 child: Container(
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                       gradient: LinearGradient(colors: [Color(0xff3E5879).withValues(alpha:  0.7),Color(0xffF5EFE7)],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
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
                                 SizedBox(height: 10,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Container(
                                       height: 40,width: 100,
                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                           border: Border.all(color: Colors.grey)),
                                       child: IconButton(
                                         icon: Icon(Icons.edit_rounded,color: Color(0xff213555),),
                                         onPressed: (){
                                           // Navigator.push(context, MaterialPageRoute(builder: (builder){
                                           //   return EditProperty(docid: data.id,);
                                           // }));
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Available Soon")));
                                         },
                                       ),
                                     ),
                                     SizedBox(width: 10,),
                                   ],
                                 )
                               ],
                             )
                         ),
                       ],
                     ),
                   ),
                 ),
               );
             },
           );
          }
        }
      ),
    );
  }
}