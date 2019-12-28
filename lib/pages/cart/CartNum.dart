import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/providers/Cart.dart';
import 'package:provider/provider.dart';

class CartNum extends StatefulWidget {
    //这个地方是引用传递，如果直接传值 num 的话不会影响到provider的数量值，比较麻烦
  Map itemData;

  CartNum(this.itemData);

  @override
  CartNumState createState() => new CartNumState();
}

class CartNumState extends State<CartNum> {
    Map _itemData;
    var provider;
  @override
  Widget build(BuildContext context) {

      ScreenAdapter.init(context);
      this._itemData = widget.itemData;

      provider = Provider.of<Cart>(context);
    return new Container(
        width: ScreenAdapter.setWidth(150),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0,color: Colors.black12),
            borderRadius: BorderRadius.circular(3.0)
        ),
        child: Row(
            children: <Widget>[
                _leftWidget(),
                _centerWidget(),
                _rightWidget()
            ],
        ),
    );
  }

  Widget _leftWidget(){
      return InkWell(
          child:Container(
              width: ScreenAdapter.setWidth(48.0),
              height: ScreenAdapter.setHeight(40.0),
              alignment: Alignment.center,
              child: Text('-'),
          ),
          onTap: (){
              //有了provider不用 setstate也能改变数据
              if(this._itemData['count'] > 1){
                  this._itemData['count']--;
                  provider.changeItemCount();
              }

          },
      );
  }

  Widget _rightWidget(){
      return InkWell(
          child:Container(
              width: ScreenAdapter.setWidth(48.0),
              height: ScreenAdapter.setHeight(40.0),
              alignment: Alignment.center,
              child: Text('+'),
          ),
          onTap: (){
              this._itemData['count']++;
              provider.changeItemCount();
          },
      );
  }

  Widget _centerWidget(){
      return Container(
          width: ScreenAdapter.setWidth(50.0),
          height: ScreenAdapter.setHeight(40.0),
          decoration: BoxDecoration(
              border:Border(left: BorderSide(width: 1.0,color: Colors.black12),
              right: BorderSide(width: 1.0,color: Colors.black12))
          ),
          alignment: Alignment.center,
          child: Text('${this._itemData['count']}'),
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
  void didUpdateWidget(CartNum oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}