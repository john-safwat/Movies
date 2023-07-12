import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class DeleteFromWishListUseCase {

  MoviesDataRepository repository;
  DeleteFromWishListUseCase(this.repository);

  Future<String> invoke(String uid , num movieId )async{
    var response = await repository.deleteFromWishList(movieId, uid);
    return response;
  }


}