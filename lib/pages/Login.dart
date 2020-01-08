import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/widgets/JdButton.dart';
import 'package:jd_shop/widgets/JdText.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_shop/utils/Storage.dart';
import 'package:jd_shop/services/EventBus.dart';
class Login extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<Login> {

  String tel = '';
  String pwd = '';

  doLogin() async{
    if (this.tel != null && this.pwd != null) {
      RegExp regExp = new RegExp(r'^1\d{10}$');
      if (regExp.hasMatch(this.tel) && this.pwd.length >= 6) {
        var api = '${Config.DOMAIN}api/doLogin';
        var response = await Dio().post(api, data: {'username': this.tel,'password':this.pwd});
        print(response.data.toString());
        if (response.data['success']) {
          Storage.setString('userinfo', json.encode(response.data['userinfo']));

          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
              msg: '${response.data['message']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white);
        }
      } else {
        Fluttertoast.showToast(
            msg: '手机号不正确或密码长度太短',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      }
    } else {
      Fluttertoast.showToast(
          msg: '请完善登录信息',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('客服'),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(

                width: ScreenAdapter.setWidth(160.0),
                height: ScreenAdapter.setWidth(160.0),
                margin: EdgeInsets.only(top: ScreenAdapter.setHeight(20.0)),
                child: Image.asset('images/login.png',fit: BoxFit.cover,),
              ),
            ),
            JdText(isPWD: false,hintText: '请输入用户名/手机号',onChanged: (value){
              this.tel = value;
            },),
            JdText(isPWD: true,hintText: '请输入密码',onChanged: (value){
              this.pwd = value;
            },),
            SizedBox(height: ScreenAdapter.setHeight(20.0),),
            Container(
              padding: EdgeInsets.only(left: 10.0,right: 10.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('忘记密码',style: TextStyle(color: Colors.black54),),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Text('注册账号',style: TextStyle(color: Colors.black54),),
                      onTap: (){
                        Navigator.pushNamed(context, '/registerfirst');
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: ScreenAdapter.setHeight(40.0),),

            JdButton(color: Colors.redAccent,text: '登录',callBack: (){
              this.doLogin();
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //发送广播
    eventBus.fire(UserBus('登录成功'));
  }

  @override
  void didUpdateWidget(Login oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
