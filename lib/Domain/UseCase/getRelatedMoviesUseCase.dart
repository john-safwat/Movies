import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class GetRelatedMoviesUseCase {
  MoviesDataRepository repository;
  GetRelatedMoviesUseCase(this.repository);

  Future<List<Movies>?> invoke(String movieId)async{
    var response = await repository.getRelatedMoviesData(movieId);
    return response;
  }
}