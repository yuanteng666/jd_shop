import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/pages/cart/CartNum.dart';
import 'package:provider/provider.dart';
import 'package:jd_shop/providers/Cart.dart';
class CartItem extends StatefulWidget {
  Map _data;

  CartItem(this._data);

  @override
  CartItemState createState() => new CartItemState();
}

class CartItemState extends State<CartItem> {
  Map _itemData;
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this._itemData = widget._data;

    var cartProvider = Provider.of<Cart>(context);
    return Container(
      height: ScreenAdapter.setHeight(200),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.black12)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: ScreenAdapter.setHeight(80),
            child: Checkbox(
              activeColor: Colors.redAccent,
              onChanged: (value) {
                setState(() {
                  _itemData['checked'] = !_itemData['checked'];
                });
                cartProvider.itemCheckedChange();
              },
              value: _itemData['checked'],
            ),
          ),
          Container(
            height: ScreenAdapter.setWidth(160),
            child: Image.network(
              '${_itemData['pic']}',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${_itemData['title']}',
                    maxLines: 2,
                  ),
                  Text(
                    '${_itemData['selectedAttr']}',
                    maxLines: 1,
                  ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${_itemData['price']}",style: TextStyle(color: Colors.red),),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(_itemData),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(CartItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
