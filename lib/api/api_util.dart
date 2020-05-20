class ApiUtil {

  static const String MAIN_API_URL = 'http://192.168.1.110:82/api/';

  static const String ALL_CATEGORIES = 'categories';

  static const String RECENT_POSTS = 'posts';
 
 
  static String  categoryPosts( String categoryID){
    return MAIN_API_URL + ALL_CATEGORIES + '/' + categoryID + '/posts';
  }



}