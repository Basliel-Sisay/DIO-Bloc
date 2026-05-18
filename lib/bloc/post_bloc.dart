import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_event.dart';
import 'post_state.dart';
import '../services/post_service.dart';
import '../models/post.dart';

class PostBloc extends Bloc<PostEvent, PostState>{
  final PostService _postService = PostService();
  List<Post> _cachedPosts = [];
  PostBloc() : super(PostInitialState()){
    on<LoadPostsEvent>(_onLoadPosts);
    on<CreatePostEvent>(_onAddPost);
    on<UpdatePostEvent>(_onModifyPost);
    on<DeletePostEvent>(_onTerminatePost);
  }

  Future<void> _onLoadPosts(LoadPostsEvent event, Emitter<PostState> emit) async{
    emit(PostLoadingState());
    _cachedPosts = await _postService.getAllPosts();
    emit(PostSuccessState(posts: List.from(_cachedPosts)));
  }

  Future<void> _onAddPost(CreatePostEvent event, Emitter<PostState> emit) async{
    emit(PostLoadingState());
    Post payload = Post(title: event.title, body: event.body);
    Post result = await _postService.createPost(payload);
    if(result.id != null){
      _cachedPosts.insert(0, result);
      emit(PostSuccessState(posts: List.from(_cachedPosts)));
    } 
    else{
      emit(PostErrorState(message: 'failed to properly initialize creation'));
    }
  }

  Future<void> _onModifyPost(UpdatePostEvent event, Emitter<PostState> emit) async{
    emit(PostLoadingState());
    if(event.post.id == 101){
      int index = _cachedPosts.indexWhere((element) => element.id == event.post.id && element.title == event.post.title);
      if(index != -1){
        _cachedPosts[index] = event.post;
        emit(PostSuccessState(posts: List.from(_cachedPosts)));
      } 
      else{
        emit(PostErrorState(message: 'The target mock entry tracking failed'));
      }
    } 
    else{
      Post serverResult = await _postService.updatePost(event.post);
      int index = _cachedPosts.indexWhere((element) => element.id == event.post.id);
      if(index != -1){
        _cachedPosts[index] = serverResult;
        emit(PostSuccessState(posts: List.from(_cachedPosts)));
      } 
      else{
        emit(PostErrorState(message: 'The target server entry index is missing'));
      }
    }
  }

  Future<void> _onTerminatePost(DeletePostEvent event, Emitter<PostState> emit) async{
    if(event.post.id == 101){
      _cachedPosts.removeWhere((element){
        if(element.id == event.post.id && element.title == event.post.title){
          return true;
        } 
        else{
          return false;
        }
      });
      emit(PostSuccessState(posts: List.from(_cachedPosts)));
    } 
    else{
      bool backendConf = await _postService.deletePost(event.post.id!);
      if(backendConf == true){
        _cachedPosts.removeWhere((element) => element.id == event.post.id);
        emit(PostSuccessState(posts: List.from(_cachedPosts)));
      } 
      else{
        emit(PostErrorState(message: 'failed to remove remote data object'));
      }
    }
  }
}