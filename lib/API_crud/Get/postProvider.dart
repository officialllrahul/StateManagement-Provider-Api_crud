import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ApiGetDataModel.dart';
import 'GetProvider.dart';

class ApiGetPage extends StatefulWidget {
  const ApiGetPage({Key? key}) : super(key: key);

  @override
  State<ApiGetPage> createState() => _ApiGetPageState();
}

class _ApiGetPageState extends State<ApiGetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaceholder Posts'),
      ),
      body: Consumer<PostProvider>( // Change this line to use GetProvider
        builder: (context, postProvider, _) {
          return FutureBuilder<List<Post>>(
            future: postProvider.fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
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
