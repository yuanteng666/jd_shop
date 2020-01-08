import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/widgets/JdButton.dart';
import 'package:jd_shop/widgets/JdText.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterSecondPage extends StatefulWidget {

  final Map arguments;
  RegisterSecondPage({Key key ,this.arguments}):super(key:key);
  @override
  RegisterSecondPageState createState() => new RegisterSecondPageState();
}

class RegisterSecondPageState extends State<RegisterSecondPage> {
  String tel;
  String code;

  bool isSendCode = false;
  int seconds = 10;

  _showTimer(){
    Timer t ;
    t = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        this.seconds--;
      });
      if(seconds == 0){
        t.cancel();
        setState(() {
          this.isSendCode = true;
          this.seconds = 10;
        });
      }
    });
  }

  sendCode() async {
    setState(() {
      this.isSendCode = false;
      this._showTimer();
    });
    var api = '${Config.DOMAIN}api/sendCode';
    var response = await Dio().post(api, data: {'tel': this.tel});
    print(response.data.toString());

    if (response.data['success']) {

    } else {
      Fluttertoast.showToast(
          msg: '${response.data['message']}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    }
  }
  //验证验证码
  validateCode() async{
    var api = '${Config.DOMAIN}api/validateCode';
    var response = await Dio().post(api, data: {'tel': this.tel,'code':this.code});
    if (response.data['success']) {
      Navigator.pushNamed(context, '/registerthrid',arguments: {
        'tel': this.tel,
        'code':this.code
      });
    } else {
      Fluttertoast.showToast(
          msg: '${response.data['message']}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    }

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('用户注册-第二步'),
      ),
        body:Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: ScreenAdapter.setHeight(20.0),),
              Container(child: Text('验证码已发送到您${this.tel}的手机,请输入${this.tel}收到的验证码'),
              padding: EdgeInsets.only(left: 10.0),),

              Stack(
                children: <Widget>[
                  JdText(isPWD: false,hintText: '验证码',onChanged: (value){
                    print(value);
                  },),
                  Positioned(
                    right: 0,
                    top: 15.0,
                    child: this.isSendCode?RaisedButton(
                      color: Colors.redAccent,
                      child: Text('重新获取',style: TextStyle(color: Colors.white),),
                      onPressed: (){
                          this.sendCode();
                      },
                    ):RaisedButton(
                      color: Colors.redAccent,
                      child: Text('${this.seconds}秒后重发',style: TextStyle(color: Colors.white),),
                      onPressed: (){

                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: ScreenAdapter.setHeight(20.0),),
              JdButton(color: Colors.redAccent,text: '下一步',callBack: (){
                this.validateCode();
              },)

            ],
          ),
        ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tel = widget.arguments['tel'];
    this.code = widget.arguments['code'];
    this._showTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(RegisterSecondPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}