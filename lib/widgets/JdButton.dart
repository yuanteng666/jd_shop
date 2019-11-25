import 'package:flutter/material.dart';
import '../utils/ScreenAdapter.dart';

class JdButton extends StatelessWidget {

    final  Color color;
    final  String text;
    final  Object callBack;

    JdButton({Key key,this.color=Colors.black, this.text="按钮", this.callBack=null}):super(key : key);

    @override
  Widget build(BuildContext context) {
      ScreenAdapter.init(context);
    return InkWell(
        onTap:this.callBack,
        child: Container(
            height: ScreenAdapter.setHeight(68.0),
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: this.color,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child:  Center(
                child: Text('${this.text}',style: TextStyle(color: Colors.white),),
            ),
        ),
    );
  }
}