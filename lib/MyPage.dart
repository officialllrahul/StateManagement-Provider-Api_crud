import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// Model class representing the data fetched from the API
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => PostProvider(), // Creating the FutureProvider
        child: MyHomePage(),
      ),
    );
  }
}

class PostProvider extends ChangeNotifier {
  Future<List<Post>> fetchPosts() async {
    try {
      // note for api calling we need to keep in mind that what is the request and what is the response and also method
      //for get method
      var response = await http.get(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"),
          headers: {});

      // for post api (if you have data to pass the value in body then use (body: {}), and if you have to pass headers then pass headers in (headers: {}) . we can both also )
      var postResponse = await http.post(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"),
          body: {},
          headers: {});

      // for patch api (if you have data to pass the value in body then use (body: {}), and if you have to pass headers then pass headers in (headers: {}) . we can both also )
      var patchResponse = await http.patch(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"),
          body: {},
          headers: {});

      // for delete api (if you have data to pass the value in body then use (body: {}), and if you have to pass headers then pass headers in (headers: {}) . we can both also )
      var deleteResponse = await http.delete(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"),
          body: {},
          headers: {});

      // for put api (if you have data to pass the value in body then use (body: {}), and if you have to pass headers then pass headers in (headers: {}) . we can both also )
      var putResponse = await http.put(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"),
          body: {},
          headers: {});
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Post> posts = jsonData.map((json) => Post.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureProvider Example'),
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, _) {
          return FutureBuilder<List<Post>>(
            future: postProvider
                .fetchPosts(), // Calling the fetchPosts function from the provider
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].body),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
