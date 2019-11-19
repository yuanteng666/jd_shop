import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ScreenAdapter {
    static init(BuildContext context){
        ScreenUtil.instance = ScreenUtil(width: 750.0,height: 1334.0)..init(context);
    }

    static double setHeight(double value){
        return ScreenUtil.getInstance().setHeight(value);

    }

    static double setWidth(double value){
        return ScreenUtil.getInstance().setWidth(value);
    }

    static double getScreenWidth(){
        return ScreenUtil.screenWidthDp;
    }

    static double getScreenHeight(){
        return ScreenUtil.screenHeightDp;
    }

    static double setFontsize(double fontSize){
        return ScreenUtil.getInstance().setSp(fontSize);
    }
}