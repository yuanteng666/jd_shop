import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
    int num;

    CartNum(this.num);

    @override
  CartNumState createState() => new CartNumState();
}

class CartNumState extends State<CartNum> {
    int num;
  @override
  Widget build(BuildContext context) {
      ScreenAdapter.init(context);
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
            if(this.num > 1){
                setState(() {
                    this.num--;
                });
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
              setState(() {
                this.num++;
              });
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
          child: Text('${this.num}'),
      );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.num = widget.num;
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