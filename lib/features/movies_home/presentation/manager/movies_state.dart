
import '../../data/model/MovieModel.dart';
import '../../data/model/movie.dart';

abstract class MoviesState{
  const MoviesState();
}

class MoviesInitial extends MoviesState{}
class MoviesLoading extends MoviesState{}
class MoviesFailure extends MoviesState{
  final String failure;

  MoviesFailure(this.failure);
}
class MoviesSuccess extends MoviesState{
  final MovieModel movies;

  MoviesSuccess(this.movies);
}