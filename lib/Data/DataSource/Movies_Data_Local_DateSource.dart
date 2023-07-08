import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class MoviesDataLocalDataSource implements SQLiteDataSource{
  @override
  Future<String> addToHistory(Movies movie, String uid) {
    // TODO: implement addToHistory
    throw UnimplementedError();
  }

  @override
  Future<String> addToWishList(Movies movie, String uid) {
    // TODO: implement addToWishList
    throw UnimplementedError();
  }
  
}