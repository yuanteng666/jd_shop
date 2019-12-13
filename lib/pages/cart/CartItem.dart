import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'CartNum.dart';
class CartItem extends StatefulWidget {
  @override
  CartItemState createState() => new CartItemState();
}

class CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

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
              onChanged: (value) {},
              value: false,
            ),
          ),
          Container(
            height: ScreenAdapter.setWidth(160),
            child: Image.network(
              'http://jd.itying.com/public/upload/E8jnbcercoZGdllR3r9QN5aD.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '三国魏黄初5年（公元224年）置范阳国，黄初7年（226年）涿郡（今河北涿州，范阳两字开始与涿州结合）改名为范阳郡，辖今北京昌平区、房山区及河北涿州一带。',
                    maxLines: 2,
                  ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥100",style: TextStyle(color: Colors.red),),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(),
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
