import 'package:jd_shop/utils/Storage.dart';
import 'dart:convert';
import 'package:jd_shop/config/Config.dart';


class CartService {
  static addCart (item) async{
    item = formatItem(item);
    print(item);
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      //判断购物车有没有当前数据
      bool hasData=cartListData.any((value){
          return value['_id']==item['_id']&&value['selectedAttr']==item['selectedAttr'];
      });

      if(hasData){
          for(var i=0;i<cartListData.length;i++){
              if(cartListData[i]['_id']==item['_id']&&cartListData[i]['selectedAttr']==item['selectedAttr']){

                  cartListData[i]["count"]=cartListData[i]["count"]+1;
              }
          }
          await Storage.setString('cartList', json.encode(cartListData));

      }else{
          cartListData.add(item);
          await Storage.setString('cartList', json.encode(cartListData));
      }
    } catch (e) {
      //第一次存储，没有数据，会报异常，所以这样处理
      List list = List();
      list.add(item);
      //保存数据
      await Storage.setString('cartList', json.encode(list));
    }
  }

  static formatItem(item) {
      String pic = item.pic;
      pic = Config.DOMAIN + pic.replaceAll("\\", "/");
    final Map data = new Map<String, dynamic>();

    data['_id'] = item.sId;
    data['title'] = item.title;
    if(item.price is int || item.price is double){
        data['price'] = item.price;
    }else{
        data['price'] = double.parse(item.price);
    }
    data['selectedAttr'] = item.selectAttr;
    data['count'] = item.count;
    data['pic'] = pic;
    //是否选中
    data['checked'] = true;
    return data;
  }

  static  getCheckItem() async{
    List cartData ;
    List checkData = [] ;
    try{
        cartData = json.decode(await Storage.getString('cartList'));
        for(var i = 0; i < cartData.length ;i++){
            if(cartData[i]['checked'] == true){
                checkData.add(cartData[i]);
            }
        }
    }catch(e){
        cartData = [];
    }
    return checkData;
  }
}
