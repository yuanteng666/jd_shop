import 'package:flutter/material.dart';
import 'package:jd_shop/providers/Counter.dart';
import 'package:provider/provider.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/pages/cart/CartItem.dart';
import 'package:jd_shop/providers/Cart.dart';

class CartPage extends StatefulWidget {
  @override
  CartPageState createState() => new CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var cartProvider = Provider.of<Cart>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: null,
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
                                  value: false,
                                  activeColor: Colors.redAccent,
                                  onChanged: (value) {},
                                ),
                                Text('全选')
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            child: Text(
                              '结算',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red,
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
