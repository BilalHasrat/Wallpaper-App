import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:open_file/open_file.dart';

class ImageFullScreen extends StatelessWidget {

  final String imageUrl;
   ImageFullScreen({Key? key,required this.imageUrl}) : super(key: key);

   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   Future<void> setWallpapersFromFile(String wallpaperUrl, context)async{

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloading....')));

     try{
       var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
       if(imageId == null){
         return ;
       }
       var fileName = await ImageDownloader.findName(imageId);
       var size = await ImageDownloader.findByteSize(imageId);
       var nimType = await ImageDownloader.findMimeType(imageId);
       var path = await ImageDownloader.findPath(imageId);

       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Text('Downloaded',),
             action: SnackBarAction(label: "Open",
           onPressed: () {
         OpenFile.open(path);
         },),));

     }on PlatformException catch(e){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
     }
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: ElevatedButton(
        onPressed: ()async{
          await setWallpapersFromFile(imageUrl, context);
        }, child: Text('Download'),),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              image: NetworkImage(imageUrl,

              ))
        ),
      ),
    );
  }
}
