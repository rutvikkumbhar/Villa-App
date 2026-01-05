import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Error.dart';

class Schedule extends StatefulWidget {
  @override
  State<Schedule> createState() => _ScheduleState();
  final String documentId;
  final String collection;
  const Schedule({super.key, required this.collection,required this.documentId});
}

class _ScheduleState extends State<Schedule> {
  
  CollectionReference collectionReference=FirebaseFirestore.instance.collection("SCHEDULES");
  final FirebaseAuth _auth=FirebaseAuth.instance;
  
  User? user=FirebaseAuth.instance.currentUser;
  bool loading=false;
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  final _formKey = GlobalKey<FormState>();
  final buyerNameController=TextEditingController();
  final buyerEmailController=TextEditingController();
  final buyerNumberController=TextEditingController();
  final addressController=TextEditingController();
  final dateController=TextEditingController();
  final timeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text("Schedule meeting",style: TextStyle(fontSize: 21),),
      ),
      body: Padding(
        padding: EdgeInsets.only(left:10,right: 10),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection(widget.collection).doc(widget.documentId).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData){
                  Map<String, dynamic> data=snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text("Property",
                        style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black87.withValues(alpha:  0.2))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                                Container(
                                  height: 120,
                                  width: 170,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(image: NetworkImage(data['propertyImageUrl']),fit: BoxFit.cover)),
                                ),
                                SizedBox(width: 15,),
                                Expanded(
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data['propertyName'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87),),
                                      Text("₹ ${data['sellingPrice']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54),),
                                      Text("${data['propertyType']} | ${data['city']}, ${data['state']} ${data['zipCode']}",style: TextStyle(fontSize: 15,color: Colors.grey[700],fontWeight: FontWeight.w600),),
                                    ],)
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Text("Buyer info",
                        style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black87.withValues(alpha:  0.1))),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(labelText: "Full name",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                                controller: buyerNameController,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return "Name is required!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(labelText: "Email",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                                controller: buyerEmailController,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return "Email is required!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(labelText: "Contact",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                                controller: buyerNumberController,
                                validator: (value){
                                  if(value==null || value.isEmpty || value.length!=10){
                                    return "Please enter valid no.!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Text("Schedule info",
                        style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black87.withValues(alpha:  0.1))),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(suffixIcon: Icon(Icons.date_range_outlined),labelText: "Date",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                                readOnly: true,
                                controller: dateController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Date is required';
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  pickedDate=await  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().add(const Duration(days: 1)),
                                    firstDate: DateTime.now().add(const Duration(days: 1)),
                                    lastDate: DateTime(2100),
                                  );
                                  if(pickedDate!=null){
                                    setState(() {
                                      dateController.text=pickedDate.toString().split(" ")[0];
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                decoration: InputDecoration(suffixIcon: Icon(Icons.watch_later_outlined), labelText: "Time",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                                readOnly: true,
                                controller: timeController,
                                validator: (value){
                                  if(value!.isEmpty) {
                                    return 'Time is required!';
                                  }
                                  return null;
                                },
                                onTap: ()async {
                                  pickedTime =await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if(pickedTime!=null) {
                                    setState(() {
                                      timeController.text="${pickedTime!.hour}:${pickedTime!.minute} ${pickedTime!.period.name.toUpperCase()}";
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(suffixIcon: Icon(Icons.location_on_outlined), labelText: "Address",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                                controller: addressController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Address is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xff213555)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: TextButton(
                                child: loading? CircularProgressIndicator(color: Colors.white,):Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600)),
                                onPressed: () async {
                                  setState(() {
                                    loading=true;
                                  });
                                  if(_formKey.currentState!.validate()){
                                    setState(() {
                                      loading=true;
                                    });
                                    final String unique=DateTime.now().millisecondsSinceEpoch.toString();
                                    collectionReference.doc(unique).set({
                                      'buyerName':buyerNameController.text.toString(),
                                      'buyerEmail':buyerEmailController.text.toString(),
                                      'buyerNumber':buyerNumberController.text.toString(),
                                      'buyerId':_auth.currentUser!.uid.toString(),
                                      'sellerName':data['sellerName'],
                                      'sellerEmail':data['sellerEmail'],
                                      'sellerContact':data['sellerContact'],
                                      'sellerId':data['sellerId'],
                                      "createdAt": unique,
                                      'status':"PENDING",
                                      'propertyId':widget.documentId,
                                      'propertyType':widget.collection,
                                      'propertyName':data['propertyName'],
                                      'propertyImageUrl':data['propertyImageUrl'],
                                      'scheduleDate':dateController.text.toString(),
                                      'scheduleTime':timeController.text.toString(),
                                      'address':addressController.text.toString(),
                                    }).then((onValue){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Meeting request sent!")));
                                      Navigator.pop(context);
                                    }).onError((error,stackTrace){
                                      Error().toastMessage(error.toString());
                                    });
                                  }else {
                                    setState(() {
                                      loading=false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            height:50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black87.withValues(alpha:  0.9))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: TextButton(
                                child: Text("Cancel",style: TextStyle(color: Colors.black87,fontSize: 17,fontWeight: FontWeight.w600)),
                                onPressed: (){
                                 Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                } else if(snapshot.hasError){
                  return Center(child: Text("Something went wrong!"),);
                } else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
            SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Villa",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 25,color: Colors.black.withValues(alpha:  0.2)),),),
              ],
            ),
          ],
        ),
      ),),
    );
  }
}