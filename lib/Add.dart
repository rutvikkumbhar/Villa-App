import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_form/Home.dart';
import 'package:login_form/Error.dart';

class Add extends StatefulWidget {
  const Add({super.key});
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final User? _auth=FirebaseAuth.instance.currentUser;
  Reference photoRef=FirebaseStorage.instance.ref().child('property_photo');
  Reference videoRef=FirebaseStorage.instance.ref().child('property_video');

  final _formKey = GlobalKey<FormState>();
  File? _image;
  File? _video;
  String? imageUrl;
  String? videoUrl;
  bool loading=false;

  final pptNameController=TextEditingController();
  final locLinkController=TextEditingController();
  final pptTypeController=TextEditingController();
  final descriptionController=TextEditingController();
  final addressController=TextEditingController();
  final zipController=TextEditingController();
  final cityController=TextEditingController();
  final stateController=TextEditingController();
  final bedroomController=TextEditingController();
  final bathroomController=TextEditingController();
  final carpetController=TextEditingController();
  final builtController=TextEditingController();
  final floorController=TextEditingController();
  final balconyController=TextEditingController();
  final yearController=TextEditingController();
  final priceController=TextEditingController();
  final sellerNameController=TextEditingController();
  final sellerEmailController=TextEditingController();
  final sellerContactController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text("Add Property"),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
        child: Form(
          key: _formKey,
          child: ListView(
          children: [
            Text("Add your new",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black54),),
            Text("Property",style: GoogleFonts.alexBrush(fontSize: 47,fontWeight: FontWeight.w500),),
            SizedBox(height: 40,),
            Text("Property", style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha: 0.7), fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "Name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: pptNameController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter name!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15,),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText: "Property Type", hintText: "Select property type",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                ),
                initialValue: pptTypeController.text.isEmpty ? null : pptTypeController.text,
                items: [
                  'Apartment Flat',
                  'Villa Bungalow',
                  'Townhouse',
                  'Penthouse',
                  'Studio Apartment',
                  'Duplex Triplex',
                  'Farmhouse',
                  'Plot Land',
                  'Commercial',
                  'Industrial',
                  'Holiday Homes',
                  'Resort',
                ].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  pptTypeController.text = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select property type!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 15,),
                  TextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "Description",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: descriptionController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter description!";
                      } else {
                        return null;
                      }
                    },
                  ),
              ],),
            ),
            Text("Location",style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 4,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "Address",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: addressController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter address!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Zip code",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: zipController,
                    validator: (value){
                      if(value==null || value.isEmpty || value.length!=6){
                        return "Please enter valid zip!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(labelText: "City",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),),
                          controller: cityController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter city!";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(labelText: "State",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),),
                          controller: stateController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter state!";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(labelText: "Google map link",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: locLinkController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter link!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            Text("Amenities",style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Bedrooms",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),),
                          controller: bedroomController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter bedrooms!";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Bathrooms",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),),
                          controller: bathroomController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter bathrooms!";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Carpet Area",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),),
                          controller: carpetController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter carpet area";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Built Up Area",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),),
                          controller: builtController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter built area!";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Total floors",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),),
                          controller: floorController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter floors!";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Balcony",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),),
                          controller: balconyController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter balcony!";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(label: Text("Build Year"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: yearController,
                    validator: (value) {
                     if(value!.isEmpty || value.length!=4){
                       return 'Enter a valid year';
                     }
                     return null;
                    },
                  )
                ],
              ),
            ),
            Text("Pricing",style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Selling price",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: priceController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter price!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            Text("Images & Videos",style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black87.withValues(alpha:  0.1))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height:60,
                      width: 60,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black87.withValues(alpha:  0.5))),
                      child: IconButton(
                        icon: Icon(Icons.add_photo_alternate_outlined),
                        onPressed: () async {
                          final pickedImage= await ImagePicker().pickImage(source: ImageSource.gallery);
                          _image=File(pickedImage!.path.toString());
                        },
                      ),
                    ),
                    Container(
                      height:60,
                      width: 60,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black87.withValues(alpha: 0.5))),
                      child:IconButton(
                        icon: Icon(Icons.video_call_outlined,size: 33,),
                        onPressed: ()async {
                          final pickedVideo=await ImagePicker().pickVideo(source: ImageSource.gallery);
                          _video=File(pickedVideo!.path.toString());
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 17,),
            Text("Contact information",style: TextStyle(fontSize: 17, color: Colors.black.withValues(alpha:  0.7), fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
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
                    controller: sellerNameController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Enter valid name";
                      } else {
                        return null;
                      }
                    },
                    ),
                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email address",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: sellerEmailController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Enter valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Contact number",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: sellerContactController,
                    validator: (value){
                      if(value==null || value.isEmpty || value.length!=10){
                        return "Enter valid number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height:50,
                  decoration: BoxDecoration(color: const Color(0xff213555),borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: TextButton(
                      child: loading?CircularProgressIndicator(color: Colors.white,):Text("Add",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          setState(() {
                            loading=true;
                          });
                          if(_image==null || _video==null){
                            if(_image==null){
                              Error().toastMessage("Consider to add property image!");
                            } else {
                              Error().toastMessage("Consider to add property video!");
                            }
                            setState(() {
                              loading=false;
                            });
                          } else {
                            final String unique=DateTime.now().millisecondsSinceEpoch.toString();
                            final String imageId=DateTime.now().millisecondsSinceEpoch.toString();
                            final String videoId=DateTime.now().millisecondsSinceEpoch.toString();
                            await photoRef.child(imageId).putFile(_image!);
                            await videoRef.child(videoId).putFile(_video!);
                            imageUrl=await photoRef.child(imageId).getDownloadURL();
                            videoUrl=await videoRef.child(videoId).getDownloadURL();

                            CollectionReference userRef=FirebaseFirestore.instance.collection('Users').doc(_auth!.uid).collection('User Properties');
                            CollectionReference ref=FirebaseFirestore.instance.collection(pptTypeController.text.toString());
                            await ref.doc(unique).set({
                              'address':addressController.text.toString(),
                              'balcony':balconyController.text.toString(),
                              'builtArea':builtController.text.toString(),
                              'carpetArea':carpetController.text.toString(),
                              'city':cityController.text.toString(),
                              'description':descriptionController.text.toString(),
                              'noOfBathrooms':bathroomController.text.toString(),
                              'noOfBedrooms':bedroomController.text.toString(),
                              'propertyImageUrl':imageUrl.toString(),
                              'propertyId':unique.toString(),
                              'propertyName':pptNameController.text.toString(),
                              'propertyType':pptTypeController.text.toString(),
                              'propertyVideoUrl':videoUrl.toString(),
                              'sellerContact':sellerContactController.text.toString(),
                              'sellerEmail':sellerEmailController.text.toString(),
                              'sellerName':sellerNameController.text.toString(),
                              'sellingPrice':priceController.text.toString(),
                              'sellerId':_auth.uid.toString(),
                              'state':stateController.text.toString(),
                              'totalFloors':floorController.text.toString(),
                              'year':yearController.text.toString(),
                              'zipCode':zipController.text.toString(),
                              'locLink':locLinkController.text.toString()
                            }).then((onValue)async {
                              await userRef.doc(unique).set({
                                'address':addressController.text.toString(),
                                'balcony':balconyController.text.toString(),
                                'builtArea':builtController.text.toString(),
                                'carpetArea':carpetController.text.toString(),
                                'city':cityController.text.toString(),
                                'description':descriptionController.text.toString(),
                                'noOfBathrooms':bathroomController.text.toString(),
                                'noOfBedrooms':bedroomController.text.toString(),
                                'propertyImageUrl':imageUrl.toString(),
                                'propertyId':unique.toString(),
                                'propertyName':pptNameController.text.toString(),
                                'propertyType':pptTypeController.text.toString(),
                                'propertyVideoUrl':videoUrl.toString(),
                                'sellerContact':sellerContactController.text.toString(),
                                'sellerEmail':sellerEmailController.text.toString(),
                                'sellerName':sellerNameController.text.toString(),
                                'sellingPrice':priceController.text.toString(),
                                'sellerId':_auth.uid.toString(),
                                'state':stateController.text.toString(),
                                'totalFloors':floorController.text.toString(),
                                'year':yearController.text.toString(),
                                'zipCode':zipController.text.toString(),
                                'locLink':locLinkController.text.toString()
                              }).then((onValue){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Property added successfully")));
                                Navigator.pop(context);
                              }).onError((error,stackTrace){
                                setState(() {
                                  loading=false;
                                });
                                Error().toastMessage(error.toString());
                              });
                            }).onError((error,stackTrace){
                              setState(() {
                                loading=false;
                              });
                              Error().toastMessage(error.toString());
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black87.withValues(alpha:  0.3))),
                  child: TextButton(
                    child: Text("Cancel",style: TextStyle(fontSize: 18,color: Colors.black87,fontWeight: FontWeight.w500),),
                    onPressed: () {
                      Navigator.pop(context, MaterialPageRoute(builder: (builder){
                        return Home();
                      }));
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Villa",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 25,color: Colors.black.withValues(alpha:  0.2)),),),
              ],
            ),
          ],
        ),
      )
      ),
    );
  }
}
