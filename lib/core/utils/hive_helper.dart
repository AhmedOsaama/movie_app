import 'dart:convert';
import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper{

  static const moviesBox = "MoviesBox";
  static const moviesListKey = "moviesListKey";

  static const movieDetailBox = "MovieDetailBox";

  static Future<void> saveMoviesList(Map json) async {
    try{
    var encodedMovies = jsonEncode(json);
    await Hive.box(moviesBox).clear();
    await Hive.box(moviesBox).put(moviesListKey, encodedMovies);
    }catch(e){
      log("Couldn't save movies List: $e");
    }
  }

  static Future<Map> getMoviesList() async {
    try {
      var moviesMap = jsonDecode(await Hive.box(moviesBox).get(moviesListKey));
      return moviesMap;
    }catch(e){
      log("Couldn't get movies List: $e");
      return {};
    }
  }

}

