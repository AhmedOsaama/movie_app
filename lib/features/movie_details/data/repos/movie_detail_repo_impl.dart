import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/features/movie_details/data/model/MovieDetails.dart';
import 'package:movie_app/features/movies_home/data/model/MovieModel.dart';
import 'package:movie_app/features/movies_home/data/model/movie.dart';
import 'package:movie_app/features/movies_home/data/repos/movie_home_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/api_service.dart';

class MoviesDetailsRepoImpl {
  final ApiService apiService;

  MoviesDetailsRepoImpl(this.apiService);

  Future<Either<Failure, MovieDetails>> getMovieDetails(int movieId) async {
    try {
      log("MOVIE ID: $movieId");
      var data = await apiService.get(endPoint: "$movieId");
      var movieDetails = MovieDetails.fromJson(data);
      log("MOVIE ID: $movieDetails");
      return Right(movieDetails);
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