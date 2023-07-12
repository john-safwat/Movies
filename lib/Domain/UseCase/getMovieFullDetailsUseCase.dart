import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/Movie.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class GetMovieFullDetailsUseCase {
  MoviesDataRepository repository ;
  GetMovieFullDetailsUseCase(this.repository);

  Future<Movie> invoke(num? movieId , String uid)async{
    var response = await repository.getMovieFullDetails(movieId.toString());
    var isInWatchHistory = await repository.isInHistory(movieId, uid);
    var isInWishList = await repository.isInWishList(movieId, uid);
    if(isInWatchHistory){
      response.isWatched = true;
    }
    if(isInWishList){
      response.isInWishList = true;
    }
    return response;
  }

}