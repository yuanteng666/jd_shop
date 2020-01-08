import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/widgets/JdButton.dart';
import 'package:jd_shop/widgets/JdText.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_shop/utils/Storage.dart';
import 'package:jd_shop/pages/tabs/Tabs.dart';
class RegisterThridPage extends StatefulWidget {

  final Map arguments;
  RegisterThridPage({Key key ,this.arguments}):super(key:key);

  @override
  RegisterThridPageState createState() => new RegisterThridPageState();
}

class RegisterThridPageState extends State<RegisterThridPage> {
  String tel;
  String code;
  String pwd = '';
  String rpwd = '';

  //注册
  doRegister() async{

    if(pwd.length < 6){
      Fluttertoast.showToast(
          msg: '密码长度不能小于六位',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    }else if(pwd != rpwd){
      Fluttertoast.showToast(
          msg: '两次输入的密码不一致',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    }else{
      var api = '${Config.DOMAIN}api/register';
      var response = await Dio().post(api, data: {'tel': this.tel,'code':this.code,'password':this.pwd});
      print(response.data.toString());

      if (response.data['success']) {
        //保存用户信息到本地存储
        Storage.setString('userinfo', json.encode(response.data['userinfo']));
        //返回到根
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new Tabs()),
                (route) => route == null);
      } else {
        Fluttertoast.showToast(
            msg: '${response.data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('用户注册-第三步'),
      ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[

              JdText(isPWD: true,hintText: '请输入密码',onChanged: (value){
                print(value);
                this.pwd = value;
              },),
              JdText(isPWD: true,hintText: '请确认密码',onChanged: (value){
                print(value);
                this.rpwd = value;
              },),
              SizedBox(height: ScreenAdapter.setHeight(20.0),),


              JdButton(color: Colors.redAccent,text: '注册',callBack: (){
                this.doRegister();
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
    this.code = widget.arguments['code'];
    this.tel = widget.arguments['tel'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(RegisterThridPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}