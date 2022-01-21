import 'package:flutter/material.dart';
import 'package:themoviedb/data/models/movie.dart';

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
      margin: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movie.title.toString()),
          ],
        ),
        onTap: () {
          onTapFunction();
        },
      ),
    );
  }
}
