import 'package:mymoviesapp/Data/API/ApiManager.dart';
import 'package:mymoviesapp/Domain/Exceptions/ServerException.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/MovieDetailsResponse.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

import '../../Domain/Models/Movies/MovieResponse.dart';

class MoviesDataRemoteDataSourceImpl implements MoviesDataRemoteDataSource{
  ApiManager apiManager;
  MoviesDataRemoteDataSourceImpl(this.apiManager);

  @override
  Future<MovieResponse> getTopRatedMovies()async {
    try{
      var response = await apiManager.getHighRatingMovies();
      return response.toDomain();
    }catch (e){
      throw ServerException("Data Couldn't Be Loaded");
    }
  }

  @override
  Future<MovieResponse> getMoviesByGenre(String genre , String page) async{
    try{
      var response = await apiManager.getMovieListByGenre(genre , page);
      return response.toDomain();
    }catch (e){
      throw ServerException("Data Couldn't Be Loaded");
    }
  }

  @override
  Future<MovieResponse> getBrowseData(String genre  , int pageNumber ) async{
    try{
      var response  = await apiManager.getMovieListByGenre(genre, pageNumber.toString());
      return response.toDomain();
    }catch (e){
      throw ServerException("Data Couldn't Be Loaded");
    }

  }

  @override
  Future<MovieResponse> getRelatedMoviesData(String movieId) async{
    try{
      var response  = await apiManager.getRelatedMovies(movieId);
      return response.toDomain();
    }catch (e){
      throw ServerException("Data Couldn't Be Loaded");
    }

  }

  @override
  Future<MovieDetailsResponse> getMovieFullDetails(String movieId) async{
    try{
      var response = await apiManager.getMovieFullDetails(movieId);
      return response.toDomain();
    }catch (e){
      throw ServerException("Data Couldn't Be Loaded");
    }
  }

}