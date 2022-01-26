import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:themoviedb/cubit/movies_cubit.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/presentation/detail_movie/movie_detail_page.dart';
import 'package:themoviedb/presentation/home/movie_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _formController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoviesCubit>(context).fetchMovies();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          _searchCustom(),
          Expanded(child: _homePageBody()),
        ],
      ),
    );
  }

  Widget _homePageBody() {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is! MoviesLoaded)
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        final movies = (state).movies;
        return movies!.length > 0
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: StaggeredGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    children:
                        movies.map((movie) => _movie(movie, context)).toList(),
                  ),
                ),
              )
            : Center(child: Container(child: Text("Data is empty!")));
      },
    );
  }

  Widget _movie(Movie movie, BuildContext context) {
    return MovieListItem(
      movie: movie,
      onTapFunction: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MovieDetailPage(movie: movie),
        ));
      },
    );
  }

  Widget _searchCustom() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.search),
            title: TextField(
              controller: _formController,
              decoration: InputDecoration(
                hintText: 'Search movie...',
                border: InputBorder.none,
              ),
              onChanged: onSearchTextChanged,
            ),
            trailing: IconButton(
              icon: Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _formController.clear();
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String query) {
    if (query.isNotEmpty || query != "") {
      BlocProvider.of<MoviesCubit>(context).searchMovies(query);
    } else {
      BlocProvider.of<MoviesCubit>(context).fetchMovies();
    }
  }
}
