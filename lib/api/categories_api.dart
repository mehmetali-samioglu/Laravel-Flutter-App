import 'package:flutter_projects/models/post.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'api_util.dart';
import 'package:flutter_projects/models/category.dart';

class CategoriesApi {

  Future<List<Category>> fetchAllCategories() async {

    //Veri çekilecek url ve bilgiler girildi
    String allCategoriesUrl = ApiUtil.MAIN_API_URL + ApiUtil.ALL_CATEGORIES;
    Map<String,String> headers = {
      'Accept' : 'application/json'
    };
    var response = await http.get(allCategoriesUrl,headers:headers); //data çekildi

    //Category modelinden "categories" List'i oluşturuldu.
    List<Category> categories = [];

    if(response.statusCode == 200){
      Map<String,dynamic> body = jsonDecode(response.body);
      var data  = body['data'];

      for(var item in data){
        Category category = Category.fromJson(item);
        categories.add(category);
      }
    }
    return categories;
  }

  Future<List<Post>> fetchPostsForCategory(String categoryID) async{ 

    String categoryPostsUrl = ApiUtil.categoryPosts(categoryID);
    Map< String, String > headers = {
      'Accept' : 'application/json'
    };
    var response  = await http.get(categoryPostsUrl,headers: headers);

    List<Post> posts = [];

    if(response.statusCode == 200) {
      Map<String,dynamic> body = jsonDecode(response.body.toString());
      var data = body['data'];      
      for(var item in data){
        Post post = Post.fromJson(item);
        posts.add(post);
      }
    }

    return posts;

  }






}