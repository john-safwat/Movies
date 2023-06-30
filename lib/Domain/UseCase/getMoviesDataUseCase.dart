import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class GetMoviesDataUseCase {
  MoviesDataRepository repository;
  GetMoviesDataUseCase(this.repository);

  Future<List<Movies>?> doWork() async{
    var response = await repository.getTopRatedMovies();
    return response;
  }

}