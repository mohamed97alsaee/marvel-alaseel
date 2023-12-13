import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  List<MovieModel> movies = [];
  bool isLoading = true;
  bool isFailed = false;

  fetchMovied() async {
    isLoading = true;
    notifyListeners();
    final response =
        await http.get(Uri.parse("https://mcuapi.herokuapp.com/api/v1/movies"));

    if (kDebugMode) {
      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");
    }

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body)['data'];

      movies.addAll(decodedData
          .map<MovieModel>((movie) => MovieModel.fromJson(movie))
          .toList());
      notifyListeners();
    } else {
      isFailed = true;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }
}
