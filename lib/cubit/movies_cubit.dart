import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/data/repositories/movie_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository movieRepository;

  MoviesCubit({required this.movieRepository}) : super(MoviesInitial());

  void fetchMovies() {
    emit(MoviesLoading());
    movieRepository.fetchMovies().then((movies) {
      emit(MoviesLoaded(movies: movies));
    });
  }

  void searchMovies(String query) {
    emit(MoviesLoading());
    movieRepository.searchMovies(query).then((movies) {
      emit(MoviesLoaded(movies: movies));
    });
  }
}
