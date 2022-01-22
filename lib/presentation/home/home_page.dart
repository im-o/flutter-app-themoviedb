import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:themoviedb/cubit/movies_cubit.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/presentation/home/movie_list_item.dart';

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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                children:
                    movies!.map((movie) => _movie(movie, context)).toList(),
              ),
            ),
          );
        }
        return Container(child: Text("Data is empty!"));
      },
    );
  }

  Widget _movie(Movie movie, BuildContext context) {
    return MovieListItem(
      movie: movie,
      onTapFunction: () {
        log("MOVIES : ${movie.title}");
      },
    );
  }
}
