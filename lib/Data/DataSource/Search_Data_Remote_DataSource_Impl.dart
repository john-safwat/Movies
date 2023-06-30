import 'package:mymoviesapp/Data/API/ApiManager.dart';
import 'package:mymoviesapp/Domain/Models/Movies/MovieResponse.dart';
import 'package:mymoviesapp/Domain/Repository/Search_Data_Contract.dart';

class SearchDataRemoteDataSourceImpl implements SearchDataRemoteDataSource {
  ApiManager apiManager ;
  SearchDataRemoteDataSourceImpl (this.apiManager);

  @override
  Future<MovieResponse> getMoviesByKeyWord(String keyword) async{
    var response = await apiManager.gatSearchResults(keyword);
    return response.toDomain();
  }

}