import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class AddToHistoryUseCase {
  MoviesDataRepository repository ;
  AddToHistoryUseCase(this.repository);

  Future<String> invoke(String uid , num movieId , String midImage, String largeImage , num rating , bool isWatched)async{
    if (isWatched){
      await repository.deleteFromHistory(movieId, uid);
      print('deleted');
    }
    var response = await repository.addToHistory(Movies(
      id: movieId,
      largeCoverImage: largeImage,
      mediumCoverImage: midImage,
      rating: rating
    ), uid);

    return response;
  }

}