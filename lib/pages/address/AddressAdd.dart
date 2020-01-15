import 'package:flutter/material.dart';
import 'package:jd_shop/widgets/JdButton.dart';
import 'package:jd_shop/widgets/JdText.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:jd_shop/services/Sign.dart';
import 'package:jd_shop/services/UserInfoSerive.dart';
import 'package:dio/dio.dart';
import 'package:jd_shop/services/EventBus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressAdd extends StatefulWidget {
  @override
  AddressAddState createState() => new AddressAddState();
}

class AddressAddState extends State<AddressAdd> {

  String address = '';
  String name = '';
  String tell = '';
  String addressDetail = '';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('增加收货地址'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0,),
            JdText(hintText: '收货人姓名',onChanged: (value){
              this.name = value;
            },),
            SizedBox(height: 10.0,),
            JdText(hintText: '收货人手机号',onChanged: (value){
              this.tell = value;
            }),
            SizedBox(height: 10.0,),
            ListTile(
              leading: Icon(Icons.location_on),
              title: this.address.length > 0 ? Text(this.address) : Text('省/市/区'),
              onTap: () async{
                Result result = await CityPickers.showCityPicker (
                  context: context,
                    cancelWidget: new Text('取消',
                          style: new TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),),
                    confirmWidget: new Text('确认',
                      style: new TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16.0,
                      ),)
                );
                print(result.toString());
                // {"provinceName":"北京市","provinceId":"110000","cityName":"北京城区","cityId":"110100","areaName":"东城区","areaId":"110101"}
                setState(() {
                  this.address = result.provinceName + ' ' + result.cityName + ' ' + result.areaName;
                });
              },
            ),
            Divider(color: Colors.black12),
            JdText(hintText: '详细地址',maxLines: 4,height: 360,onChanged: (value){
              this.addressDetail = value;
            }),
            SizedBox(height: 50.0),

            JdButton(color: Colors.redAccent,text: '增加',callBack: () async{
                List userinfo = await UserInfoSerive.getUserInfo();
                var uid = userinfo[0]['_id'];
                var salt = userinfo[0]['salt'];

                var tempJson = {
                  'uid': uid,
                  'name' : this.name,
                  'phone' : this.tell,
                  'address' : this.address + this.addressDetail,
                  'salt': salt
                };
                var sign = Sign.getSign(tempJson);
                var api = '${Config.DOMAIN}api/addAddress';
                var result = await Dio().post(api,data: {
                  'uid': uid,
                  'name' : this.name,
                  'phone' : this.tell,
                  'address' : this.address + this.addressDetail,
                  'sign':sign
                });
                if(result.data['success']){
                  Navigator.pop(context);
                }else{
                  Fluttertoast.showToast(
                      msg: '添加地址失败，请重试',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white);
                }
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
    eventBus.fire(new AddressBus('发送广播'));
  }

  @override
  void didUpdateWidget(AddressAdd oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}