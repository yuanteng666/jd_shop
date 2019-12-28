import 'package:flutter/material.dart';
import 'package:jd_shop/utils/Storage.dart';
import 'dart:convert';
import 'package:jd_shop/services/CartService.dart';

class Cart with ChangeNotifier{
    List _cartList = [];
    bool _isSelectAll = false;
    //总价
    double _allPrice = 0;

    Cart(){
        this.init();
    }

    init() async{
        try{
            List cartListData = json.decode(await Storage.getString('cartList'));
            this._cartList = cartListData;
            _isSelectAll = this.isCheckAll();
            //计算总价
            this._calcAllPrice();
        }catch(e){
            this._cartList =[];
        }
        notifyListeners();
    }

    List get cartList => _cartList;
    bool get isCheckedAll => _isSelectAll;
    double get allPrice => _allPrice;

    int get cartNum => _cartList.length;
    addCartList(value){
        _cartList.add(value);
        //计算总价
        this._calcAllPrice();
        notifyListeners();
    }

    //有新的商品加入购物车后先保存到缓存，然后跟新下provider 的list从而更新视图
    updateProvider(){
        this.init();
    }

    //当购物车数量变化 需要更新下缓存数据
    changeItemCount() async{
       await Storage.setString('cartList', json.encode(this._cartList));
       //计算总价
       this._calcAllPrice();
       //更新provider 通知
       notifyListeners();
    }
    //全选、反选
    checkAll(val) async{
        for(var i = 0;i < _cartList.length; i++){
            _cartList[i]['checked'] = val;
        }
        await Storage.setString('cartList', json.encode(this._cartList));
        _isSelectAll = val;
        //计算总价
        this._calcAllPrice();
        //更新provider 通知
        notifyListeners();
    }
    //计算总价
    _calcAllPrice(){
        double tempPrice = 0;
        for(var i = 0; i < this._cartList.length ;i++){
            if(this._cartList[i]['checked'] == true){
                tempPrice += this._cartList[i]['price'] * this._cartList[i]['count'];
            }
        }
        this._allPrice = tempPrice;
        notifyListeners();
    }

    bool isCheckAll(){
        if(_cartList.length > 0){
            //只要任意一个 未选中 就不是全选
            for(var i = 0; i < this._cartList.length ;i++){
                if(this._cartList[i]['checked'] == false){
                    return false;
                }
            }
            return true;

        }else{
            return false;
        }
    }

    itemCheckedChange() async{
        this._isSelectAll = isCheckAll();
        await Storage.setString('cartList', json.encode(this._cartList));
        //计算总价
        this._calcAllPrice();
        //更新provider 通知
        notifyListeners();
    }

    //删除数据
    removeItem(){
        List tempList = [];

        for(var i = 0; i < this._cartList.length ;i++){
            if(this._cartList[i]['checked'] == false){
                tempList.add(this._cartList[i]);
            }
        }
        this._cartList = tempList;
        this.changeItemCount();
    }
}