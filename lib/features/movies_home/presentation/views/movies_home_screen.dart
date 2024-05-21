import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_home/presentation/views/widgets/movies_home_screen_body.dart';

class MoviesHomeScreen extends StatelessWidget {
  const MoviesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: MoviesHomeScreenBody(),
    );
  }
}
