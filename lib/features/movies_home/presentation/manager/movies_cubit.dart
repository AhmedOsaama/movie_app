import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_home/data/repos/movie_home_repo.dart';
import 'package:movie_app/features/movies_home/presentation/manager/movies_state.dart';

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
}
