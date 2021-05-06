import 'package:dio/dio.dart';

const url = 'https://api.themoviedb.org/3';
const apiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiM2ZmMjVkOTBjNmM0MGM3ZDhlMDljZTY2MDA5OWVlMCIsInN1YiI6IjYwODc3MWNlYjZhYmM0MDAyOThhOWY1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.u2Ai6uFoPUg961GQ6Oc1EsMdSEoGYgPyqfxr8Wt_HGs';

const serverError = 'Falha ao conectar com o servidor!';
final dioOptions = BaseOptions(
    baseUrl: url,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType: 'application/json;charset=utf-8',
    headers: {'Authorization': 'Bearer $apiKey'});
