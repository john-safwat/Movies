import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class GetMoviesByGenreToBrowseUseCase {
  MoviesDataRepository repository;
  GetMoviesByGenreToBrowseUseCase(this.repository);

  Future<List<Movies>?> getMoviesToBrowse(String genre , int pageNumber)async{

    var response  = await repository.getBrowseData(genre, pageNumber);

    return response;
  }

}