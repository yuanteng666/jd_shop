import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jd_shop/modal/ProductContentModel.dart';
import 'package:jd_shop/services/EventBus.dart';

import '../../utils/ScreenAdapter.dart';
import '../../widgets/JdButton.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:jd_shop/pages/productcontent/CartNum.dart';
import 'package:jd_shop/services/CartService.dart';
import 'package:jd_shop/providers/Cart.dart';
import 'package:provider/provider.dart';

class ProductContentFirst extends StatefulWidget {
  final List _productContentList ;

  ProductContentFirst(this._productContentList,{Key key}):super(key:key);

  @override
  ProductContentFirstState createState() => new ProductContentFirstState();
}

class ProductContentFirstState extends State<ProductContentFirst> with AutomaticKeepAliveClientMixin {
  Result result;
  List<Attr> attrs;
  String _selectValue = '';

  var actionEventBus;
  var cartProvider;
  _attrShowActionSheet(){
    showModalBottomSheet(context: context, builder: (context){

      return StatefulBuilder(
        builder: (BuildContext context,setBottomState){

          return GestureDetector(
            onTap: (){
              return false;
            },
            child: Container(
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Column(
                        children: this.attrs.map((value){
                          return Wrap(
                            children: <Widget>[
                              Container(
                                width: ScreenAdapter.setWidth(140.0),
                                child: Padding(
                                  padding: EdgeInsets.only(top: ScreenAdapter.setHeight(38.0)),
                                  child: Text('${value.cate}:',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              ),
                              Container(
                                width: ScreenAdapter.setWidth(540.0),
                                child: Wrap(
                                  children:value.attrlist.map((value2){
                                    return Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: InkWell(
                                        child: Chip(
                                          label: Text("${value2['title']}"),
                                          backgroundColor: value2['checked'] == true?Colors.red:Colors.black12,
                                        ),
                                        onTap: (){
                                          this._changeAttr(value.cate,value2['title'],setBottomState);
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                      Divider(),
                      Container(
                        height: ScreenAdapter.setHeight(80.0),
                        padding: EdgeInsets.only(left: ScreenAdapter.setWidth(30.0)),
                        child: Row(
                          children: <Widget>[
                            Text('数量：',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(width: ScreenAdapter.setWidth(10.0),),
                            CartNum(this.result.count)
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdapter.getScreenWidth(),
                    height: ScreenAdapter.setHeight(80.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child:JdButton(
                              text: '加入购物车',
                              color: Color.fromRGBO(253, 1, 0, 0.9),
                              callBack: () async {
                                print('加入购购物车');
                                await  CartService.addCart(this.result);
                                //关闭bottomSheet
                                Navigator.of(context).pop();
                                cartProvider.updateProvider();

                              },
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child:JdButton(
                              text: '立即购买',
                              color: Color.fromRGBO(255, 165, 0, 0.9),
                              callBack: (){
                                print('立即购买');
                              },
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    cartProvider =  Provider.of<Cart>(context);
    //处理图片
    String pic = Config.DOMAIN + this.result.pic;
    pic = pic.replaceAll('\\', '/');
      return Container(
        padding: EdgeInsets.all(10.0),
          child:ListView(
            children: <Widget>[
              //图片
              AspectRatio(
                aspectRatio: 16/9,
                child: Image.network(pic,fit: BoxFit.cover,),
              ),
              //标题
              Container(
                padding: EdgeInsets.only(top: ScreenAdapter.setHeight(10.0)),
                child: Text('${this.result.title}',style: TextStyle(fontSize: ScreenAdapter.setFontsize(36.0),color: Colors.black),),
              ),
              //详细描述
              Container(
                padding: EdgeInsets.only(top: ScreenAdapter.setHeight(10.0)),
                child: Text('${this.result.subTitle}',style: TextStyle(fontSize: ScreenAdapter.setFontsize(28.0),color: Colors.black54),),
              ),
              //价格
              Container(
                padding: EdgeInsets.only(top: ScreenAdapter.setHeight(10.0)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('特价：'),
                          Text('￥${this.result.price}',style: TextStyle(fontSize: ScreenAdapter.setFontsize(46.0),color: Colors.red),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('原价：'),
                          Text('￥${this.result.oldPrice}',style: TextStyle(fontSize: ScreenAdapter.setFontsize(30.0),color: Colors.yellow,decoration: TextDecoration.lineThrough),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              this.attrs.length > 0 ? InkWell(
                child: Container(
                  height: ScreenAdapter.setHeight(80.0),
                  child: Row(
                    children: <Widget>[
                      Text('型号：',style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: ScreenAdapter.setWidth(10.0),),
                      Text('${this._selectValue}')
                    ],
                  ),
                ),
                onTap: (){
                  this._attrShowActionSheet();
                },
              ):Text(''),
              Divider(height: 1.0,),
              InkWell(
                child: Container(
                  height: ScreenAdapter.setHeight(80.0),
                  child: Row(
                    children: <Widget>[
                      Text('邮费：',style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: ScreenAdapter.setWidth(10.0),),
                      Text('免费')
                    ],
                  ),
                ),
              ),
              Divider(height: 1.0,)
            ],
          ),
      );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.result = widget._productContentList[0];
      this.attrs = result.attr;
    });
    print(attrs);
    this._initAttr();
    actionEventBus  = eventBus.on<ProductContentBus>().listen((event){
      print(event);
      this._attrShowActionSheet();
    });
  }

  _changeAttr(cate,title,setBottomState){
    var attr = this.attrs;
    for(var i = 0;i < attr.length;i++){
      if(attr[i].cate == cate){
        for(var j = 0;j < attr[i].attrlist.length ; j++){
          attr[i].attrlist[j]['checked'] = false;

          if(attr[i].attrlist[j]['title'] == title){
            attr[i].attrlist[j]['checked'] = true;
          }
        }
      }
    }

    setBottomState(() {
      this.attrs = attr;
    });
    _getSelectList();
  }

  _getSelectList(){
    var attr = this.attrs;
    List<String> temp = [];
    for(var i = 0;i < attr.length;i++){
      for(var j = 0;j < attr[i].attrlist.length ; j++){

        if(attr[i].attrlist[j]['checked'] == true){
          temp.add(attr[i].attrlist[j]['title']);
        }
      }
    }
    setState(() {
      this._selectValue = temp.join(',');
      this.result.selectAttr = this._selectValue;
    });
  }
  _initAttr(){
    var attr = this.attrs;
    for(var i = 0;i < attr.length;i++){
      for(var j = 0;j < attr[i].list.length ; j++){
        attr[i].attrlist.add({
          'title':attr[i].list[j],
          'checked':false
        });
      }
    }
    _getSelectList();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.actionEventBus.cancel();
  }

  @override
  void didUpdateWidget(ProductContentFirst oldWidget) {
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