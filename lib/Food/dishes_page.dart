import 'package:flutter/material.dart';

class DishesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text("Dishes", style: TextStyle(
              color: Colors.red, fontSize: 25, fontFamily: "Ethnocentric"),),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Card(
              elevation: 10,
              shadowColor: Colors.red,
              margin: EdgeInsets.all(8),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: 400,
                    child: Image.asset("assets/images/ice cream.jpeg", fit: BoxFit.fitWidth,),
                  ),
                  Positioned(
                    top: 130,
                    child: Container(
                      width: 385,
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: Text("ICE CREAMS", style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "Inter"),
                        textAlign: TextAlign.center,),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(color: Colors.grey, height: 1,),
            ),
            Text("ALL RESTAURANTS DELIVERING ICE CREAMS", style: TextStyle(color: Colors.white,
                fontFamily: "Inter",
                fontSize: 16,
                ),),
            Column(
              children: [
                Card(
                  elevation: 4,
                  margin: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children:[
                        SizedBox(
                            height: 150,
                            width: 400,
                            child: Image(
                              image: AssetImage("assets/images/ice cream.jpeg"),
                              fit: BoxFit.cover,
                            )),
                          Positioned(
                            top: 10,
                            left: 15,
                            child: Container(
                              width: 150,
                              height: 20,
                              color: Colors.black.withOpacity(.7),
                              child: Text("CHOCO BURST ₹60",style: TextStyle(color: Colors.white,fontFamily: "Inter"),textAlign: TextAlign.center,),
                            ),
                          ),
                        ] ,
                      ),
                      Text(
                        "Havmor Ice-Cream",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            letterSpacing: 0.3),
                      ),
                      Text(
                        "ICE-CREAM & FALUDA",
                        style: TextStyle(
                            color: Color(0xFF242323),
                            fontFamily: "Inter",
                            fontSize: 13,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children:[
                        SizedBox(
                            height: 150,
                            width: 400,
                            child: Image(
                              image: AssetImage("assets/images/ice cream.jpeg"),
                              fit: BoxFit.cover,
                            )),
                          Positioned(
                            top: 10,
                            left: 15,
                            child: Container(
                              width: 150,
                              height: 20,
                              color: Colors.black.withOpacity(.7),
                              child: Text("MAGMUM ₹100",style: TextStyle(color: Colors.white,fontFamily: "Inter"),textAlign: TextAlign.center,),
                            ),
                          ),
                        ] ,
                      ),
                      Text(
                        "Amul Ice-Cream",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            letterSpacing: 0.3),
                      ),
                      Text(
                          "ICE-CREAM & MILK PRODUCTS",
                        style: TextStyle(
                            color: Color(0xFF242323),
                            fontFamily: "Inter",
                            fontSize: 13,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children:[
                        SizedBox(
                            height: 150,
                            width: 400,
                            child: Image(
                              image: AssetImage("assets/images/ice cream.jpeg"),
                              fit: BoxFit.cover,
                            )),
                          Positioned(
                            top: 10,
                            left: 15,
                            child: Container(
                              width: 150,
                              height: 20,
                              color: Colors.black.withOpacity(.7),
                              child: Text("CHOCO BURST ₹60",style: TextStyle(color: Colors.white,fontFamily: "Inter"),textAlign: TextAlign.center,),
                            ),
                          ),
                        ] ,
                      ),
                      Text(
                        "Havmor Ice-Cream",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            letterSpacing: 0.3),
                      ),
                      Text(
                        "ICE-CREAM & FALUDA",
                        style: TextStyle(
                            color: Color(0xFF242323),
                            fontFamily: "Inter",
                            fontSize: 13,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      )
    );
  }
}