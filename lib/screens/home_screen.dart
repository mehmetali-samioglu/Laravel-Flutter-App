
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/api/posts_api.dart';
import 'package:flutter_projects/models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  PostsApi postsapi = PostsApi(); 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa')
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.tealAccent
              ),
              child: Text('Header'),
            ),
            ListTile(
              title: Text('Kategoriler'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/categories');
              },
            )
          ],
        ),
      ), 
      body: FutureBuilder(
        future: postsapi.fetchRecentPosts(),
        builder : (BuildContext context, AsyncSnapshot<List<Post>> snapshot){
          switch( snapshot.connectionState ){
              case ConnectionState.active : 
              return _loading();
                break;
              case ConnectionState.waiting:
                //STILL WORKING
              return _loading();
                break;
              case ConnectionState.none:
                //ERROR
              return _error('Bağlantı Sağlanamadı.');
                break;
              case ConnectionState.done:
                //COMPLETED
                if(snapshot.hasError){
                  return _error(snapshot.error);
                }
                if( ! snapshot.hasData ){
                  return _error('Data Bulunamadı.');
                }
                  return _drawPostsList(snapshot.data);
                break;
            }
        }
      ),
    );
  }


 
  //snapshot içini List<Post> olarak tanımlandıgını unutma
  Widget _drawPostsList(List<Post> posts){
    List<Post> postWithImages = [];
    for(Post post in posts) {
      if(post.images.length > 0){
        postWithImages.add(post);
      }
    } 
    return Column(
      children: <Widget>[
        _sliders(postWithImages),
        _postsList(posts),
      ],
    );
  }

  Widget _sliders( List<Post> posts){
    return Container(
      height: MediaQuery.of(context).size.height  *0.2,
      width: double.infinity,
      child: PageView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context , int position){ 
          return InkWell(
            onTap: (){
              print(posts[position].post_title);
            },
            child: Stack(
              children: <Widget>[ 
                Container(
                  width: double.infinity,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(  posts[position].images[0].image_url ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom:8),
                    color: Colors.grey.withAlpha( 100 ),
                    child:Text(
                      posts[position].post_title,
                      style:TextStyle(fontSize: 18,color:Colors.tealAccent)
                    )
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }


  _postsList(List<Post> posts){
    return Flexible( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context , int position){
            return Card(
              child: InkWell(
                onTap: (){
                  //TODO : tekil postu göster
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Text(posts[position].post_title, style:TextStyle(color:Colors.teal,fontSize: 18)),
                      SizedBox(height: 14.0,),
                      Text(
                        '${posts[position].author.first_name} ${posts[position].author.last_name}',
                        style: TextStyle(color:Colors.blueGrey,fontSize: 16)
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      ),
        ),
    );
  }


  Widget _error(String error){
    return Container(
      child:Center(
        child: Column(
          children: <Widget>[  
            Text('HATA!!!'),
            Text(error, style:TextStyle(color:Colors.red) ), 
          ], 
        ),
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