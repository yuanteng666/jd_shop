import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/Search.dart';
import '../pages/ProductList.dart';
import '../pages/ProductContent.dart';
import '../pages/tabs/Cart.dart';
import '../pages/Login.dart';
import '../pages/registers/RegisterFirstPage.dart';
import '../pages/registers/RegisterSecondPage.dart';
import '../pages/registers/RegisterThridPage.dart';
import '../pages/CheckOut.dart';
import '../pages/address/AddressAdd.dart';
import '../pages/address/AddressEdit.dart';
import '../pages/address/AddressList.dart';

//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/search':(context) => Search(),
  '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
  '/ProductContent': (context,{arguments}) => ProductContent(arguments:arguments),
  '/cart': (context,) => CartPage(),
  '/login':(context,) => Login(),
  '/registerfirst':(context,) => RegisterFirstPage(),
  '/registersecond':(context,{arguments}) => RegisterSecondPage(arguments: arguments,),
  '/registerthrid':(context,{arguments}) => RegisterThridPage(arguments: arguments,),
  '/checkOut':(context,) => CheckOutPage(),
  '/addressAdd':(context,) => AddressAdd(),
  '/addressEdit':(context,) => AddressEdit(),
  '/addressList':(context,) => AddressList(),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
