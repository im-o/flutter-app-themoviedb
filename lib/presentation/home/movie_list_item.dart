import 'package:flutter/material.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/presentation/home/movie_image.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final Function onTapFunction;

  const MovieListItem({
    Key? key,
    required this.movie,
    required this.onTapFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        child: MovieImage(movie: movie),
        onTap: () {
          onTapFunction();
        },
      ),
    );
  }
}
