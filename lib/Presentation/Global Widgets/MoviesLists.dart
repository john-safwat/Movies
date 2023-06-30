import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/PosterImage.dart';

class Movieslist extends StatelessWidget {
  List<Movies> movies;
  String type;
  Function goToDetailsScreen ;
  Movieslist({required this.movies , required this.type , required this.goToDetailsScreen});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // the title of the genre
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
            child: Text(
              type,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline3
            ),
          ),
          // the movies
          CarouselSlider(
            items: movies.map((movie) => PosterImage(movie: movie , goToDetailsScreen: goToDetailsScreen)).toList(),
            options: CarouselOptions(
              height: 220,
              viewportFraction: 0.32,
              disableCenter: true,
              initialPage: 1,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              autoPlay: false,
              enlargeFactor: 0.32,
              scrollDirection: Axis.horizontal,
              reverse: true,
              animateToClosest: true,
            ),
          )
        ],
      ),
    );
  }
}

