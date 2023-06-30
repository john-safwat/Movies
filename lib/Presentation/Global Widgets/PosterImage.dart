import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';

class PosterImage extends StatelessWidget {
  Movies movie;
  Function goToDetailsScreen;
  PosterImage({required this.movie, required this.goToDetailsScreen});

  @override
  Widget build(BuildContext context) {
    // show the image and handel the waiting state and error state
    return InkWell(
      onTap: () {
        goToDetailsScreen(movie);
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: movie.mediumCoverImage!,
            imageBuilder: (context, imageProvider) => Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(movie.mediumCoverImage!),
              ),
            ]),
            placeholder: (context, url) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/loading.jpg'),
            ),
            errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/error.png'),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyTheme.backGroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        movie.rating.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(width: 5,),
                      const Icon(
                        EvaIcons.star,
                        color: MyTheme.gold,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
