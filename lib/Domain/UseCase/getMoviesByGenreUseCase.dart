import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';

class GetMoviesByGenreUseCase{
  MoviesDataRepository repository ;
  GetMoviesByGenreUseCase(this.repository);

  Future<List<Movies>?> doWork(String genre)async{
    List<Movies> movies = [];

    // make the api call for three pages

    var response  = await Future.wait([
      repository.getBrowseData(genre, 0),
      repository.getBrowseData(genre, 1),
      repository.getBrowseData(genre, 2),
    ]);

    for (int i = 0 ; i<3 ; i++){
      for(int j = 0 ; j<response[i]!.length ;j++){
        movies.add(response[i]![j]);
      }
    }
    // filter the movies to remove the trash objects
    for (int i =0 ; i< movies.length ; i++){
      if (movies[i].rating == 0 || movies[i].rating == null){
        movies.remove(movies[i]);
      }
    }
    return movies;
  }
}