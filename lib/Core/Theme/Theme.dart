import 'package:flutter/material.dart';

class MyTheme {

  static const backGroundColor =  Color(0xff121312);
  static const blackOne =  Color(0xff282A28);
  static const blackTwo =  Color(0xff1A1A1A);
  static const blackThree =  Color(0xff1D1E1D);
  static const blackFour =  Color(0xff343534);
  static const gray =  Color(0xffC6C6C6);
  static const gold =  Color(0xffFFBB3B);
  static const white =  Color(0xffFFFFFF);
  static const green =  Color(0xff57AA53);
  static const red =  Color(0xffE82626);


  static ThemeData theme =  ThemeData(
    scaffoldBackgroundColor: backGroundColor,
    canvasColor: blackTwo,
    primaryColor: gold,

    fontFamily: "Cairo",
    appBarTheme:const AppBarTheme(
      backgroundColor: blackThree,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        )
      ),
      elevation: 2
    ),

    hoverColor: MyTheme.gold,
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: gold,
      unselectedItemColor: gray,
      selectedIconTheme: IconThemeData(size: 26),
      unselectedIconTheme: IconThemeData(size: 22)
    ),

    textTheme: const TextTheme(
      headline1: TextStyle(
        color: MyTheme.white,
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),
      headline2: TextStyle(
          color: MyTheme.gray,
          fontWeight: FontWeight.bold,
          fontSize: 24
      ),
      headline3: TextStyle(
          color: MyTheme.white,
          fontWeight: FontWeight.bold,
          fontSize: 22
      ),
      headline4: TextStyle(
          color: MyTheme.gray,
          fontWeight: FontWeight.bold,
          fontSize: 22
      ),
      headline5: TextStyle(
          color: MyTheme.white,
          fontSize: 18
      ),
      headline6: TextStyle(
          color: MyTheme.gray,
          fontSize: 18
      ),
    )
  );

}