import 'package:flutter/material.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';

Future<void> showLoadingDialog( BuildContext context  , String message)async{
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: MyTheme.blackOne,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      contentPadding: EdgeInsets.all(40),
      content: Row(
        children: [
          CircularProgressIndicator(color: MyTheme.gold,),
          const SizedBox(width: 20,),
          Text(message , style: Theme.of(context).textTheme.headline5,)
        ],
      ),

    ),
    barrierColor: Colors.black.withOpacity(0.3),
    barrierDismissible: true
  );
}