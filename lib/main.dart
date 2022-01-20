import 'package:flutter/material.dart';
import 'package:themoviedb/app.dart';
import 'package:themoviedb/data/repositories/movie_repository.dart';
import 'package:themoviedb/data/services/api_client.dart';
import 'package:themoviedb/data/services/providers/movie_providers.dart';

void main() {
  runApp(App(
    movieRepository: MovieRepository(MovieProviders(ApiClient())),
  ));
}
