import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
    int _count = 1;

    get count => _count;
    increamCount(){
        _count++;
        notifyListeners();
    }
}