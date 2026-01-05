import 'package:flutter/material.dart';
import 'package:login_form/Meetings_1.dart';
import 'package:login_form/Meetings_2.dart';


class Meetings extends StatefulWidget {
  const Meetings({super.key});

  @override
  State<Meetings> createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text(" Your Meetings"),
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder){
                  return Meetings_2();
                }));
              },
              child: Card(
                elevation: 3,
                child: Container(
                  height: 140,width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xff3E5879).withValues(alpha:  0.6),borderRadius: BorderRadius.circular(15)),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Meetings You Scheduled",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Color(0xffF5EFE7))),
                            Icon(Icons.keyboard_arrow_right_outlined,color: Color(0xff213555),size: 26,)
                          ],
                        ),
                        SizedBox(height: 15,),
                        Text("You’ve requested meetings with property sellers.",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 17),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder){
                  return Meetings_1();
                }));
              },
              child: Card(
                elevation: 3,
                child: Container(
                  height: 140,width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xff3E5879).withValues(alpha:  0.6),borderRadius: BorderRadius.circular(15)),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Meetings For You",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Color(0xffF5EFE7))),
                            Icon(Icons.keyboard_arrow_right_outlined,color: Color(0xff213555),size: 26,)
                          ],
                        ),
                        SizedBox(height: 15,),
                        Text("Buyers requested meetings for your properties.",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 17),)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}