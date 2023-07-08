import 'package:mymoviesapp/Data/SQL/MySqldb.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class MoviesDataLocalDataSourceImpl implements MoviesDataLocalDataSource{
  MySqlDB db;
  MoviesDataLocalDataSourceImpl(this.db);

  @override
  Future<String> addToHistory(Movies movie, String uid) {
    db.insertData("INSERT INTO 'History' ('uid', 'id', 'medium_cover_image', 'large_cover_image' ,'rating') VALUES (  );")
  }

  @override
  Future<String> addToWishList(Movies movie, String uid) {
    // TODO: implement addToWishList
    throw UnimplementedError();
  }
  
}