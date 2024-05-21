import 'package:flutter/material.dart';
import 'package:movie_app/features/movie_details/presentation/views/widgets/movies_detail_screen_body.dart';
import 'package:movie_app/features/movies_home/presentation/views/widgets/movies_home_screen_body.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieName;
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieName, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieName),
      ),
      body: MovieDetailScreenBody(movieId: movieId,),
    );
  }
}
