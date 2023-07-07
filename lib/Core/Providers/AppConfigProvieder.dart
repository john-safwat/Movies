import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {

  String _uid = '';

  void updateUid (String uid)async{
    this._uid = uid;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(uid.isNotEmpty){
      prefs.setString("uid", uid);
    }
    notifyListeners();
  }

  Future<String> getUid()async{
    if(_uid.isEmpty){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _uid = prefs.getString("uid")!;
    }
    return _uid;
  }
}