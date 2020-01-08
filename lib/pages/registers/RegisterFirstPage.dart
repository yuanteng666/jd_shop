import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/widgets/JdButton.dart';
import 'package:jd_shop/widgets/JdText.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterFirstPage extends StatefulWidget {
  @override
  RegisterFirstPageState createState() => new RegisterFirstPageState();
}

class RegisterFirstPageState extends State<RegisterFirstPage> {
  String tel = '';
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('用户注册-第一步'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.setHeight(20.0),
            ),
            JdText(
              isPWD: false,
              hintText: '请输入手机号',
              onChanged: (value) {
                print(value);
                this.tel = value;
              },
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(20.0),
            ),
            JdButton(
              color: Colors.redAccent,
              text: '下一步',
              callBack: () {
                sendCode();
              },
            )
          ],
        ),
      ),
    );
  }

  sendCode() async {
    if (this.tel != null) {
      RegExp regExp = new RegExp(r'^1\d{10}$');
      if (regExp.hasMatch(this.tel)) {
        print('suc');
        var api = '${Config.DOMAIN}api/sendCode';
        var response = await Dio().post(api, data: {'tel': this.tel});
        print(response.data.toString());
        if (response.data['success']) {
          Navigator.pushNamed(context, '/registersecond',arguments: {
              'tel':this.tel,
              'code':response.data['code']
          });
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
            msg: '请输入正确的手机号',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      }
    } else {
      Fluttertoast.showToast(
          msg: '请输入手机号',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    }
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
  void didUpdateWidget(RegisterFirstPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
