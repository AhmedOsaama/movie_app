
import '../../data/model/MovieDetails.dart';

abstract class MovieDetailState{
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState{}
class MovieDetailLoading extends MovieDetailState{}
class MovieDetailFailure extends MovieDetailState{
  final String failure;

  MovieDetailFailure(this.failure);
}
class MovieDetailSuccess extends MovieDetailState{
  final MovieDetails details;

  MovieDetailSuccess(this.details);
}