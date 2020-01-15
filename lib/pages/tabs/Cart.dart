import 'package:flutter/material.dart';
import 'package:jd_shop/providers/Counter.dart';
import 'package:provider/provider.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/pages/cart/CartItem.dart';
import 'package:jd_shop/providers/Cart.dart';
import 'package:jd_shop/services/CartService.dart';
import 'package:jd_shop/providers/CheckOutProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_shop/services/UserInfoSerive.dart';
class CartPage extends StatefulWidget {
  @override
  CartPageState createState() => new CartPageState();
}

class CartPageState extends State<CartPage> {
  bool isEdit = true;
  CheckOutProvider checkOutProvider;
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var  cartProvider = Provider.of<Cart>(context);
    checkOutProvider = Provider.of<CheckOutProvider>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              setState(() {
                this.isEdit = !this.isEdit;
              });
            },
          )
        ],
      ),
      body: cartProvider.cartList.length > 0
          ? Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Column(
                      children: cartProvider.cartList.map((value) {
                        return CartItem(value);
                      }).toList(),
                    ),
                    SizedBox(
                      height: ScreenAdapter.setHeight(100.0),
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  width: ScreenAdapter.setWidth(750),
                  height: ScreenAdapter.setHeight(88),
                  left: 0,
                  child: Container(
                    width: ScreenAdapter.setWidth(750),
                    height: ScreenAdapter.setHeight(78),
                    decoration: BoxDecoration(
                      color: Colors.white,
                        border: Border(
                            top:
                                BorderSide(width: 1.0, color: Colors.black12))),
                    padding: EdgeInsets.only(right: 10.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: cartProvider.isCheckedAll,
                                  activeColor: Colors.redAccent,
                                  onChanged: (value) {
                                      cartProvider.checkAll(value);
                                  },
                                ),
                                Text('全选'),
                                SizedBox(width: 20.0,),
                                this.isEdit ? Text('总价: '):Text(''),
                                this.isEdit ? Text('${cartProvider.allPrice}',style: TextStyle(color: Colors.redAccent,fontSize: 20.0),):Text('')

                              ],
                            ),
                          ),
                        ),
                        this.isEdit ? Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            child: Text(
                              '结算',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.redAccent,
                            onPressed: (){
                              goCheckOut();
                            },
                          ),
                        ):Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            child: Text(
                              '删除',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.redAccent,
                            onPressed: (){
                                //删除选中数据
                                cartProvider.removeItem();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: Text('购物车空空如也'),
            ),
    );
  }

  goCheckOut() async{
    //获取  购物车数据
    List list = await CartService.getCheckItem();
    //保存到 provider
    this.checkOutProvider.changeCheckOutList(list);
    //判断是否有选中的数据
    if(list.length > 0){
      //判断用户是否登录
      var loginstate = await UserInfoSerive.getUserInfoState();
      if(loginstate){
        Navigator.pushNamed(context, '/checkOut');
      }else{
        Fluttertoast.showToast(
            msg: '你还没有登录，请登录后再结算',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
        Navigator.pushNamed(context, '/login');
      }
    }else{
      Fluttertoast.showToast(
          msg: '请先选中数据',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(CartPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
