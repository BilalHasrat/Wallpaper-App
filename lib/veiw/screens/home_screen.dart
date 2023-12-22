import 'package:flutter/material.dart';
import 'package:wallpaper_app/contoller/api_services.dart';
import 'package:wallpaper_app/model/category_model.dart';
import 'package:wallpaper_app/model/photo_model.dart';
import 'package:wallpaper_app/veiw/screens/image_full_screen.dart';
import 'package:wallpaper_app/veiw/widgets/custom_appbar.dart';
import 'package:wallpaper_app/veiw/widgets/custom_category.dart';
import 'package:wallpaper_app/veiw/widgets/custome_textfeild.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  final searchController = TextEditingController();

  List<PhotoModel> getWallpaperList = [];
  List<CategoryModel> CatModList =[];

  GetCatDetails() async {
    CatModList = await ApiServices.getCategoriesList();

    setState(() {
      CatModList = CatModList;
    });
  }


  getWallpapers ()async{
    getWallpaperList = await ApiServices.getTrendingWallpaper();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetCatDetails();
    getWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white70,
        title: CustomAppBar( appBarTitle1: 'Wallpaper',appBarTitle2: '  App',)
      ),

      body: Column(
        children: [

          SearchField(),

          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: CatModList.length,
                    itemBuilder: (context, index)=> Category(

                      categoryImgSrs: CatModList[index].catImgUrl,
                      categoryName: CatModList[index].catName,)),

              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: getWallpaperList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200
                  ),
                  itemBuilder: (context ,index){
                return InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>ImageFullScreen(
                                imageUrl: getWallpaperList[index].imageSrc)));
                  },
                  child: Hero(
                    tag: getWallpaperList[index].imageSrc,
                    child: Container(

                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          getWallpaperList[index].imageSrc,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
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
