import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/JSONAPI/json_album_api/jsonAlbumDataModel.dart';
import 'package:statemanagementflutter/JSONAPI/json_album_api/jsonAlbumProvider.dart';
import 'package:statemanagementflutter/JSONAPI/json_comment_api/jsonCommentDataModel.dart';

class jsonAlbumApis extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json Album Api'),
      ),
      body: Consumer<JsonAlbumProvider>(
        builder: (context, postProvider, _) {
          postProvider.fetchPosts();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a new post:',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final newPost = Album(
                          userId: 1,
                          id: 0,
                          title: titleController.text,
                        );
                        await postProvider.createPost(newPost);
                        titleController.clear();
                      },
                      child: const Text('Add Post'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: postProvider.posts.length,
                  itemBuilder: (context, index) {
                    final post = postProvider.posts[index];
                    return ListTile(
                      title: Text(
                        post.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors
                              .black, // Replace with your desired text color
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              postProvider.deletePost(post.id);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              titleController.text = post.title;
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Update Post'),
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller: titleController,
                                          decoration: const InputDecoration(
                                              labelText: 'Title'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Update the post using the provider
                                          final updatedPost = Album(
                                            userId: post.userId,
                                            id: post.id,
                                            title: titleController.text,
                                          );
                                          postProvider.updatePost(updatedPost);

                                          // Close the dialog
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
