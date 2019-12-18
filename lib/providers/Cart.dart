import 'package:flutter/material.dart';
import 'package:jd_shop/utils/Storage.dart';
import 'dart:convert';
import 'package:jd_shop/services/CartService.dart';

class Cart with ChangeNotifier{
    List _cartList = [];


    Cart(){
        this.init();
    }

    init() async{
        try{
            List cartListData = json.decode(await Storage.getString('cartList'));
            this._cartList = cartListData;
        }catch(e){
            this._cartList =[];
        }
        notifyListeners();
    }

    List get cartList => _cartList;
    int get cartNum => _cartList.length;
    addCartList(value){
        _cartList.add(value);
        notifyListeners();
    }

    updateProvider(){
        this.init();
    }
}