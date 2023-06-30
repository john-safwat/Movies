import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';

class MovieResponse {
  MovieResponse({
      this.status, 
      this.statusMessage, 
      this.movies,
  });

  String? status;
  String? statusMessage;
  List<Movies>? movies;
}