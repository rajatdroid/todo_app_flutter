import 'package:flutter/cupertino.dart';

abstract class SharedPrefRepo{

  void saveToPrefs(String json);

  String getFromPrefs();



}