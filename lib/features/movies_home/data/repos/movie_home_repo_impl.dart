import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/utils/hive_helper.dart';
import 'package:movie_app/features/movies_home/data/model/MovieModel.dart';
import 'package:movie_app/features/movies_home/data/model/movie.dart';
import 'package:movie_app/features/movies_home/data/repos/movie_home_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/api_service.dart';

class MoviesHomeRepoImpl implements MovieHomeRepo {
  final ApiService apiService;

  MoviesHomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, MovieModel>> fetchMovies(int page) async {
    try {
      var data = await apiService.get(endPoint: "popular?page=$page");
      var movieModel = MovieModel.fromJson(data);
      // for (var item in movieModel.results!) {
      //   try {
      //     movies.add(Movie.fromJson(item));
      //   } catch (e) {
      //     movies.add(Movie.fromJson(item));
      //   }
      // }
      await HiveHelper.saveMoviesList(data);
      return Right(movieModel);
    } catch (e) {
      if (e is DioException) {
        log(e.response.toString());
        log(e.requestOptions.toString());
        log(e.message.toString());
        return Left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}