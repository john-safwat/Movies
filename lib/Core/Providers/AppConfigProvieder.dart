import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {

  String uid = '';

  void updateUid (String uid)async{
    this.uid = uid;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(uid.isNotEmpty){
      prefs.setString("uid", uid);
    }
    print(uid);
    notifyListeners();
  }

}