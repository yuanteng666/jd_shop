import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:jd_shop/config/Config.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/modal/ProductModel.dart';
import 'package:jd_shop/widgets/LoadingWidget.dart';
import 'package:jd_shop/utils/SearchService.dart';
class ProductListPage extends StatefulWidget {
  Map arguments ;

  ProductListPage({Key key,this.arguments}):super(key :key);

  @override
  ProductListPageState createState() => new ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  /*二级导航数据
  * 排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}},*/
  List _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1},
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  int _subHeaderSelectId = 1;
  List _productList = [];
  //是否还有数据，防止服务器无数据，但前端继续请求
  bool isHaveData = true;
  //是否可以加载数据，防止重复加载
  bool isCanLoading = true;
  //是否为空 ，防止出现没有数据的情况
  bool isEmptyList = false;
  int currentPage = 1;
  int pageSize = 10;
  String sort = '';
  TextEditingController _textEditingController = new TextEditingController();
  String keyWords;
  /*获取商品列表*/
  _getProductList() async{
    setState(() {
      this.isCanLoading = false;
    });
    var api = '';
    //判断是否来自 搜索页面
    if(this.keyWords== null ){
        api = Config.DOMAIN + "api/plist?cid=${widget.arguments['cid']}&page=${this.currentPage}&pageSize=${this.pageSize}&sort=${this.sort}";
    }else{
        api = Config.DOMAIN + "api/plist?search=${this.keyWords}&page=${this.currentPage}&pageSize=${this.pageSize}&sort=${this.sort}";
    }
    print(api);

    var response = await Dio().get(api);
    ProductModel model = ProductModel.fromJson(response.data);
    print(model.result);
    setState(() {
      _productList.addAll(model.result);
      currentPage++;
      isCanLoading = true;
    });
    if(model.result.length == 0 && this.currentPage == 1){
      setState(() {
        this.isEmptyList = true;
      });
    }else{
      setState(() {
        this.isEmptyList = false;
      });
    }
    if(model.result.length < this.pageSize){
      setState(() {
        this.isHaveData = false;
      });
    }
  }

  _subHeaderChange(int id){
    if(id == 4){
      this._scaffoldKey.currentState.openEndDrawer();
      setState(() {
        this._subHeaderSelectId = id;
      });
    }else{
      setState(() {
        this._subHeaderSelectId = id;
        this.sort = "${this._subHeaderList[id-1]['fileds']}_${this._subHeaderList[id - 1]['sort']}";
        //重置分页和数据
        this.currentPage = 1;
        this._productList.clear();
        this.isHaveData = true;
        //回到顶部
        this._scrollController.jumpTo(0);

        //通过 与 -1相乘，改变sort ,从而改变升降序
        this._subHeaderList[id - 1]['sort'] =  this._subHeaderList[id - 1]['sort'] * -1;
       });
      this._getProductList();
    }

  }

  Widget _showIcon(id){
    if(id == 2 || id == 3){
      if(this._subHeaderList[id - 1]['sort'] == 1){
        return Icon(Icons.arrow_drop_down);
      }
      return Icon(Icons.arrow_drop_up);

    }else{
      return Text('');
    }
  }
  /*顶部导航*/
  Widget _productSubNav(){
    return Positioned(
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
            children: _subHeaderList.map((value){
              return Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.setHeight(16.0), 0, ScreenAdapter.setHeight(16.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('${value['title']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: this._subHeaderSelectId == value['id']?Colors.red:Colors.black),),
                        _showIcon(value['id'])
                      ],
                    )
                  ),
                  onTap: (){
                    this._subHeaderChange(value['id']);
                  },
                ),
              );
            }).toList()
          )
      ),
    );
  }

  Widget _showMore(int index){
    if(this.isHaveData){
      return (index == this._productList.length-1 )?LoadingWidget():Text('');
    }else{
      return (index == this._productList.length-1)?Padding(
        padding: EdgeInsets.all(10.0),
        child: Text('----------我是有底线的----------',style: TextStyle(fontSize: 16.0,color: Colors.black45),),
      ):Text('');
    }
  }
  /*商品列表**/
  Widget _productListWidget(){
    if(this._productList.length > 0){
     return  Container(
        margin: EdgeInsets.only(top: ScreenAdapter.setHeight(80.0)),
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(itemBuilder: (context,index){
          Result result = this._productList[index];
          String spc = result.sPic;
          String picPath = Config.DOMAIN + spc.replaceAll("\\", "/");
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.setWidth(180.0),
                    height: ScreenAdapter.setHeight(180.0),
                    child: Image.network(picPath,),
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
                          Text(result.title,maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black45,fontSize: 17),),
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
                          Text("￥${result.price}",style: TextStyle(color: Colors.red,fontSize: 16),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Divider(height: 1.0,),
              _showMore(index)
            ],
          );
        },
          itemCount: this._productList.length,
        controller: this._scrollController,),
      );
    }else{
      return Container(
        child: LoadingWidget(),
        margin: EdgeInsets.only(top: ScreenAdapter.setHeight(80.0)),

      );
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Container(
          height: ScreenAdapter.setHeight(70.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, 230, 230, 0.8),
            borderRadius: BorderRadius.circular(30),

          ),
          child: TextField(
            autofocus: true,
            controller: _textEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none
                )
            ),
            onChanged: (value){
              setState(() {
                this.keyWords = value;
              });
            },
          ),
        ),
        actions: <Widget>[
          InkWell(

            child: Container(
              padding: EdgeInsets.only(right: ScreenAdapter.setWidth(10.0)),
              child: Row(
                children: <Widget>[
                  Text('搜索',style: TextStyle(fontSize: ScreenAdapter.setFontsize(30)),)
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              height: ScreenAdapter.setHeight(70),
              width: ScreenAdapter.setWidth(90),            ),
               onTap: (){
                 SearchService.saveSearchData(this.keyWords);

                 this._subHeaderChange(1);
            },
          )
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          child: Text('我是抽屉'),
        ),
      ),
      body:this.isEmptyList?Center(
        child: Text('没有要搜索的数据'),
      ):Stack(
        children: <Widget>[
          _productSubNav(),
          _productListWidget()
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //添加监听事件
    this._scrollController.addListener((){
     // this._scrollController.position.pixels; 滚动条滚动高度
     // this._scrollController.position.maxScrollExtent listview的最大高度
      if(this._scrollController.position.pixels > this._scrollController.position.maxScrollExtent - 40){
        if(this.isHaveData && this.isCanLoading){
          this._getProductList();
        }
      }
    });
    this.keyWords = widget.arguments['keyWords'] == null ?null:widget.arguments['keyWords'];
    //初始化获取数据
    this._getProductList();
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