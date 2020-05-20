import 'package:flutter/material.dart';
import 'package:flutter_projects/api/categories_api.dart';
import 'package:flutter_projects/models/post.dart';


class CategoryPosts extends StatefulWidget {
  
  final String categorID;
  CategoryPosts(this.categorID);
  

  @override
  _CategoryPostsState createState() => _CategoryPostsState();
}

class _CategoryPostsState extends State<CategoryPosts> {

  CategoriesApi categoriesApi = CategoriesApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haberler'),
      ),
      body:Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: categoriesApi.fetchPostsForCategory( widget.categorID ),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot ){

            switch(snapshot.connectionState) {
              case ConnectionState.none:
                return _error('Bağlantı yok.');
                break;
              case ConnectionState.waiting: 
                return _loading();
                break;
              case ConnectionState.active:
                return _loading();
                break;
              case ConnectionState.done:
                if(snapshot.hasError){
                  return _error(snapshot.error.toString());
                } 
                 return _drawPostsList(snapshot.data);
                break;
            }
            return Container();
          },
        ),
      ) 
    );
  }



  //snapshot içini List<Post> olarak tanımlandıgını unutma
  Widget _drawPostsList(List<Post> posts){
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int position ){
          return  InkWell(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(children: <Widget>[
                  Text(posts[position].post_title, style: TextStyle(color: Colors.teal,fontSize: 16.0),),
                  SizedBox(height: 18,),
                  Text(posts[position].post_type, style:TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold)),
                ],
              ),
              ),
            ),
            onTap: (){

            },
          );
        }
      ),
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
