import 'package:flutter/material.dart';

import '../../utils/ScreenAdapter.dart';
import '../../widgets/JdButton.dart';
class ProductContentFirst extends StatefulWidget {
  @override
  ProductContentFirstState createState() => new ProductContentFirstState();
}

class ProductContentFirstState extends State<ProductContentFirst> {


  _attrShowActionSheet(){
    showModalBottomSheet(context: context, builder: (context){
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
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.setWidth(100.0),
                              child: Padding(
                                padding: EdgeInsets.only(top: ScreenAdapter.setHeight(30.0)),
                                child: Text('颜色:',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Container(
                              width: ScreenAdapter.setWidth(600.0),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('红色'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('白色'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('黑色'),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.setWidth(100.0),
                              child: Padding(
                                padding: EdgeInsets.only(top: ScreenAdapter.setHeight(30.0)),
                                child: Text('风格:',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Container(
                              width: ScreenAdapter.setWidth(600.0),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('S'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('M'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('L'),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.setWidth(100.0),
                              child: Padding(
                                padding: EdgeInsets.only(top: ScreenAdapter.setHeight(30.0)),
                                child: Text('尺寸:',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Container(
                              width: ScreenAdapter.setWidth(600.0),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('S'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('M'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text('L'),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
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
                          callBack: (){
                            print('加入购购物车');
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
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
      return Container(
        padding: EdgeInsets.all(10.0),
          child:ListView(
            children: <Widget>[
              //图片
              AspectRatio(
                aspectRatio: 16/9,
                child: Image.network('https://www.itying.com/images/flutter/p1.jpg',fit: BoxFit.cover,),
              ),
              //标题
              Container(
                padding: EdgeInsets.only(top: ScreenAdapter.setHeight(10.0)),
                child: Text('联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑',style: TextStyle(fontSize: ScreenAdapter.setFontsize(36.0),color: Colors.black),),
              ),
              //详细描述
              Container(
                padding: EdgeInsets.only(top: ScreenAdapter.setHeight(10.0)),
                child: Text('震撼首发，15.9毫米全金属外观，4.9毫米轻薄窄边框，指纹电源按钮，杜比音效，2G独显，预装正版office软件',style: TextStyle(fontSize: ScreenAdapter.setFontsize(28.0),color: Colors.black54),),
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
                          Text('￥2556',style: TextStyle(fontSize: ScreenAdapter.setFontsize(46.0),color: Colors.red),)
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
                          Text('￥2888',style: TextStyle(fontSize: ScreenAdapter.setFontsize(30.0),color: Colors.yellow,decoration: TextDecoration.lineThrough),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  height: ScreenAdapter.setHeight(80.0),
                  child: Row(
                    children: <Widget>[
                      Text('型号：',style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: ScreenAdapter.setWidth(10.0),),
                      Text('115,红色,XL,加绒')
                    ],
                  ),
                ),
                onTap: (){
                  this._attrShowActionSheet();
                },
              ),
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
}