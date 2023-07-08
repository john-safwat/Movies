import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/Movie.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/MovieDetailsResponse.dart';

import '../Models/Movies/MovieResponse.dart';

abstract class MoviesDataRemoteDataSource {
  Future<MovieResponse> getTopRatedMovies ();
  Future<MovieResponse> getMoviesByGenre(String genre , String page);
  Future<MovieResponse> getBrowseData(String genre , int pageNumber);
  Future<MovieResponse> getRelatedMoviesData(String movieId);
  Future<MovieDetailsResponse> getMovieFullDetails(String movieId);
}

abstract class MoviesDataRepository{
  Future<List<Movies>?> getTopRatedMovies();
  Future<List<Movies>?> getMoviesByGenre(String genre ,  String page);
  Future<List<Movies>?> getBrowseData(String genre , int pageNumber);
  Future<List<Movies>?> getRelatedMoviesData(String movieId);
  Future<Movie> getMovieFullDetails(String movieId);
  Future<String> addToWishList(Movies movie , String uid);
  Future<String> addToHistory(Movies movie , String uid);
}

abstract class MoviesDataLocalDataSource{
  Future<String> addToWishList(Movies movie , String uid);
  Future<String> addToHistory(Movies movie , String uid);
}