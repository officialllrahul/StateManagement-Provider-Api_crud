// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// // Model class representing the data fetched from the API
// class Post {
//   final int userId;
//   final int id;
//   final String title;
//   final String body;
//
//   Post({
//     required this.userId,
//     required this.id,
//     required this.title,
//     required this.body,
//   });
//
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       userId: json['userId'] ?? 0,
//       id: json['id'] ?? 0,
//       title: json['title'] ?? '',
//       body: json['body'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'id': id,
//       'title': title,
//       'body': body,
//     };
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChangeNotifierProvider(
//         create: (_) => PostProvider(),
//         child: MyHomePage(),
//       ),
//     );
//   }
// }
//
// class PostProvider extends ChangeNotifier {
//   List<Post> _posts = [];
//
//   List<Post> get posts => _posts;
//
//   // Method for POST request
//   Future<Post> createPost(Post post) async {
//     try {
//       var postResponse = await http.post(
//         Uri.parse("https://jsonplaceholder.typicode.com/posts"),
//         body: jsonEncode(post.toJson()),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (postResponse.statusCode == 201) {
//         final newPost = Post.fromJson(jsonDecode(postResponse.body));
//         _posts.add(newPost); // Add the new post to the list
//         notifyListeners(); // Notify listeners about the change
//         return newPost;
//       } else {
//         throw Exception('Failed to create post');
//       }
//     } catch (e) {
//       throw Exception('Failed to create post: $e');
//     }
//   }
//
//   // Method for DELETE request
//   Future<void> deletePost(int postId) async {
//     try {
//       var deleteResponse = await http.delete(
//         Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId"),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (deleteResponse.statusCode == 200) {
//         // Post successfully deleted
//         _posts.removeWhere(
//             (post) => post.id == postId); // Remove the post from the list
//         notifyListeners(); // Notify listeners about the change
//       } else {
//         throw Exception('Failed to delete post');
//       }
//     } catch (e) {
//       throw Exception('Failed to delete post: $e');
//     }
//   }
//
//   // Method for PUT request
//   Future<Post> updatePost(Post post) async {
//     try {
//       var putResponse = await http.put(
//         Uri.parse("https://jsonplaceholder.typicode.com/posts/${post.id}"),
//         body: jsonEncode(post.toJson()),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (putResponse.statusCode == 200) {
//         final replacedPost = Post.fromJson(jsonDecode(putResponse.body));
//         _posts[_posts.indexWhere((p) => p.id == replacedPost.id)] =
//             replacedPost; // Update the post in the list
//         notifyListeners(); // Notify listeners about the change
//         return replacedPost;
//       } else {
//         throw Exception('Failed to replace post');
//       }
//     } catch (e) {
//       throw Exception('Failed to replace post: $e');
//     }
//   }
// }
//
// // ...
//
// class MyHomePage extends StatelessWidget {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController bodyController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FutureProvider Example'),
//       ),
//       body: Consumer<PostProvider>(
//         builder: (context, postProvider, _) {
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Create a new post:',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     TextField(
//                       controller: titleController,
//                       decoration: const InputDecoration(labelText: 'Title'),
//                     ),
//                     TextField(
//                       controller: bodyController,
//                       decoration: InputDecoration(labelText: 'Body'),
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () async {
//                         // Create a new post and add it using the provider
//                         final newPost = Post(
//                           userId: 1, // Replace with your desired user ID
//                           id: 0,
//                           title: titleController.text,
//                           body: bodyController.text,
//                         );
//                         await postProvider.createPost(newPost);
//
//                         // Clear the input fields after creating the post
//                         titleController.clear();
//                         bodyController.clear();
//                       },
//                       child: Text('Add Post'),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: postProvider.posts.length,
//                   itemBuilder: (context, index) {
//                     final post = postProvider.posts[index];
//                     return ListTile(
//                       title: Text(post.title),
//                       subtitle: Text(post.body),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () {
//                               postProvider.deletePost(post.id);
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.edit),
//                             onPressed: () async {
//                               // Display a dialog with text fields for updating the post
//                               titleController.text = post.title;
//                               bodyController.text = post.body;
//                               await showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: Text('Update Post'),
//                                     content: Column(
//                                       children: [
//                                         TextField(
//                                           controller: titleController,
//                                           decoration: InputDecoration(
//                                               labelText: 'Title'),
//                                         ),
//                                         TextField(
//                                           controller: bodyController,
//                                           decoration: InputDecoration(
//                                               labelText: 'Body'),
//                                         ),
//                                       ],
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text('Cancel'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           // Update the post using the provider
//                                           final updatedPost = Post(
//                                             userId: post.userId,
//                                             id: post.id,
//                                             title: titleController.text,
//                                             body: bodyController.text,
//                                           );
//                                           postProvider.updatePost(updatedPost);
//
//                                           // Close the dialog
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text('Update'),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
