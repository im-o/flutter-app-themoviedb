import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/cubit/movies_cubit.dart';
import 'package:themoviedb/data/models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoviesCubit>(context).fetchMovies();
    return Scaffold(
      appBar: AppBar(title: Text("TheMovieDB")),
      body: Center(child: _homePageBody()),
    );
  }

  Widget _homePageBody() {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is MoviesLoading) return CircularProgressIndicator();
        if (state is MoviesLoaded) {
          final movies = (state).movies;
          return Column(
            children: movies!.map((movie) => _movie(movie, context)).toList(),
          );
        }
        return Container();
      },
    );
  }

  Widget _movie(Movie movie, BuildContext context) {
    log("MOVIES : ${movie.title}");
    return Container();
  }
}
