class PostImage {

  String image_id, image_description, image_url,is_featured,post_id;

  PostImage(this.image_id, this.image_description, this.image_url,
      this.is_featured, this.post_id);


  PostImage.fromJson(Map<String,dynamic> jsonObject){
    this.image_id = jsonObject['image_id'].toString();
    this.image_description = jsonObject['image_description'].toString();
    this.image_url = jsonObject['image_url'].toString();
    this.is_featured = jsonObject['is_featured'].toString();
    this.post_id = jsonObject['post_id'].toString();
  }

}

