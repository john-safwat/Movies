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
      var response = await db.deleteMovieToHistory(id, uid);
      return response;
    }catch (e){
      throw LocalDatabaseException("Can't Load Data From Local Storage");
    }
  }

  @override
  Future<bool> isInHistory(num? id, String uid) async{
    try{
      var response = await db.isInHistory(id, uid);
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

        num id = num.parse(e['id'].toString());
        num rating = num.parse(e['rating'].toString());
        String mid = e['large_cover_image'];
        String large = e['medium_cover_image'];
        movies.add(Movies(
          id: id,
          rating: rating ,
          largeCoverImage: large,
          mediumCoverImage: mid,
        ));
      });
      return movies;
    }else return [];
  }

}