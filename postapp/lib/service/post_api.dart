import 'dart:convert';

import 'package:postapp/model/api_error.dart';
import 'package:postapp/model/post.dart';
import 'package:http/http.dart' as http;


class PostApi {

  static const baseUrl="https://jsonplaceholder.typicode.com";
  Future<List<Post>> fetchPosts ()async{
    final response= await http.get(Uri.parse("$baseUrl/posts"));
 if(response.statusCode!=200){
  throw ApiError("Failed to fetch posts");
 }
 var jsonlist =jsonDecode(response.body);
 return Post.listFromJson(jsonlist);
  }
}