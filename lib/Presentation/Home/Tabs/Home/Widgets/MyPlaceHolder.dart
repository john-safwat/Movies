import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';

// placeholder to show until the data be loaded

class MyPlaceHolder extends StatelessWidget {
  List<int> placeholders = [1,1,1,1,1,1,1,1,];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              PlaceHolderContainer(
                  height: MediaQuery.of(context).size.height *0.9,
                  width: MediaQuery.of(context).size.width
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      items: placeholders.map((movie) => Image.asset('assets/images/loading.jpg')).toList(),
                      options: CarouselOptions(
                        height:300,
                        viewportFraction: 0.5,
                        initialPage: 0,
                        autoPlayInterval: const Duration(seconds: 1),
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        enlargeFactor: 0.32,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PlaceHolderContainer extends StatelessWidget {
  double height ;
  double width ;
  PlaceHolderContainer({
    required this.height,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
        gradient:const LinearGradient(
          colors: [
            MyTheme.gold,
            MyTheme.backGroundColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}


