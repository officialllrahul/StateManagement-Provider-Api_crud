import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movieProvider.dart';

class MovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
      ),
      body: movieProvider.isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: movieProvider.movies.length,
        itemBuilder: (context, index) {
          final movie = movieProvider.movies[index];
          return ListTile(
            title: Text(movie.name),
            subtitle: Text(movie.overview),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger the fetchMovies method when the FAB is pressed
          movieProvider.fetchMovies();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
