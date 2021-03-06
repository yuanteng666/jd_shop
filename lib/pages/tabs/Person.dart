import 'package:flutter/material.dart';
import 'package:jd_shop/providers/Counter.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import 'package:jd_shop/services/UserInfoSerive.dart';
import 'package:jd_shop/widgets/JdButton.dart';
import 'package:jd_shop/services/EventBus.dart';

class PersonPage extends StatefulWidget {
  @override
  PersonPageState createState() => new PersonPageState();
}

class PersonPageState extends State<PersonPage> {

  bool isLogin = false;
  List userInfo = [];

  _getUserInfo() async{
    var isLogin2 = await UserInfoSerive.getUserInfoState();
    var userinfo2 = await UserInfoSerive.getUserInfo();
    setState(() {
      this.isLogin = isLogin2;
      this.userInfo = userinfo2;
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              height: ScreenAdapter.setHeight(220.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/user_bg.jpg'),
                      fit: BoxFit.cover)),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: ClipOval(
                        child: Image.asset(
                      'images/user.png',
                      fit: BoxFit.cover,
                      width: ScreenAdapter.setWidth(100.0),
                      height: ScreenAdapter.setWidth(100.0),
                    )),
                  ),
                  !this.isLogin?Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Text(
                        '登录/注册',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ):Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '用户名：${this.userInfo[0]['username']}',
                          style: TextStyle(color: Colors.white, fontSize: ScreenAdapter.setFontsize(36.0)),
                        ),
                        Text(
                          '普通会员',
                          style: TextStyle(color: Colors.white, fontSize: ScreenAdapter.setFontsize(32.0)),
                        ),
                      ],
                    ),
                  )
                ],
              )),
          ListTile(
            leading: Icon(
              Icons.local_mall,
              color: Colors.redAccent,
            ),
            title: Text('全部订单'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.greenAccent),
            title: Text('待付款'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.directions_car, color: Colors.blue),
            title: Text('待收货'),
          ),
          Container(
            width: double.infinity,
            height: ScreenAdapter.setHeight(15.0),
            color: Colors.black12,
          ),
          ListTile(
            leading: Icon(
              Icons.save,
              color: Colors.redAccent,
            ),
            title: Text('我的收藏'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.contacts,
              color: Colors.yellow,
            ),
            title: Text('在线客服'),
          ),
          Divider(),
          SizedBox(height: ScreenAdapter.setHeight(30.0),),
          this.isLogin?Container(
            padding: EdgeInsets.only(left: 20.0,right: 20.0),
            child: JdButton(
              color: Colors.redAccent,
              text: '退出登录',
              callBack: (){
                UserInfoSerive.loginOut();
                this._getUserInfo();
              },
            ),
          ):Text('')
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._getUserInfo();
    //监听eventbus 广播
    eventBus.on<UserBus>().listen((event){
      print(event);
      this._getUserInfo();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(PersonPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
