import 'package:flutter/material.dart';

class EditProperty extends StatefulWidget {
  final String docid;
  const EditProperty({super.key, required this.docid});

  @override
  State<EditProperty> createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text("Update Property"),
      ),
      body: ListView(
        children: [
          Text("update Property Here")
        ],
      ),
    );
  }
}