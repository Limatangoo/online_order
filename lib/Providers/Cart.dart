

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier, DiagnosticableTreeMixin { 
     final List _items = [];

  void count(){
    int count = _items.length;
    notifyListeners();
  }
    


  void add(item) {
    _items.add(item);
    notifyListeners();
  }
  

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

}