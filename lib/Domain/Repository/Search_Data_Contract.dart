import 'package:mymoviesapp/Domain/Models/Movies/MovieResponse.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';

abstract class SearchDataRemoteDataSource {
  Future<MovieResponse> getMoviesByKeyWord(String keyword);
}
abstract class SearchDataRepository {
  Future<List<Movies>?> getMoviesByKeyWord(String keyword );
}
