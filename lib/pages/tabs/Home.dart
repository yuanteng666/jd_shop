import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../utils/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../../modal/FocusModal.dart';
import '../../modal/ProductModel.dart';
import '../../config/Config.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{


  List _focusList = [];
  List _remProductlist = [];
  List _hotProductlist = [];

  Widget _titleWidget(String value){
    return Container(
      alignment: Alignment.centerLeft,
      height: ScreenAdapter.setHeight(46),
      margin: EdgeInsets.only(left: ScreenAdapter.setWidth(10.0)),
      padding: EdgeInsets.only(left: ScreenAdapter.setWidth(10.0)),
      decoration: BoxDecoration(
          border:Border(
          left: BorderSide(color: Colors.red,
          width: ScreenAdapter.setWidth(10.0)),
        ),
      ),
      child: Text(value,style: TextStyle(
        color: Colors.black54
      ),),
    );
  }

  getFocusData() async{
    var api = "${Config.DOMAIN}api/focus";
    var response = await Dio().get(api);
    FocusModel focus = FocusModel.fromJson(response.data);
    setState(() {
      this._focusList.addAll(focus.result);
    });

  }
  Widget _getSwiperWidget(){
    if(this._focusList.length > 0){
      return Container(
        child: AspectRatio(aspectRatio: 2/1,
          child: Swiper(
            autoplay: true,
            pagination: SwiperPagination(),
            itemCount: this._focusList.length,
            itemBuilder: (BuildContext context,int index){
              String pic = this._focusList[index].pic;
              return Image.network('${Config.DOMAIN}${pic.replaceAll("\\", "/")}',
                fit: BoxFit.fill,);
            },
          ),),
      );
    }else{
      return Text('加载中...');
    }
  }

  //获取热门商品列表
  _getHotProductData() async{
    var api = "${Config.DOMAIN}api/plist?is_hot=1";
    var response = await Dio().get(api);
    ProductModel productModel = ProductModel.fromJson(response.data);
    setState(() {
      this._hotProductlist.addAll(productModel.result);
    });

  }

  //获取推荐商品列表
  _getRemProductData() async{
    var api = "${Config.DOMAIN}api/plist?is_best=1";
    var response = await Dio().get(api);
    ProductModel productModel = ProductModel.fromJson(response.data);

    setState(() {
      this._remProductlist.addAll(productModel.result);
    });

  }
  Widget _hotProductList(){
    if(this._hotProductlist.length > 0){
      return Container(
        height: ScreenAdapter.setHeight(234),
        padding: EdgeInsets.all(ScreenAdapter.setWidth(20)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (contxt, index) {
            //处理图片
            String sPic = this._hotProductlist[index].sPic;
            sPic = Config.DOMAIN + sPic.replaceAll('\\', '/');

            return Column(
              children: <Widget>[
                Container(
                  height: ScreenAdapter.setHeight(140),
                  width: ScreenAdapter.setWidth(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.setWidth(21)),
                  child: Image.network(sPic, fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.setHeight(10)),
                  height: ScreenAdapter.setHeight(44),
                  child: Text(
                    "¥${this._hotProductlist[index].price}",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          itemCount: this._hotProductlist.length,
        ),
      );
    }else{
      Text('加载中...');
    }
  }


  Widget _getRemProductItem(){
    if(this._remProductlist.length > 0){
      var itemWidth = (ScreenAdapter.getScreenWidth() - ScreenAdapter.setWidth(32))/2;
      return Container(
        padding: EdgeInsets.all(ScreenAdapter.setWidth(10)),
        child: Wrap(
          runSpacing: ScreenAdapter.setWidth(10),
          spacing: ScreenAdapter.setWidth(10),
          children: this._remProductlist.map((value){
            String pic = value.pic;
            String newPic = Config.DOMAIN + pic.replaceAll("\\", "/");
            print(newPic);
           return Container(
              width: itemWidth,
              padding: EdgeInsets.all(ScreenAdapter.setWidth(10)),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black12,
                      width: 1
                  )
              ),
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1/1,
                    child: Image.network("${newPic}",fit: BoxFit.cover,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.setHeight(10.0),
                        bottom: ScreenAdapter.setHeight(10.0)),
                    child: Text("${value.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),),
                  ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("￥${value.price}",style: TextStyle(
                            color: Colors.red,fontSize: 16.0
                        ),),

                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child:  Text("￥${value.oldPrice}",style: TextStyle(
                            color: Colors.black54,fontSize: 14.0,decoration: TextDecoration.lineThrough
                        ),),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ),
      );
    }else{
      return Text('加载中...');
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      body: ListView(
          children: <Widget>[
            //TODO:这里写子控件。
            _getSwiperWidget(),
            SizedBox(height: ScreenAdapter.setHeight(5.0),),
            _titleWidget("猜你喜欢"),
           _hotProductList(),
            _titleWidget("热门推荐"),
            _getRemProductItem()

          ],
        )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFocusData();
    _getHotProductData();
    _getRemProductData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
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