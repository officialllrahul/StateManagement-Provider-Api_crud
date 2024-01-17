import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'movieDataModel.dart';

class MovieProvider with ChangeNotifier {
  List<Result> _movies = [];
  bool _isLoading = false;

  List<Result> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();
    final url = 'https://api.themoviedb.org/3/tv/top_rated?api_key=0cb8553727794316c0640fab343cfc04&la';
    try {
      final response = await http.get(Uri.parse(url));
      final decodedData = json.decode(response.body);

      final movieData = MovieDataModel.fromJson(decodedData);
      _movies = movieData.results;

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      // Handle error
      print(error);
    }
  }
}
