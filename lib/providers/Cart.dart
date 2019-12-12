import 'package:flutter/material.dart';

class Cart with ChangeNotifier{
    List _cartList = [];

    List get cartList => _cartList;
    int get cartNum => _cartList.length;
    addCartList(value){
        _cartList.add(value);
        notifyListeners();
    }
}