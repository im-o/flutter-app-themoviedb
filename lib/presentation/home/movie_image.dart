import 'package:flutter/material.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/utils/util_constants.dart';

class MovieImage extends StatelessWidget {
  final Movie movie;

  const MovieImage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: movie.posterPath == null
              ? Icon(Icons.movie)
              : Image.network(
                  imagePath + movie.posterPath!,
                  fit: BoxFit.fitWidth,
                ),
        ),
      ],
    );
  }
}
