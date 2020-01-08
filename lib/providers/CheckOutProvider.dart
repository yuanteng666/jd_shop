import 'package:flutter/material.dart';


class CheckOutProvider with ChangeNotifier{
    List _checkOutList = [];
    List get checkOutList => _checkOutList;

    changeCheckOutList(List data){
        _checkOutList = data;
    }
}