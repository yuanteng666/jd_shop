import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';

class ProductListPage extends StatefulWidget {
  Map arguments ;

  ProductListPage({Key key,this.arguments}):super(key :key);

  @override
  ProductListPageState createState() => new ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {

  Widget _productListWidget(){
    return  Container(
      margin: EdgeInsets.only(top: ScreenAdapter.setHeight(80.0)),
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(itemBuilder: (context,index){
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: ScreenAdapter.setWidth(180.0),
                  height: ScreenAdapter.setHeight(180.0),
                  child: Image.network('http://jd.itying.com/public/upload/E8jnbcercoZGdllR3r9QN5aD.jpg',),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin:EdgeInsets.only(left:10.0),
                    height: ScreenAdapter.setHeight(180.0),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        Text('我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题',maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black45,fontSize: 17),),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text('4G'),
                              height: ScreenAdapter.setHeight(40.0),
                              //如果container 里面包含decoration则color必须放在decoration内不然会报错
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromRGBO(230, 230, 230, 0.9)
                              ),
                              padding: EdgeInsets.fromLTRB(10.0,5.0, 10.0, 5),
                              margin: EdgeInsets.only(right: 20.0),
                            ),
                            Container(
                              child: Text('16G'),
                              height: ScreenAdapter.setHeight(40.0),
                              padding: EdgeInsets.fromLTRB(10.0,5.0, 10.0, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromRGBO(230, 230, 230, 0.9)
                              ),
                            )
                          ],
                        ),
                        Text('￥3688',style: TextStyle(color: Colors.red,fontSize: 16),)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider(height: 1.0,)
          ],
        );
      },
        itemCount: 10,),
    );
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('商品列表'),
      ),
      body:Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: ScreenAdapter.setHeight(80.0),
            width: ScreenAdapter.getScreenWidth(),
            child: Container(
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.setHeight(80.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                    width: 1.0
                  )
                )
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Text('综合',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Text('销量',textAlign: TextAlign.center,),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Text('价格',textAlign: TextAlign.center,),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Text('筛选',textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              )
            ),
          ),
          _productListWidget()
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
  void didUpdateWidget(ProductListPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}