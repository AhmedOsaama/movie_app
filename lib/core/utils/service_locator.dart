import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/features/movie_details/data/repos/movie_detail_repo_impl.dart';
import '../../features/movies_home/data/repos/movie_home_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<MoviesHomeRepoImpl>(MoviesHomeRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<MoviesDetailsRepoImpl>(MoviesDetailsRepoImpl(getIt.get<ApiService>()));
}
