import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'jsonPhotoProvider.dart';

class JsonPhotosApis extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json Album Api'),
      ),
      body: Consumer<JsonPhotosProvider>(
        builder: (context, postProvider, _) {
          // Fetch posts when the widget is built
          postProvider.fetchPosts();
          return ListView.builder(
            itemCount: postProvider.posts.length,
            itemBuilder: (context, index) {
              var post = postProvider.posts[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(post.title.toString()),
                  subtitle: SizedBox(
                    width: 50,
                    height: 100,
                    child: Image.network(
                      post.url ?? '', // Use post.url, add a default value if null
                      fit: BoxFit.cover,
                    ),
                  ),
                  leading: SizedBox(
                    width: 50,
                    child: Image.network(
                      post.thumbnailUrl ?? '', // Use post.url, add a default value if null
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}