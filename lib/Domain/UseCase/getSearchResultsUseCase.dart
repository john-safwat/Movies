import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Search_Data_Contract.dart';

class GetSearchResultsUseCase {
  SearchDataRepository repository ;
  GetSearchResultsUseCase(this.repository);

  // function to call the repo and get the search results
  Future<List<Movies>?> getSearchResults( String keyword) async{
    var response = await repository.getMoviesByKeyWord(keyword);
    return response;
  }

}