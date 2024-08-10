
import 'package:app/Food/orders_status.dart';
import 'package:flutter/material.dart';


class PaymentSuccesful extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 280,
          height: 380,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Card(
            elevation: 10,
            shadowColor: Colors.red,
            color: Colors.red,
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle,color: Colors.white,size: 70,),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,),
                  child: Text("Success !",style: TextStyle(color: Colors.white,fontFamily: "Inter",fontSize: 45,),),
                ),
                Text("Your Payment was Succesful. \n Order Details will be sent to your email. ",style: TextStyle(color: Colors.white,fontFamily: "Inter",fontSize: 16),textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (_)=> OrdersPage()));
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(child: Text("Go Back",style: TextStyle(color: Colors.red,fontSize: 22,fontFamily: "Inter"),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}