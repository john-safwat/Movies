import 'package:flutter/material.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';

class DataProvider extends ChangeNotifier {
  var movies;
  var dramaMovies;
  var actionMovies;
  var crimeMovies;
  var animationMovies;

  List<Movies> watchHistory = [];
  List<Movies> wishList = [];
  List<Movies> relatedMovies = [];

  void addMoviesToWatchHistory(Movies movie , bool inWatchHistory){
    if(inWatchHistory){
      watchHistory.removeWhere((element) => element.id == movie.id,);
    }
    watchHistory.insert(0,Movies(
      id: movie.id,
      rating: movie.rating,
      largeCoverImage: movie.largeCoverImage,
      mediumCoverImage: movie.mediumCoverImage
    ));
    notifyListeners();
  }

  void addToWishList(Movies movie){
    wishList.insert(0,Movies(
        id: movie.id,
        rating: movie.rating,
        largeCoverImage: movie.largeCoverImage,
        mediumCoverImage: movie.mediumCoverImage
    ));
    notifyListeners();
  }

  void deleteFromWishList(Movies movie){
    wishList.removeWhere((element) => element.id == movie.id,);
    notifyListeners();
  }
}