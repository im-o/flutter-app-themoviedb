part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<dynamic>? movies;

  MoviesLoaded({required this.movies});
}

class MoviesLoading extends MoviesState {}
