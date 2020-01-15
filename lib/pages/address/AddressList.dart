import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:jd_shop/services/Sign.dart';
import 'package:jd_shop/services/UserInfoSerive.dart';
import 'package:dio/dio.dart';
import 'package:jd_shop/services/EventBus.dart';
class AddressList extends StatefulWidget {
  @override
  AddressListState createState() => new AddressListState();
}

class AddressListState extends State<AddressList> {
  List addressList = [];
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('地址列表'),
      ),
      body: Container(
        child:Stack(
          children: <Widget>[
            ListView.builder(itemBuilder: (context,index){
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: this.addressList[index]['default_address'] == 1 ? Icon(Icons.check, color: Colors.redAccent):null,
                    title: Text('${this.addressList[index]['name']} ${this.addressList[index]['phone']}'),
                    subtitle: Text('${this.addressList[index]['address']}'),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(),
                ],
              );
            },
            itemCount: this.addressList.length,),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: ScreenAdapter.setWidth(750.0),
                height: ScreenAdapter.setHeight(100.0),
                color: Colors.redAccent,
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add,color:Colors.white),
                      Text('新增一个收货地址',style: TextStyle(color:Colors.white),)
                    ],
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, '/addressAdd');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventBus.on<AddressBus>().listen((event){
      this._getAddressList();
    });
    _getAddressList();
  }

  _getAddressList() async{
    //请求接口
    List userinfo = await UserInfoSerive.getUserInfo();

    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};

    var sign = Sign.getSign(tempJson);

    var api =
        '${Config.DOMAIN}api/addressList?uid=${userinfo[0]['_id']}&sign=${sign}';

    var response = await Dio().get(api);
     print(response.data["result"]);

    setState(() {
      this.addressList = response.data["result"];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(AddressList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
