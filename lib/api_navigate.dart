import 'package:flutter/material.dart';
import 'package:statemanagementflutter/JSONAPI/json_album_api/jsonAlbumApis.dart';
import 'package:statemanagementflutter/JSONAPI/json_comment_api/jsonCommentApis.dart';
import 'package:statemanagementflutter/JSONAPI/json_photos_api/jsonPhotosApis.dart';
import 'package:statemanagementflutter/JSONAPI/json_post_api/jsonPostApis.dart';
import 'package:statemanagementflutter/JSONAPI/json_todos_api/jsonTodoApis.dart';
import 'package:statemanagementflutter/JSONAPI/json_users_api/jsonUsersApis.dart';

class apiNavigatePage extends StatefulWidget {
  const apiNavigatePage({super.key});

  @override
  State<apiNavigatePage> createState() => _apiNavigatePageState();
}

class _apiNavigatePageState extends State<apiNavigatePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JsonPostApis()),
              );
            }, child: const Text("Json Post Api")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => jsonCommentApis()),
              );
            }, child: const Text("Json Comment Api")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => jsonAlbumApis()),
              );
            }, child: const Text("Json Album Api")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JsonPhotosApis()),
              );
            }, child: const Text("Json Photo Api")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JsonTodoApis()),
              );
            }, child: const Text("Json Todo Api")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserListWidget()),
              );
            }, child: const Text("Json User Api")),
          ],
        ),
      ),
    );
  }
}
