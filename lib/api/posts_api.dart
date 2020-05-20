import 'dart:convert';

import 'api_util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_projects/models/post.dart';

class PostsApi {

  Future<List<Post>> fetchRecentPosts() async {

    String postsUrl = ApiUtil.MAIN_API_URL + ApiUtil.RECENT_POSTS;
    Map<String, String> headers = {
      'Accept' : 'application/json'
    };
    var response = await http.get(postsUrl, headers: headers);

    List<Post> posts = [];
    if(response.statusCode == 200){
      var body = jsonDecode(response.body.toString()); 
      var data =  body['data']; 
      for(var item in data) { 
        Post post = Post.fromJson(item);
        posts.add(post);
      } 
    } 
    
    return posts;

  }






}