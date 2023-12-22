

import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart'as http;
import 'package:wallpaper_app/model/photo_model.dart';

import '../model/category_model.dart';

class ApiServices {

  static List<PhotoModel> searchWallpapersList = [];
 static List <PhotoModel> getTrendingWallpapers = [];


  static Future<List<PhotoModel>>getTrendingWallpaper()async{
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80&page=1'),
        headers: {
      "Authorization" :"Rr4nKZoNamaujcMpzLXEj8uhcSzCjZ2DK75aTsCb6gNbOeWa2Ppw0AKU"
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        getTrendingWallpapers.add(PhotoModel.fromApi2App(element));
      });
    });
    return getTrendingWallpapers;
  }

  static Future<List<PhotoModel>> searchWallpapers(String query)async{
    await http.get(Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=80&page=1'),
    headers: {
      'Authorization':'Rr4nKZoNamaujcMpzLXEj8uhcSzCjZ2DK75aTsCb6gNbOeWa2Ppw0AKU',
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List searchPhotos = jsonData['photos'];
      searchWallpapersList.clear();
      searchPhotos.forEach((element) {
        searchWallpapersList.add(PhotoModel.fromApi2App(element));
      });
    });
    return searchWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
   List <CategoryModel> cateogryModelList=[];
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers",
      "Food",
      "Sky",
      "Space",
      "Dark",
      "Beach",
      "Fish",
      "Birds",
      "LandScape",
      "Aircraft"

    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotoModel photoModel = (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];

      cateogryModelList.add(CategoryModel(catImgUrl: photoModel.imageSrc, catName: catName));
    });

    return cateogryModelList;
  }
}