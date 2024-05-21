import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/service_locator.dart';
import 'package:movie_app/features/movie_details/presentation/manager/movie_detail_cubit.dart';
import 'package:movie_app/features/movie_details/presentation/manager/movie_detail_state.dart';

import '../../../data/repos/movie_detail_repo_impl.dart';

class MovieDetailScreenBody extends StatelessWidget {
  final int movieId;
  const MovieDetailScreenBody({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => MovieDetailsCubit(getIt.get<MoviesDetailsRepoImpl>())..getMovieDetails(movieId),
      child: BlocBuilder<MovieDetailsCubit, MovieDetailState>(
        builder: (context, state) {
          if(state is MovieDetailSuccess){
            var imageUrl = 'https://image.tmdb.org/t/p/original${state.details.posterPath}';
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: Image.network(imageUrl)),
                    const SizedBox(
                      height: 43,
                    ),
                    Text(
                      state.details.title!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Opacity(
                      opacity: .7,
                      child: Text(
                        state.details.overview!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: state.details.genres!.map((genre) => Text(genre.name! + " ")).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Rating:"),
                    SizedBox(height: 5,),
                    Text(
                      state.details.voteAverage.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is MovieDetailFailure) {
            return Text(state.failure);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }
}
