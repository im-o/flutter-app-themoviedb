import 'package:flutter/material.dart';
import 'package:themoviedb/data/models/movie.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.title.toString())),
      body: _movieDetail(),
    );
  }

  Widget _movieDetail() {
    return Container(
      child: Center(
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
