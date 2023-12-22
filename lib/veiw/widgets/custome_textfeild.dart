import 'package:flutter/material.dart';
import 'package:wallpaper_app/veiw/screens/search_screen.dart';

class SearchField extends StatelessWidget {
   SearchField({Key? key}) : super(key: key);

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15,left: 10,right: 10),
      child: TextFormField(
        controller: _searchController,
        cursorWidth: 3,
        cursorColor: Colors.black,
        style: TextStyle(fontSize: 20,),
        decoration: InputDecoration(

          suffixIcon: InkWell(
            onTap: (){
              if(_searchController.text.isNotEmpty)
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(query: _searchController.text)));
            },

            child: Icon(Icons.search,size: 30,),),
          hintText: 'Search Wallpaper',
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),
      ),
    );
  }
}
