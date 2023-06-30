import 'package:dio/dio.dart';
import 'package:mymoviesapp/Data/Models/MovieDetailsResponse/MovieDetailsResponseDTO.dart';
import 'package:mymoviesapp/Data/Models/MovieResponse/MovieResponseDTO.dart';

class ApiManager {
  static ApiManager? _instance ;
  ApiManager._();

  static ApiManager getApiManager(){
    _instance ??= ApiManager._();
    return _instance!;
  }

  String baseUrl = 'yts.mx';

  var dio = Dio();

  Future<MovieResponseDTO> getHighRatingMovies()async{
    Uri url = Uri.https(
      baseUrl ,
      '/api/v2/list_movies.json',
      {
        "limit" : "50",
        'sort_by' : 'year' ,
        'genre' : 'SCI-FI '
      }
    );
    var response =await dio.get(url.toString());
    return MovieResponseDTO.fromJson(response.data);
  }

  Future<MovieResponseDTO> getMovieListByGenre( String genre , String page)async{
    Uri url = Uri.https(
        baseUrl ,
        '/api/v2/list_movies.json',
        {
          "limit" : "50",
          'sort_by' : 'rating-year' ,
          'genre' : genre,
          'page' : page,
        }
    );
    var response =await dio.get(url.toString());
    return MovieResponseDTO.fromJson(response.data);
  }

  Future<MovieResponseDTO> gatSearchResults(String keyword)async{
    Uri url = Uri.https(
        baseUrl ,
        '/api/v2/list_movies.json',
        {
          'query_term' : keyword,
          'sort_by' : "rating"
        }
    );
    var response =await dio.get(url.toString());
    return MovieResponseDTO.fromJson(response.data);
  }

  Future<MovieResponseDTO> getRelatedMovies(String movieId) async{
    Uri url = Uri.https(
        baseUrl ,
        '/api/v2/movie_suggestions.json',
        {
          'movie_id' : movieId,
        }
    );
    var response = await dio.get(url.toString());
    return MovieResponseDTO.fromJson(response.data);
  }
  Future<MovieDetailsResponseDTO> getMovieFullDetails(String movieId) async{
    Uri url = Uri.https(
        baseUrl ,
        '/api/v2/movie_details.json',
        {
          'movie_id' : movieId,
          "with_images" : "true",
          "with_cast" : "true",
        }
    );
    var response = await dio.get(url.toString());
    return MovieDetailsResponseDTO.fromJson(response.data);
  }
}
