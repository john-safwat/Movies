import 'package:mymoviesapp/Data/API/ApiManager.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/MovieDetailsResponse.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

import '../../Domain/Models/Movies/MovieResponse.dart';

class MoviesDataRemoteDataSourceImpl implements MoviesDataRemoteDataSource{
  ApiManager apiManager;
  MoviesDataRemoteDataSourceImpl(this.apiManager);

  @override
  Future<MovieResponse> getTopRatedMovies()async {
    var response = await apiManager.getHighRatingMovies();
    return response.toDomain();
  }

  @override
  Future<MovieResponse> getMoviesByGenre(String genre , String page) async{
    var response = await apiManager.getMovieListByGenre(genre , page);
    return response.toDomain();
  }

  @override
  Future<MovieResponse> getBrowseData(String genre  , int pageNumber ) async{
    var response  = await apiManager.getMovieListByGenre(genre, pageNumber.toString());
    return response.toDomain();
  }

  @override
  Future<MovieResponse> getRelatedMoviesData(String movieId) async{
    var response  = await apiManager.getRelatedMovies(movieId);
    return response.toDomain();
  }

  @override
  Future<MovieDetailsResponse> getMovieFullDetails(String movieId) async{
    var response = await apiManager.getMovieFullDetails(movieId);
    return response.toDomain();
  }

}