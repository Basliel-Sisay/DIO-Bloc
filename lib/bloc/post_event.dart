import '../models/post.dart';

abstract class PostEvent{}

class LoadPostsEvent extends PostEvent{}

class CreatePostEvent extends PostEvent{
  final String title;
  final String body;
  CreatePostEvent({required this.title, required this.body});
}
class UpdatePostEvent extends PostEvent{
  final Post post;
  UpdatePostEvent({required this.post});
}
class DeletePostEvent extends PostEvent{
  final Post post;
  DeletePostEvent({required this.post});
}