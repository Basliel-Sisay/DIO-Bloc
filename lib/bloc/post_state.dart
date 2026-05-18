import '../models/post.dart';

abstract class PostState {}
class PostInitialState extends PostState{}
class PostLoadingState extends PostState{}
class PostSuccessState extends PostState{
  final List<Post> posts;
  PostSuccessState({required this.posts});
}
class PostErrorState extends PostState{
  final String message;
  PostErrorState({required this.message});
}