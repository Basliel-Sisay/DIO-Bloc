import 'package:dio/dio.dart';
import '../setup/dio_receive.dart';
import '../models/post.dart';

class PostService {
  final Service _dioService = Service();

  Future<List<Post>> getAllPosts() async {
    final response = await _dioService.dio.get('/posts');
    if(response.statusCode == 200){
      List<dynamic> rawData = response.data;
      return rawData.map((dynamic posts) => Post.fromJson(posts)).toList();
    } 
    else{
      throw Exception('The server returned error status code: ${response.statusCode}');
    }
  }
  Future<Post> createPost(Post post) async{
    final response = await _dioService.dio.post(
      '/posts',
      data: post.toJson(),
    );
    if(response.statusCode == 201){
      return Post.fromJson(response.data);
    } 
    else{
      throw Exception('Failed execution on post creation');
    }
  }

  Future<Post> updatePost(Post post) async{
    final response = await _dioService.dio.put(
      '/posts/${post.id}',
      data: post.toJson(),
    );
    if(response.statusCode == 200){
      return Post.fromJson(response.data);
    } 
    else{
      throw Exception('Failed execution on post update');
    }
  }
  Future<bool> deletePost(int id) async{
    final response = await _dioService.dio.delete('/posts/$id');
    if(response.statusCode == 200){
      return true;
    } 
    else{
      return false;
    }
  }
}