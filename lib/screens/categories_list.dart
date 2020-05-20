import 'package:flutter/material.dart';
import 'package:flutter_projects/api/categories_api.dart';
import 'package:flutter_projects/models/category.dart';
import 'package:flutter_projects/screens/category_posts.dart'; 

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {

   CategoriesApi categoriesApi = CategoriesApi();

  @override
  void initState() {
    super.initState();
    categoriesApi = CategoriesApi();
    categoriesApi.fetchAllCategories();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategoriler'),
      ),
      body:Container(
        padding: EdgeInsets.all(24),
        child: FutureBuilder(
          future: categoriesApi.fetchAllCategories(),
          builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot ){
            switch( snapshot.connectionState ){
              case ConnectionState.active :
              //STILL WORKING
              return _loading();
                break;
              case ConnectionState.waiting:
                //STILL WORKING
              return _loading();
                break;
              case ConnectionState.none:
                //ERROR
              return _error('Bağlantı sağlanamadı.');
                break;
              case ConnectionState.done:
                //COMPLETED
                if(snapshot.hasError){
                  return _error(snapshot.error.toString());
                }
                if(snapshot.hasData) {
                  return _drawCategoryList(snapshot.data,context);
                }
                break;
            }
          },
        ),
      ),
    );
  }



//snapshot içini List<Category> olarak tanımlandıgını unutma
  Widget _drawCategoryList(List<Category> categories, BuildContext context){
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int position){
        String hexColor = (categories[position].color).replaceAll('#', '0xFF'); 
        return InkWell(
          onTap: (){
            Navigator.push(
              context,
                MaterialPageRoute(
                  builder: (context)=> CategoryPosts(categories[position].id) 
                )
            );
          },
          child: Card(
            child: Stack(
              children: <Widget>[
                Align(  
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 4,
                    child: Container(
                      color:  Color(int.parse(hexColor)) ,
                    ), 
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(categories[position].title,style:TextStyle(fontSize: 18) ),
                ),
              ],
            ),
          ),
        );
       },
    );
  }

  Widget _error(String error){
    return Container(
        child:Center(
        child:Text(error, style:TextStyle(color:Colors.red) ),
    )
    );
  }


  Widget _loading(){
    return Container(
      child:Center(
        child:CircularProgressIndicator(),
      )
    );
  }
 

}