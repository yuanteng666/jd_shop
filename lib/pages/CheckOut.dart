import 'package:flutter/material.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/providers/CheckOutProvider.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {

  @override
  CheckOutPageState createState() => new CheckOutPageState();
}

class CheckOutPageState extends State<CheckOutPage> {
    CheckOutProvider provider;
  Widget CheckOutWiget(item) {
    return Row(
        children: <Widget>[
            Container(
                height: ScreenAdapter.setWidth(160),
                child: Image.network(
                    '${item['pic']}',
                    fit: BoxFit.cover,
                ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text(
                                '${item['title']}',
                                maxLines: 2,
                            ),
                            Text(
                                '${item['selectedAttr']}',
                                maxLines: 1,
                            ),
                            Stack(
                                children: <Widget>[
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("￥${item['price']}",style: TextStyle(color: Colors.red),),
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("x${item['count']}",style: TextStyle(color: Colors.red),),
                                    )
                                ],
                            )
                        ],
                    ),
                ),
            )
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
      ScreenAdapter.init(context);
      provider = Provider.of<CheckOutProvider>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('结算'),
      ),
      body: Stack(
          children: <Widget>[
              ListView(
                  children: <Widget>[
                      Container(
                          color: Colors.white,
                          child: Column(
                              children: <Widget>[
                                  ListTile(
                                      leading: Icon(Icons.location_on),
                                      title: Text('请添加收货地址'),
                                      trailing: Icon(Icons.navigate_next),
                                      onTap: (){
                                          Navigator.pushNamed(context, '/addressList');
                                      },
                                  ),
//                                  ListTile(
//                                      leading: Icon(Icons.location_on),
//                                      title: Text('河南省南阳市内乡县'),
//                                      subtitle: Text('12318756265'),
//                                      trailing: Icon(Icons.navigate_next),
//                                  )
                              ],
                          ),
                      ),
                      SizedBox(height: ScreenAdapter.setHeight(20.0),),
                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                              children: provider.checkOutList.map((value){
                                  return Column(
                                      children: <Widget>[
                                          CheckOutWiget(value),
                                          Divider()
                                      ],
                                  );
                              }).toList(),
                          ),
                      ),
                      SizedBox(height: ScreenAdapter.setHeight(20.0),),
                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  Text('运费：￥10'),
                                  Divider(),
                                  Text('优惠券：-￥10'),
                              ],
                          ),
                      ),
                  ],
              ),
              Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                      padding: EdgeInsets.all(20.0),
                      height: ScreenAdapter.setHeight(130.0),
                      width: ScreenAdapter.setWidth(750.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Colors.black12
                              )
                          )
                      ),
                      child: Stack(
                          children: <Widget>[
                              Align(
                                  child: Text('总金额：￥888',style: TextStyle(color: Colors.redAccent),),
                                  alignment: Alignment.centerLeft,
                              ),
                              Align(
                                  child: RaisedButton(
                                      child: Text('立即下单',style: TextStyle(color: Colors.white),),
                                      color: Colors.redAccent,
                                      onPressed: (){

                                      },
                                  ),
                                  alignment: Alignment.centerRight,
                              )
                          ],
                      ),
                  ),
              )
          ],
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
  }

  @override
  void didUpdateWidget(CheckOutPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
