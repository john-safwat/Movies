import 'package:mymoviesapp/Data/Models/MovieResponse/MoviesDTO.dart';
import 'package:mymoviesapp/Data/SQL/MySqldb.dart';
import 'package:mymoviesapp/Domain/Exceptions/LocalDatabaseException.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class MoviesDataLocalDataSourceImpl implements MoviesDataLocalDataSource{
  MySqlDB db;
  MoviesDataLocalDataSourceImpl(this.db);

  @override
  Future<String> addToHistory(Movies movie, String uid) async{
    try{
      var response = await db.insertMovieToHistory(movie, uid);
      return response;
    }catch (e){
      throw LocalDatabaseException("Can't Load Data From Local Storage");
    }
  }

  @override
  Future<String> deleteFromHistory(num? id, String uid)async {
    try{
      var response = await db.deleteMovieFromHistory(id, uid);
      return response;
    }catch (e){
      throw LocalDatabaseException("Can't Load Data From Local Storage");
    }
  }

  @override
  Future<bool> isInHistory(num? id, String uid) async{
    try{
      var response = await db.isInWatchHistory(id, uid);
      return response;
    }catch (e){
      throw LocalDatabaseException("Can't Load Data From Local Storage");
    }
  }

  @override
  Future<List<Movies>> getHistory(String uid) async{
    var response = await db.selectWatchHistory(uid);
    if (response != null){
      List<Movies> movies = [];
      response.forEach((e) {

        movies.add(Movies(
          id: num.parse(e['id'].toString()),
          rating: num.parse(e['rating'].toString()) ,
          largeCoverImage: e['medium_cover_image'],
          mediumCoverImage: e['large_cover_image'],
        ));
      });
      return movies;
    }else return [];
  }

  @override
  Future<String> addToWishList(Movies movie, String uid) async{
    try{
      var response = await db.insertMovieToWishList(movie, uid);
      return response;
    }catch (e){
      throw LocalDatabaseException("Can't Load Data From Local Storage");
    }
  }

  @override
  Future<String> deleteFromWishList(num? id, String uid)async {
    try{
      var response = await db.deleteMovieFromWishList(id, uid);
      return response;
    }catch (e){
      throw LocalDatabaseException("Can't Load Data From Local Storage");
    }
  }

  @override
  Future<List<Movies>> getWishList(String uid) async{
    var response = await db.selectWishList(uid);
    if (response != null){
      List<Movies> movies = [];
      response.forEach((e) {
        movies.add(Movies(
          id: num.parse(e['id'].toString()),
          rating: num.parse(e['rating'].toString()) ,
          largeCoverImage: e['medium_cover_image'],
          mediumCoverImage: e['large_cover_image'],
        ));
      });
      return movies;
    }else return [];
  }

  @override
  Future<bool> isInWishList(num? id, String uid) async{
    try{
      var response = await db.isInWishList(id, uid);
      return response;
    }catch (e){
      throw LocalDatabaseException("Can't Load Data From Local Storage");
    }
  }

}