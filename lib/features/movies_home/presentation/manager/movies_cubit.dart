import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/core/utils/hive_helper.dart';
import 'package:movie_app/features/movies_home/data/repos/movie_home_repo.dart';
import 'package:movie_app/features/movies_home/presentation/manager/movies_state.dart';

import '../../data/model/MovieModel.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieHomeRepo movieHomeRepo;
  MoviesCubit(this.movieHomeRepo) : super(MoviesInitial());

  Future<void> fetchMovies(int page) async {
    emit(MoviesLoading());
    var result = await movieHomeRepo.fetchMovies(page);
    result.fold(
            (failure) => emit(MoviesFailure(failure.errorMessage)),
            (movies) => emit(MoviesSuccess(movies))
    );
  }

  Future<void> fetchMoviesFromDB() async {
    var cachedResult = await HiveHelper.getMoviesList();
    if(cachedResult.isNotEmpty) {
      var movies = MovieModel.fromJson(cachedResult);
      emit(MoviesCacheSuccess(movies));
    }
  }
}
