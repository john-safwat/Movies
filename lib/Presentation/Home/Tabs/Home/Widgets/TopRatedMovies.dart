import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/PosterImage.dart';

class TopRatedMovies extends StatefulWidget {
  List<Movies> movies;
  Function goToDetailsScreen ;
  TopRatedMovies({required this.movies , required this.goToDetailsScreen});
  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  String image = '';
  @override
  void initState() {
    super.initState();
    image = widget.movies[0].largeCoverImage!;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/loading.jpg',),
        // image to show in the background it the same image of the poster
        CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Image.network(image),
          width: MediaQuery.of(context).size.width,
          placeholder: (context, url) =>  Image.asset('assets/images/loading.jpg',),
          errorWidget: (context, url, error) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/error.png'),
          ),
        ),
        // gradient layer above the image
        Positioned.fill(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: double.infinity,//MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyTheme.backGroundColor.withOpacity(1),
                  MyTheme.backGroundColor.withOpacity(0.5),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )
            ),
          ),
        ),
        // the poster list (the slider)
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Available Now.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              CarouselSlider(
                items: widget.movies.map((movie) => PosterImage(movie: movie , goToDetailsScreen: widget.goToDetailsScreen,)).toList(),
                options: CarouselOptions(
                  height:300,
                  viewportFraction: 0.5,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {image = widget.movies[index].largeCoverImage!;});
                  },
                  autoPlayInterval: const Duration(seconds: 1),
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  enlargeFactor: 0.32,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Image.asset(
                'assets/images/Watch Now.png',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ],
          ),
        )
      ]
    );
  }
}
