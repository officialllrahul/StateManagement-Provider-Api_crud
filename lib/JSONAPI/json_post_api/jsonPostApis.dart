import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/JSONAPI/json_post_api/jsonPostProvider.dart';
import 'package:statemanagementflutter/JSONAPI/json_post_api/postDataModel.dart';


class JsonPostApis extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider Example'),
      ),
      body: Consumer<JsonPostProvider>(
        builder: (context, postProvider, _) {
          // Fetch posts when the widget is built
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
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: bodyController,
                      decoration: const InputDecoration(labelText: 'Body'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // Create a new post and add it using the provider
                        final newPost = Post(
                          userId: 1, // Replace with your desired user ID
                          id: 0,
                          title: titleController.text,
                          body: bodyController.text,
                        );
                        await postProvider.createPost(newPost);

                        // Clear the input fields after creating the post
                        titleController.clear();
                        bodyController.clear();
                      },
                      child: Text('Add Post'),
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
                      title: Text(post.title),
                      subtitle: Text(post.body),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              postProvider.deletePost(post.id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              // Display a dialog with text fields for updating the post
                              titleController.text = post.title;
                              bodyController.text = post.body;
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Update Post'),
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                              labelText: 'Title'),
                                        ),
                                        TextField(
                                          controller: bodyController,
                                          decoration: InputDecoration(
                                              labelText: 'Body'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Update the post using the provider
                                          final updatedPost = Post(
                                            userId: post.userId,
                                            id: post.id,
                                            title: titleController.text,
                                            body: bodyController.text,
                                          );
                                          postProvider.updatePost(updatedPost);

                                          // Close the dialog
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update'),
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
