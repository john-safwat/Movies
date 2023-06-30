import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/Movie.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class GetMovieFullDetailsUseCase {
  MoviesDataRepository repository ;
  GetMovieFullDetailsUseCase(this.repository);

  Future<Movie> invoke(String movieId)async{
    var response = await repository.getMovieFullDetails(movieId);
    return response;
  }

}