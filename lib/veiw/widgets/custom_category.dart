import 'package:flutter/material.dart';
import 'package:wallpaper_app/veiw/screens/category.dart';

class Category extends StatelessWidget {
  String categoryName;
  String categoryImgSrs;

   Category({Key? key,
   required this.categoryImgSrs,
     required this.categoryName,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen(categName: categoryName, categUrl: categoryImgSrs)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 12),
        height: 60,
        child: Column(
          children: [

            Row(
            children: [
              Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
            backgroundImage: NetworkImage(categoryImgSrs)),
              ),
              SizedBox(width: 5,),

              Text(categoryName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),)
            ],
        )
          ],
        )
        ),
    );
  }
}
