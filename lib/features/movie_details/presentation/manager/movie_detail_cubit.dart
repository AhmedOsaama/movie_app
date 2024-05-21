import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie_details/data/repos/movie_detail_repo_impl.dart';
import 'package:movie_app/features/movie_details/presentation/manager/movie_detail_state.dart';
import 'package:movie_app/features/movies_home/data/repos/movie_home_repo.dart';
import 'package:movie_app/features/movies_home/presentation/manager/movies_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailState> {
  final MoviesDetailsRepoImpl moviesDetailsRepoImpl;
  MovieDetailsCubit(this.moviesDetailsRepoImpl) : super(MovieDetailInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailLoading());
    var result = await moviesDetailsRepoImpl.getMovieDetails(movieId);
    result.fold(
            (failure) => emit(MovieDetailFailure(failure.errorMessage)),
            (details) => emit(MovieDetailSuccess(details))
    );
  }
}
