import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_form/Error.dart';
import 'dart:io';

import 'Login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final nameController=TextEditingController();
  final mobileNoController=TextEditingController();
  String imageUrl='';
  bool loading=false;
  bool pass=true;

  final FirebaseAuth _auth=FirebaseAuth.instance;
  CollectionReference collectref=FirebaseFirestore.instance.collection('Users');
  Reference ref=FirebaseStorage.instance.ref().child('user_profile_pic');

  String? name;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5EFE7),
        body: ListView(
        children:[ Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Text("Welcome",style:  GoogleFonts.alexBrush(fontSize: 40),),
            Text("Sign up to get started",style:  GoogleFonts.poppins(fontSize: 13),),
            SizedBox(height: 20,),
            Container(
              height: 80,width: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(image: AssetImage("assets/images/ProfilePic.jpg"),
                      colorFilter: ColorFilter.mode(Colors.black.withValues(alpha:  0.3), BlendMode.darken,))),
              child: IconButton(
                icon: Icon(Icons.add_a_photo_outlined,color: Color(0xffF5EFE7),),
                onPressed: () async {
                  final pickedImage =await  ImagePicker().pickImage(source: ImageSource.gallery);
                  image=File(pickedImage!.path.toString());
                }
              ),
            ),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Name",prefixIcon: const Icon(Icons.person_outline_rounded,color: Color(0xff3E5879)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: nameController,
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter valid name!';
                    }
                    return null;
                    },
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Contact",prefixIcon: const Icon(Icons.call_outlined,color: Color(0xff3E5879)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                controller: mobileNoController,
                validator: (value) {
                  if(value==null || value.isEmpty || value.length!=10) {
                    return 'Enter valid no.!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email",prefixIcon: const Icon(Icons.alternate_email_rounded,color: Color(0xff3E5879)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                  floatingLabelStyle: const TextStyle(color: Colors.black),),
                controller: emailController,
                validator: (value) {
                  if(value==null || value.isEmpty) {
                    return 'Please enter email!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: pass?true:false,
                decoration: InputDecoration(labelText: "Password", labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    prefixIcon: const Icon(Icons.security_outlined,color: Color(0xff3E5879)),
                  suffixIcon: IconButton(
                    icon: pass?const FaIcon(FontAwesomeIcons.eyeSlash,size: 21,color: Color(0xff3E5879),):const FaIcon(FontAwesomeIcons.eye,size: 21,color: Color(0xffE52020),),
                    onPressed: (){
                      setState(() {
                        pass=pass?false:true;
                      });
                    },
                  ),),
                controller: passwordController,
                validator: (value) {
                  if(value==null || value.isEmpty) {
                    return 'Enter valid password!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: 250,height: 55,
              decoration: BoxDecoration(color: Color(0xff213555),borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                child: loading?CircularProgressIndicator(color: Colors.white,):Text("Sign Up",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 18)),
                onPressed: () async {
                  setState(() {
                    loading=true;
                  });
                  if (_formKey.currentState!.validate()) {
                  await _auth.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text).then((onValue) async {
                        if(image!=null){
                          await ref.child(_auth.currentUser!.uid).putFile(image!);
                          imageUrl=await ref.child(_auth.currentUser!.uid).getDownloadURL();
                        }
                        await collectref.doc(_auth.currentUser!.uid).set({
                          'userName':nameController.text.toString(),
                          'mobileNo':mobileNoController.text.toString(),
                          'email':emailController.text.toString(),
                          'password':passwordController.text.toString(),
                          'pfpURL':imageUrl.toString(),
                        });
                        final msg = SnackBar(content: Text("Account created"),);
                        ScaffoldMessenger.of(context).showSnackBar(msg);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()),);
                  }).onError((error, stackTrace){
                    setState(() {
                      loading=false;
                    });
                    Error().toastMessage(error.toString());
                  });
                } else {
                    setState(() {
                      loading=false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",style: GoogleFonts.poppins(color: const Color(0xff3E5879).withValues(alpha:  0.7),fontSize: 13,fontWeight: FontWeight.w400),),
                GestureDetector(
                  child: Text("Log In.",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.blue)),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 90,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Villa",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 23,color: Colors.black.withValues(alpha:  0.2)),),),
              ],
            ),
          ],
          ),
        ),
      ],
      )
    );
  }
}
