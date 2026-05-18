import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/post.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';

class PostFormerScreen extends StatefulWidget{
  final Post? post;
  const PostFormerScreen({super.key, this.post});

  @override
  State<PostFormerScreen> createState() => _PostFormerScreenState();
}

class _PostFormerScreenState extends State<PostFormerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if(widget.post != null){
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    } 
    else{}
  }

  @override
  void dispose(){
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    bool isEditing = false;
    
    if(widget.post != null){
      isEditing = true;
    } 
    else{
      isEditing = false;
    }
    String appBarTitleText = '';
    String submitButtonText = '';
    if(isEditing == true){
      appBarTitleText = 'Edit Post';
      submitButtonText = 'Update Post';
    } 
    else{
      appBarTitleText = 'Create Post';
      submitButtonText = 'Save Post';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitleText),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please enter a title';
                  } 
                  else{
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Body Content',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please enter some content';
                  } 
                  else{
                    return null;
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    if(isEditing == true){
                      Post updatedPost = Post(
                        id: widget.post!.id,
                        title: _titleController.text,
                        body: _bodyController.text,
                      );
                      BlocProvider.of<PostBloc>(context).add(UpdatePostEvent(
                        originalPost: widget.post!,
                        updatedPost: updatedPost,
                      ));
                    } 
                    else{
                      BlocProvider.of<PostBloc>(context).add(CreatePostEvent(
                        title: _titleController.text,
                        body: _bodyController.text,
                      ));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  submitButtonText,
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 16
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}