import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';

class JdText extends StatelessWidget {

    String hintText;
    bool isPWD ;
    Object onChanged;

    JdText({Key key,this.hintText = '请输入',this.isPWD = false,this.onChanged = null }):super(key:key);

  @override
  Widget build(BuildContext context) {
      ScreenAdapter.init(context);
    return Container(
        height: ScreenAdapter.setHeight(120.0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: ScreenAdapter.setHeight(2.0),
                    color: Colors.black12
                )
            )

        ),
        child: TextField(
            autofocus: true,
            obscureText: this.isPWD,
            decoration: InputDecoration(
                hintText: this.hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none
                )
            ),
            onChanged: this.onChanged
        ),
    );
  }
}