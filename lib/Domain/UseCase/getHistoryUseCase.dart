import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class GetHistoryUseCase {
  MoviesDataRepository repository;
  GetHistoryUseCase(this.repository);

  Future<List<Movies>> invoke(String uid)async{
    var response = await repository.getHistory(uid);
    List<Movies> movies  = [];
    for(int i= response.length-1 ; i >=0 ; i--){
      movies.add(response[i]);
    }
    return movies;
  }
}