import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class AddToWishListUseCase {

  MoviesDataRepository repository;
  AddToWishListUseCase(this.repository);

  Future<String> invoke(String uid , num movieId , String midImage, String largeImage , num rating)async{
    var response = await repository.addToWishList(Movies(
        id: movieId,
        largeCoverImage: largeImage,
        mediumCoverImage: midImage,
        rating: rating
    ), uid);

    return response;
  }

}