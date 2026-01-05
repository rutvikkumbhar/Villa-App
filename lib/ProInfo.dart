import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_form/Schedule.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Error.dart';
class ProInfo extends StatefulWidget {

  final String documentId;
  final String collection;
  const ProInfo({super.key, required this.collection,required this.documentId});
  @override
  State<ProInfo> createState() => _ProInfoState();
}

class _ProInfoState extends State<ProInfo> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  VideoPlayerController? _videoController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  bool loading=false;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
  Future<void> openMap(String locationUrl) async {
    final Uri uri = Uri.parse(locationUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $locationUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Color(0xffF5EFE7),
       title: Text("Property information"),
     ),
     backgroundColor: Color(0xffF5EFE7),
     body: Padding(
       padding: const EdgeInsets.only(left: 10,right: 10),
       child: StreamBuilder(
         stream: FirebaseFirestore.instance.collection(widget.collection).doc(widget.documentId).snapshots(),
         builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
           if(snapshot.connectionState==ConnectionState.waiting){
             return Center(child: CircularProgressIndicator(color: Color(0xff213555),),);
           } else if(snapshot.hasError) {
             return Center(child: Text("Something went wrong!"),);
           } else {
             Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
             if (_videoController == null && data['propertyVideoUrl'] != null) {
               _videoController = VideoPlayerController.networkUrl(Uri.parse(data['propertyVideoUrl']));
               _initializeVideoPlayerFuture = _videoController!.initialize().then((_) {
                 setState(() {});
               });
             }
             return ListView(
               children: [
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0,0,0,10),
                   child: Container(
                     height: 200,
                     child: ListView(
                       scrollDirection: Axis.horizontal,
                       children: [
                         Container(
                           height:200,
                           width: 350,
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                               image: DecorationImage(image: NetworkImage(data['propertyImageUrl']),fit: BoxFit.cover)),
                         ),
                         SizedBox(width: 10,),
                         Container(
                             height: 200,
                             width: 350,
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                             child: _videoController != null ? FutureBuilder(
                               future: _initializeVideoPlayerFuture,
                               builder: (context, snapshot) {
                                 if (snapshot.connectionState == ConnectionState.done) {
                                   return GestureDetector(
                                     onTap: () {
                                       setState(() {
                                         if (_videoController!.value.isPlaying) {
                                           _videoController!.pause();
                                           _isPlaying = false;
                                         } else {
                                           _videoController!.play();
                                           _isPlaying = true;
                                         }
                                       });
                                     },
                                     child: Stack(
                                         children:[ AspectRatio(
                                           aspectRatio: _videoController!.value.aspectRatio,
                                           child: VideoPlayer(_videoController!),
                                         ),
                                           Center(
                                             child: Icon(
                                               _isPlaying ? Icons.pause : Icons.play_arrow,
                                               color: Colors.white,
                                               size: 40,
                                             ),
                                           ),
                                         ]
                                     ),
                                   );
                                 } else {
                                   return Center(child: CircularProgressIndicator());
                                 }
                               },
                             )
                                 : Center(child: Text("No Video Available"))),
                       ],
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                   child: Text("₹ ${data['sellingPrice']}/-",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black87),),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 5, 0,5),
                   child: Text("${data['propertyType']} for Sale in",style: TextStyle(fontSize: 17,color: Colors.black54,fontWeight: FontWeight.w500),),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 0, 0,0),
                   child: Text("${data['propertyName']}",style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w600)),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 5, 0,20),
                   child: Text("${data['city']}, ${data['state']} ${data['zipCode']}",style: TextStyle(fontSize: 17,color: Colors.black54,fontWeight: FontWeight.w500)),
                 ),
                 Container(
                   height: 1,
                   color: Colors.black.withValues(alpha:  0.1),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       Container(
                         height: 50,
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xff213555)),
                         child: TextButton(
                           child: const Text("Schedule",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600)),
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (builder){
                               return Schedule(collection: widget.collection,documentId: snapshot.data!.id,);
                             }));
                           },
                         ),
                       ),
                       Container(
                         height: 50,
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,border: Border.all(color: Colors.black87.withValues(alpha:  0.9))),
                         child: TextButton(
                           child: loading?CircularProgressIndicator(color: Color(0xff213555),) :Text("Favourites",style: TextStyle(color: Colors.black87,fontSize: 17,fontWeight: FontWeight.w600)),
                           onPressed: ()async{
                             setState(() {
                               loading=true;
                             });
                             CollectionReference ref=FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).collection('Favourites');
                             await ref.doc(snapshot.data!.id).set(data).then((onValue){
                               setState(() {
                                 loading=false;
                               });
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to favourites")));
                             }).onError((error,stackTrace){
                               setState(() {
                                 loading=false;
                               });
                               Error().toastMessage(error.toString());
                             });
                           },
                         ),
                       ),
                     ],
                   ),
                 ),
                 Container(
                   height: 1,
                   color: Colors.black.withValues(alpha:  0.1),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                           child: Text("Address",style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w500)),
                         ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                           child: Text("${data['address']}",style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500)),
                         ),
                       ],
                     ),
                     GestureDetector(
                       onTap: (){
                         openMap(data['locLink']);
                       },
                       child: Container(
                         height: 50,width: 50,
                         child: Lottie.asset("assets/Animations/Location Pin.json"),)
                     )
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                   child: Text("Property Overview",style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w500)),
                 ),
                 SizedBox(height: 15,),
                 Container(
                   height: 370,
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.blueAccent.withValues(alpha:  0.1),
                       border: Border.all(color: Colors.black54.withValues(alpha:  0.1))),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.newspaper_outlined,),
                             title: Text("Project Name",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['propertyName']}",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.area_chart_outlined),
                             title: Text("Built Up Area",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['builtArea']} sq.ft",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                       ],),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.currency_rupee_outlined),
                             title: Text("Price",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("₹${data['sellingPrice']}",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.area_chart),
                             title: Text("Carpet Area",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['carpetArea']} sq.ft",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                       ],),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.bed_outlined),
                             title: Text("Bedrooms",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['noOfBedrooms']}",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.bathroom_outlined),
                             title: Text("Bathrooms",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['noOfBathrooms']}",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                       ],),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.stacked_bar_chart_outlined),
                             title: Text("Floor",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['totalFloors']}",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.balcony_outlined),
                             title: Text("Balcony",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['balcony']}",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                       ],),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.house_siding),
                             title: Text("Added",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['year']}",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                         Expanded(
                           child: ListTile(
                             leading: Icon(Icons.location_city_outlined),
                             title: Text("City",style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.w500),),
                             subtitle: Text("${data['city']}",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),),
                           ),
                         ),
                       ],),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                   child: Text("Description",
                       style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w500)),
                 ),
                 Text("${data['description']}",
                     style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500)),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                   child: Text("Contact information",
                       style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w500)),
                 ),
                 SizedBox(height: 10,),
                 Container(
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.black54.withValues(alpha:  0.1))),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       ListTile(
                         leading: Icon(Icons.person_outline),
                         title: Text("Seller name",style: TextStyle(fontWeight: FontWeight.w500),),
                         subtitle: Text("${data['sellerName']}"),
                         trailing: Icon(Icons.verified_outlined,color: Colors.greenAccent,),
                       ),
                       ListTile(
                         leading: Icon(Icons.alternate_email_outlined),
                         title: Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
                         subtitle: Text("${data['sellerEmail']}"),
                         trailing: Icon(Icons.verified_outlined,color: Colors.greenAccent,),
                       ),
                     ],
                   ),
                 )
               ],
             );
           }
         },
       )
     ),
   );
  }
}
