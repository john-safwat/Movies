import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/Movie.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class MoviesDataRepositoryImpl implements MoviesDataRepository {
  MoviesDataRemoteDataSource remoteDataSource ;
  MoviesDataLocalDataSource sqLiteDataSource;
  MoviesDataRepositoryImpl(this.remoteDataSource ,  this.sqLiteDataSource);

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

  @override
  Future<String> addToHistory(Movies movie, String uid) async{
    var response= await sqLiteDataSource.addToHistory(movie, uid);
    return response;
  }

  @override
  Future<String> deleteFromHistory(num? id, String uid) async{
    var response = await sqLiteDataSource.deleteFromHistory(id, uid);
    return response;
  }

  @override
  Future<bool> isInHistory(num? id, String uid) async{
    var response = await sqLiteDataSource.isInHistory(id, uid);
    return response;
  }

  @override
  Future<List<Movies>> getHistory(String uid) async{
    var response = await sqLiteDataSource.getHistory(uid);
    return response;
  }
}