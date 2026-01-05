import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_form/Profile.dart';
import 'package:login_form/Error.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  final _formKey = GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final nameController=TextEditingController();
  final mobileNoController=TextEditingController();
  
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Reference ref=FirebaseStorage.instance.ref().child('user_profile_pic');
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
  File? image;
  bool loading=false;
  bool pass=true;
  
  String? userName;
  String? email;
  String? mobileNo;
  String? password;
  String? imageurl;
  String? url;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    User? user=_auth.currentUser;
    DocumentSnapshot data=await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
    setState(() {
      userName=data['userName'];
      email=data['email'];
      mobileNo=data['mobileNo'];
      password=data['password'];
      passwordController.text=data['password'];
      imageurl=data['pfpURL'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title:Text("Edit Profile"),
      ),
      body:Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(image: DecorationImage(image: (imageurl!.isEmpty)?AssetImage("assets/images/ProfilePic.jpg"):NetworkImage(imageurl!),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(100),),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(76,76,0,0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                           color: Color(0xffD8C4B6).withValues(alpha:  0.5)),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.edit_outlined,color: Color(0xff213555)),
                            onPressed: () async {
                              final pickedImage=await ImagePicker().pickImage(source: ImageSource.gallery);
                              File? image=File(pickedImage!.path.toString());
                              try{
                                await ref.child(_auth.currentUser!.uid).putFile(image);
                                url=await ref.child(_auth.currentUser!.uid).getDownloadURL();
                                collectionReference.doc(_auth.currentUser!.uid).update({
                                  'pfpURL': url.toString(),
                                });
                              }
                              finally{
                                setState(() {
                                  imageurl=url;
                                });
                                final msg=SnackBar(content: Text("Profile Picture Updates"));
                                ScaffoldMessenger.of(context).showSnackBar(msg);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(hintText: userName,hintStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey.withValues(alpha:  0.2),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5)),
                          prefixIcon: Icon(Boxicons.bx_user,size: 23,color: Color(0xff213555),)),
                      controller: nameController,
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "+91 $mobileNo",hintStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey.withValues(alpha:  0.2),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(5)),
                          prefixIcon: Icon(Icons.call_rounded,size: 23,color: Color(0xff213555),)),
                      controller: mobileNoController,
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress, enabled: false,
                      decoration: InputDecoration(hintText: email,hintStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey.withValues(alpha:  0.2),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.alternate_email_rounded,size: 23,color: Color(0xff213555),)),
                      controller: emailController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 45,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey)),
                    child: TextButton(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Text("Cancel",style: TextStyle(fontSize: 16,color: Colors.black.withValues( alpha:  0.8),fontWeight: FontWeight.w600),),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(color: const Color(0xff213555),borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: TextButton(
                        child: loading?CircularProgressIndicator(color: Colors.white,):Text("Update",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),),
                        onPressed: () async {
                          if(passwordController.text.isEmpty && nameController.text.isEmpty && mobileNoController.text.isEmpty){
                            setState(() {
                              final msg=SnackBar(content: Text("No changes has been done!"));
                              ScaffoldMessenger.of(context).showSnackBar(msg);
                              loading=false;
                              return;
                            });
                          } else {
                            setState(() {
                              loading=true;
                            });
                          }
                          AuthCredential credential = EmailAuthProvider.credential(
                            email: email.toString(),
                            password: password.toString(),
                          );
                          await _auth.currentUser!.reauthenticateWithCredential(credential);
                          if(passwordController.text.isNotEmpty){
                            await _auth.currentUser!.updatePassword(passwordController.text.toString()).then((onValue) async {
                              await collectionReference.doc(_auth.currentUser!.uid).update({
                                'password':passwordController.text.toString(),
                              });
                              final msg=SnackBar(content: Text("Changes saved successfully"));
                              ScaffoldMessenger.of(context).showSnackBar(msg);
                              Navigator.pop(context, MaterialPageRoute(builder: (builder){
                                return Profile();
                              }));
                            }).onError((error, stackTrace){
                              Error().toastMessage(error.toString());
                              setState(() {
                                loading=false;
                              });
                            });
                          }
                          if(nameController.text.isNotEmpty){
                            await collectionReference.doc(_auth.currentUser!.uid).update({
                              'userName': nameController.text.toString(),
                            });
                            final msg=SnackBar(content: Text("Changes saved successfully"));
                            ScaffoldMessenger.of(context).showSnackBar(msg);
                            Navigator.pop(context, MaterialPageRoute(builder: (builder){
                              return Profile();
                            }));
                          }
                          if(mobileNoController.text.isNotEmpty) {
                            if(mobileNoController.text.toString().length ==10){
                              await collectionReference.doc(_auth.currentUser!.uid).update({
                                'mobileNo': mobileNoController.text.toString(),
                              });
                              final msg=SnackBar(content: Text("Changes saved successfully"));
                              ScaffoldMessenger.of(context).showSnackBar(msg);
                              Navigator.pop(context, MaterialPageRoute(builder: (builder){
                                return Profile();
                              }));
                            } else {
                              Error().toastMessage("Invalid mobile number!");
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      )
    );
  }
}