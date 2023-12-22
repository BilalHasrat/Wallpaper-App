import 'package:flutter/material.dart';
import 'package:wallpaper_app/contoller/api_services.dart';
import 'package:wallpaper_app/model/category_model.dart';
import 'package:wallpaper_app/veiw/widgets/custom_appbar.dart';

import '../../model/photo_model.dart';


class CategoryScreen extends StatefulWidget {
 final String categName;
 final String categUrl;

   CategoryScreen({Key? key,
   required this.categName,
     required this.categUrl,

   }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  List<PhotoModel> categoryResults = [];
  bool loading = true;

  getCatRelWal()async{
    categoryResults = await ApiServices.searchWallpapers(widget.categName);
    setState(() {
      loading = false;
    });
  }
  @override
  void initState() {

    getCatRelWal();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white70,
          title: CustomAppBar(
            appBarTitle1: 'Wallpaper ',
            appBarTitle2: widget.categName,)
      ),

      body: loading ? Center(child: CircularProgressIndicator()): Column(
        children: [

          Stack(
            children: [
              Image.network(widget.categUrl,
              height: 150,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Colors.black38,
              ),
              Positioned(
                top: 40,
                left: 120,
                child: Column(
                  children: [
                    Text('Category:',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 20)),
                    Text(widget.categName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),)
                  ],
                ),
              )
      ]
          ),

          SizedBox(height: 20,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: categoryResults.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300
                  ),
                  itemBuilder: (context ,index){
                    return Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                          color: Colors.deepOrange
                      ),
                      child: Image.network(categoryResults[index].imageSrc,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
