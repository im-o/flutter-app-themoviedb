import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/cubit/movies_cubit.dart';
import 'package:themoviedb/data/repositories/movie_repository.dart';
import 'package:themoviedb/presentation/home/home_page.dart';

class App extends StatelessWidget {
  final MovieRepository movieRepository;

  const App({Key? key, required this.movieRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => MoviesCubit(movieRepository: movieRepository),
        child: HomePage(),
      ),
    );
  }
}
