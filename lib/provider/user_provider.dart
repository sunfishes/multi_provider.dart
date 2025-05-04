import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'sojeong';
  int _age = 24;

  String get name => _name;
  int get age => _age;

  void updateName(String newName){
    _name = newName;
    notifyListeners();
  }
  void updateAge(int newAge){
    _age = newAge;
    notifyListeners();
  }
}