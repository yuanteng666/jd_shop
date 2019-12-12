import 'package:flutter/material.dart';
import 'productcontent/ProductContentFirst.dart';
import 'productcontent/ProductContentSecond.dart';
import 'productcontent/ProductContentThrid.dart';
import '../utils/ScreenAdapter.dart';
import '../widgets/JdButton.dart';
import 'package:dio/dio.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:jd_shop/modal/ProductContentModel.dart';

import 'package:jd_shop/widgets/LoadingWidget.dart';

class ProductContent extends StatefulWidget {
  Map arguments;

  ProductContent({Key key, this.arguments}) : super(key: key);

  @override
  ProductContentState createState() => new ProductContentState();
}

class ProductContentState extends State<ProductContent> {
  Result result;
  List _productContentList = [];
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdapter.setWidth(400.0),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.red,
                  tabs: <Widget>[
                    Tab(
                      child: Text('商品'),
                    ),
                    Tab(
                      child: Text('详情'),
                    ),
                    Tab(
                      child: Text('评价'),
                    )
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        ScreenAdapter.setWidth(500.0),
                        ScreenAdapter.setHeight(140.0),
                        ScreenAdapter.setWidth(15.0),
                        0),
                    items: [
                      PopupMenuItem(
                        child: InkWell(
                          child: Row(
                            children: <Widget>[Icon(Icons.home), Text('首页')],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          child: Row(
                            children: <Widget>[Icon(Icons.search), Text('搜索')],
                          ),
                        ),
                      ),
                    ]);
              },
            )
          ],
        ),
        body: this._productContentList.length > 0
            ? Stack(
                children: <Widget>[
                  TabBarView(
                    children: <Widget>[
                      ProductContentFirst(this._productContentList),
                      ProductContentSecond(this._productContentList),
                      ProductContentThrid(this._productContentList)
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: ScreenAdapter.getScreenWidth(),
                      height: ScreenAdapter.setHeight(80.0),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Colors.black38, width: 1.0))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenAdapter.setWidth(20.0)),
                            width: ScreenAdapter.setWidth(120.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.shopping_cart),
                                Text('购物车')
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: JdButton(
                                text: '加入购物车',
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                callBack: () {
                                  print('加入购购物车');
                                },
                              )),
                          Expanded(
                              flex: 1,
                              child: JdButton(
                                text: '立即购买',
                                color: Color.fromRGBO(255, 165, 0, 0.9),
                                callBack: () {
                                  print('立即购买');
                                },
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : LoadingWidget(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getContent();
  }

  _getContent() async {
    var api = "${Config.DOMAIN}api/pcontent?id=${widget.arguments['id']}";
    var response = await Dio().get(api);
    ProductContentModel model = ProductContentModel.fromJson(response.data);
    setState(() {
      this.result = model.result;
      _productContentList.add(result);
    });
    print(model);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(ProductContent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
