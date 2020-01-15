import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';

class JdText extends StatelessWidget {

    String hintText;
    bool isPWD ;
    Object onChanged;
    int maxLines;
    double height;

    JdText({Key key,this.hintText = '请输入',this.isPWD = false,this.onChanged = null,this.height = 120,this.maxLines = 1 }):super(key:key);

  @override
  Widget build(BuildContext context) {
      ScreenAdapter.init(context);
    return Container(
        height: ScreenAdapter.setHeight(this.height),
        alignment: Alignment.topCenter,
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
            maxLines: this.maxLines,
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