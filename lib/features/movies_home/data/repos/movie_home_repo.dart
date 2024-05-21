import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';

import '../model/MovieModel.dart';
import '../model/movie.dart';

abstract class MovieHomeRepo{
  Future<Either<Failure, MovieModel>> fetchMovies(int page);
}