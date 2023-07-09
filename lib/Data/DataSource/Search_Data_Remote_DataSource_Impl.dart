import 'package:mymoviesapp/Data/API/ApiManager.dart';
import 'package:mymoviesapp/Domain/Exceptions/ServerException.dart';
import 'package:mymoviesapp/Domain/Models/Movies/MovieResponse.dart';
import 'package:mymoviesapp/Domain/Repository/Search_Data_Contract.dart';

class SearchDataRemoteDataSourceImpl implements SearchDataRemoteDataSource {
  ApiManager apiManager ;
  SearchDataRemoteDataSourceImpl (this.apiManager);

  @override
  Future<MovieResponse> getMoviesByKeyWord(String keyword) async{
    try{
      var response = await apiManager.gatSearchResults(keyword);
      return response.toDomain();
    }catch (e){
      throw ServerException("Data Couldn't Be Loaded");
    }
  }

}