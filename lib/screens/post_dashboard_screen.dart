import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import 'post_comp_screen.dart';

class PostDashboardScreen extends StatefulWidget{
  const PostDashboardScreen({super.key});

  @override
  State<PostDashboardScreen> createState() => _PostDashboardScreenState();
}

class _PostDashboardScreenState extends State<PostDashboardScreen> {
  @override
  void initState(){
    super.initState();
    BlocProvider.of<PostBloc>(context).add(LoadPostsEvent());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post App'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state){
          if(state is PostLoadingState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } 
          else if(state is PostErrorState){
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } 
          else if(state is PostSuccessState){
            if(state.posts.isEmpty){
              return const Center(
                child: Text('No posts found, you can add one'),
              );
            } 
            else{
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return Card(
                    margin: const EdgeInsets.only(
                      left:12,
                      right:12,
                      top:8,
                      bottom:8,
                      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            post.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            post.body,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16, 
                            right: 16.0, 
                            bottom: 12.0
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 248, 168, 47),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(90, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PostFormerScreen(post: post),
                                    ),
                                  );
                                },
                                child: const Text('Update'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(90, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: (){
                                  BlocProvider.of<PostBloc>(context).add(DeletePostEvent(post: post));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Post is deleted successfully')),
                                  );
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          } 
          else{
            return const Center(child: Text('Can you please wait for a moment....'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostFormerScreen(),
            ),
          );
        },
      ),
    );
  }
}