import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/repositories/movie_repository.dart';

class MovieDetailController {
  final repository = MovieRepository();

  MovieDetailModel movieDetail;
  MovieError movieError;

  bool loading = true;

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    movieError = null;
    final result = await repository.fetchMovieById(id);
    result.fold(
        (error) => movieError = error, (detail) => movieDetail = detail);
    return result;
  }
}
