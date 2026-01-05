import 'package:flutter/material.dart';
import 'AllProperty.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      appBar: AppBar(
        backgroundColor: Color(0xffF5EFE7),
        title: Text("Categories"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
        child: ListView(
          children: [
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Apartment Flat",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Apartment  Flat.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Apartment / Flat",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Villa Bungalow",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Villa  Bungalow.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Villa / Bungalow",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Townhouse",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Row House  Townhouse.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Townhouse",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Penthouse",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Penthouse.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Penthouse",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Studio Apartment",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Studio Apartment.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Studio Apartment",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Duplex Triplex",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Duplex  Triplex.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Duplex Triplex",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Farmhouse",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Farmhouse.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Farmhouse",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Plot Land",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Plot  Land.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Plot / Land",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Commercial",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Commercial Property.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Commercial",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Industrial",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Industrial Property.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Industrial",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Holiday Homes",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Holiday Homes.png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Holiday Homes",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return AllProperty(collectionName: "Resort",);
                      }));
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            height: 100,width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Categories/Resort .png")),borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Text("Resort",style: TextStyle(color: Colors.black.withValues(alpha:  0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}