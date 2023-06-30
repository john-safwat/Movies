import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/Movie.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class MoviesDataRepositoryImpl implements MoviesDataRepository {
  MoviesDataRemoteDataSource remoteDataSource ;
  MoviesDataRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movies>?> getTopRatedMovies() async{
    var response =await  remoteDataSource.getTopRatedMovies();
    return response.movies;
  }

  @override
  Future<List<Movies>?> getMoviesByGenre(String genre ,  String page) async{
    var response = await remoteDataSource.getMoviesByGenre(genre ,page);
    return response.movies;
  }

  @override
  Future<List<Movies>> getBrowseData(String genre, int pageNumber) async{
    var response = await remoteDataSource.getBrowseData(genre, pageNumber);
    return response.movies!;
  }

  @override
  Future<List<Movies>?> getRelatedMoviesData(String movieId) async{
    var response = await remoteDataSource.getRelatedMoviesData(movieId);
    return response.movies;
  }

  @override
  Future<Movie> getMovieFullDetails(String movieId) async{
    var response = await remoteDataSource.getMovieFullDetails(movieId);
    return response.movie!;
  }
}