

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class Global {

  storeLoggedInID(int accountId) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('accountId', accountId);
  }
  storeLoggedInName(String name) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userName', name);
  }

  Future<int?> getLoggedInStatus() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id =  preferences.getInt('accountId')??null;
    return id;
  }

  Future<String?> getLoggedInName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? name =  preferences.getString('userName')??null;

    return name;
  }

}