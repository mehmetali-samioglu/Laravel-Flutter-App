import 'package:flutter/material.dart';
import 'package:flutter_projects/api/categories_api.dart';
import 'package:flutter_projects/models/category.dart';
import 'screens/category_posts.dart';
import 'screens/home_screen.dart';
import 'screens/categories_list.dart';

void main(){

  runApp(FlutterLaravelApp());

}

class FlutterLaravelApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.tealAccent, 
      ),
      home: HomeScreen(), 
      routes: {
        '/home' : ( BuildContext context ) => HomeScreen(),
        '/categories' : ( BuildContext context ) =>  CategoriesList(),
      },     
    );
  }

}
  