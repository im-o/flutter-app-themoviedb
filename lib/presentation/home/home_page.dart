import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("TheMovieDB")),
      body: Stack(
        fit: StackFit.loose,
        children: [
          _homePageBody(),
          _floatingSearchBar(),
        ],
      ),
    );
  }

  Widget _homePageBody() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        child: BlocConsumer<MoviesCubit, MoviesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MoviesLoading) return CircularProgressIndicator();
            if (state is MoviesLoaded) {
              final movies = (state).movies;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
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
        ),
      ),
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

  Widget _floatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      backgroundColor: Theme.of(context).primaryColor,
      hint: 'Search movie...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : MediaQuery.of(context).size.width,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        if (query.isNotEmpty) {
          BlocProvider.of<MoviesCubit>(context).searchMovies(query);
        } else {
          BlocProvider.of<MoviesCubit>(context).fetchMovies();
        }
      },
      clearQueryOnClose: false,
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: true,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect();
      },
    );
  }
}
