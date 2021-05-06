import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/models/movie_response_model.dart';

import '../core/api.dart';

class MovieRepository {
  final Dio dio = Dio(dioOptions);

  Future<Either<MovieError, MovieResponseModel>> fetchAllMovies(
      int page) async {
    try {
      final response =
          await dio.get('/movie/popular?page=$page&language=pt-BR');
      final model = MovieResponseModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response.data['status_message']));
      } else {
        return Left(MovieRepositoryError(serverError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    try {
      final response = await dio.get('/movie/$id?&language=pt-BR');
      final model = MovieDetailModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response.data['status_message']));
      } else {
        return Left(MovieRepositoryError(serverError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }
}
