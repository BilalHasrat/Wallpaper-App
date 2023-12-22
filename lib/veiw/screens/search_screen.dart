import 'package:flutter/material.dart';
import 'package:wallpaper_app/contoller/api_services.dart';
import 'package:wallpaper_app/model/photo_model.dart';
import 'package:wallpaper_app/veiw/widgets/custom_appbar.dart';

class SearchScreen extends StatefulWidget {

  String query;
   SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    getSearchPhotos();
    // TODO: implement initState
    super.initState();
  }

   List<PhotoModel> searchWallpaperList = [];
  getSearchPhotos()async{
    searchWallpaperList = await ApiServices.searchWallpapers(widget.query);
    setState(() {

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          centerTitle: true,
          backgroundColor: Colors.white70,
          title: CustomAppBar( appBarTitle1: 'Related',appBarTitle2: '  Wallpaper',)
      ),

      body: Column(
        children: [

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: searchWallpaperList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 200
                  ),
                  itemBuilder: (context ,index){
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.white54
                      ),
                      child: Image.network(searchWallpaperList[index].imageSrc,
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
