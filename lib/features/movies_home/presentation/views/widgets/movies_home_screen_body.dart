import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/hive_helper.dart';
import 'package:movie_app/features/movie_details/presentation/views/movies_detail_screen.dart';
import 'package:movie_app/features/movies_home/data/repos/movie_home_repo_impl.dart';
import 'package:movie_app/features/movies_home/presentation/manager/movies_state.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/model/MovieModel.dart';
import '../../../data/model/movie.dart';
import '../../manager/movies_cubit.dart';

class MoviesHomeScreenBody extends StatelessWidget {
  MoviesHomeScreenBody({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => MoviesCubit(getIt.get<MoviesHomeRepoImpl>())..fetchMovies(1),
      child: BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
        if (state is MoviesSuccess) {
          final DataTableSource data = MyData(data: state.movies, context: context);
          log("Internet: ${state.movies.results!.length}");
          return SingleChildScrollView(
            child: PaginatedDataTable(
                onPageChanged: (page) {
                  BlocProvider.of<MoviesCubit>(context).fetchMovies(state.movies.page!.toInt() + 1);
                },
                dataRowHeight: 70,
                columns: const [
                  DataColumn(label: Text("Image")),
                  DataColumn(label: Text("Title")),
                  DataColumn(label: Text("Release Date")),
                  DataColumn(label: Text("Page")),
                ],
                source: data),
          );
        }
        if(state is MoviesCacheSuccess){
          final DataTableSource data = MyData(data: state.movies, context: context);
          log("Cache: ${state.movies.results!.length}");
          return SingleChildScrollView(
            child: PaginatedDataTable(
                onPageChanged: (page) {
                  // BlocProvider.of<MoviesCubit>(context).fetchMovies(state.movies.page!.toInt() + 1);
                },
                dataRowHeight: 70,
                columns: const [
                  DataColumn(label: Text("Image")),
                  DataColumn(label: Text("Title")),
                  DataColumn(label: Text("Release Date")),
                  DataColumn(label: Text("Page")),
                ],
                source: data),
          );
        }
        if (state is MoviesFailure) {
          return Text(state.failure);
        }
        if(state is MoviesLoading){
          BlocProvider.of<MoviesCubit>(context).fetchMoviesFromDB();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      }),
    );
  }
}

class MyData extends DataTableSource {
  final MovieModel data;
  final BuildContext context;

  MyData({required this.data, required this.context});

  @override
  DataRow? getRow(int index) {
    List<Movie> movies = data.results!;
    log(index.toString());
    if(index >= movies.length){
      return null;
    }else{
    var imageUrl = 'https://image.tmdb.org/t/p/original${movies[index].posterPath}';
      return DataRow(cells: [
        DataCell(Image.network(
          imageUrl,
          width: 150,
          fit: BoxFit.cover,
        )),
        DataCell(SizedBox(width: 130, child: Text(movies[index].title!))),
        DataCell(Text(movies[index].releaseDate!)),
        DataCell(onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => MovieDetailScreen(movieName: movies[index].title!, movieId: movies[index].id!.toInt())));
        }, const Icon(Icons.arrow_forward_ios_outlined)),
      ]);
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.totalResults!.toInt();

  @override
  int get selectedRowCount => 0;
}
