import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../utils/ScreenAdapter.dart';
import '../../modal/CartModel.dart';
import '../../config/Config.dart';


class CategoryPage extends StatefulWidget {
  @override
  CategoryPageState createState() => new CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  int _selectIndex  = 0;
  List _leftCatelist = [];
  List _rightCatelist = [];

  //左侧栏数据
  _getLeftCateData() async{
    String api = Config.DOMAIN +"api/pcate";
    var response = await Dio().get(api);
    CartModel cartModel = CartModel.fromJson(response.data);
    print(cartModel.result);
    setState(() {
      _leftCatelist = cartModel.result;
    });
    if(this._leftCatelist.length > 0){
      _getRightCateData(_leftCatelist[0].sId);
    }
  }

  //右侧栏数据
  _getRightCateData(pid) async{
    String api = Config.DOMAIN + "api/pcate?pid="+pid;
    var response = await Dio().get(api);
    CartModel cartModel = CartModel.fromJson(response.data);
    setState(() {
      _rightCatelist = cartModel.result;
    });
  }
  
  Widget _leftWidget(leftItemWidth){
    if(this._leftCatelist.length > 0){
      return  Container(
        width: leftItemWidth,
        height: double.infinity,
        child: ListView.builder(itemBuilder: (context,index){
          return Column(
            children: <Widget>[
              InkWell(
                child: Container(
                  width: double.infinity,
                  height: ScreenAdapter.setHeight(84.0),
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("${this._leftCatelist[index].title}",textAlign: TextAlign.center,),
                  color: this._selectIndex == index ?Color.fromRGBO(240, 246, 246, 0.9): Colors.white,
                ),
                onTap: (){
                  setState(() {
                    this._selectIndex = index;
                    this._getRightCateData(this._leftCatelist[index].sId);
                  });
                },
              ),
              Divider(height: 1.0,)
            ],
          );
        },
          itemCount: this._leftCatelist.length,),
      );
    }else{
      return Container(
        width: leftItemWidth,
        height: double.infinity,
        child: Text('加载中...'),
      );
    }
  }
  
  Widget _rightWidget(rightItemWidth,rightItemHeight){
    if(this._rightCatelist.length > 0){
      return Expanded(
        flex: 1,
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.all(10.0),
          color: Color.fromRGBO(240, 246, 246, 0.9),

          child: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              childAspectRatio: rightItemWidth/rightItemHeight
          )
            , itemBuilder: (context,index){
              String pic = this._rightCatelist[index].pic;
              String newPic = Config.DOMAIN + pic.replaceAll("\\", "/");
              return InkWell(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1/1,
                        child: Image.network(newPic,fit: BoxFit.cover,),
                      ),
                      Container(
                        height: ScreenAdapter.setHeight(28.0),
                        child: Text("${this._rightCatelist[index].title}"),
                      )
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/productList',arguments: {
                    'cid':this._rightCatelist[index].sId
                  });
                },
              );
            },
            itemCount: this._rightCatelist.length,),
        ),
      );
    }else{
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Text('加载中...'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    var leftItemWidth = ScreenAdapter.getScreenWidth()/4;
    var rightItemWidth = (ScreenAdapter.getScreenWidth() - leftItemWidth - 20 - 20)/3;
    rightItemWidth = ScreenAdapter.setWidth(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdapter.setHeight(28.0);
    return new Scaffold(
      body: Row(
        children: <Widget>[
         _leftWidget(leftItemWidth),
         _rightWidget(rightItemWidth, rightItemHeight)
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getLeftCateData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(CategoryPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}