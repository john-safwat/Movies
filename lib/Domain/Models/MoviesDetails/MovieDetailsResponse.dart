import 'package:mymoviesapp/Domain/Models/MoviesDetails/Movie.dart';


class MovieDetailsResponse {
  MovieDetailsResponse({
      this.status, 
      this.statusMessage,
      this.movie
  });

  String? status;
  String? statusMessage;
  Movie? movie;
}