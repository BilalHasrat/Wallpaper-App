import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String appBarTitle1;
  String?   appBarTitle2;
   CustomAppBar({Key? key,required this.appBarTitle1, this.appBarTitle2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          text:  appBarTitle1,
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
          children: [
            TextSpan(
              text: appBarTitle2,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.orangeAccent),
            ),
          ]
        )


      )
    );
  }
}
