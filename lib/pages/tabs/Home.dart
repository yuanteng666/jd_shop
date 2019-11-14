import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../utils/ScreenAdapter.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

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

  Widget _getSwiperWidget(){
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];
    return Container(
      child: AspectRatio(aspectRatio: 2/1,
      child: Swiper(
        autoplay: true,
        pagination: SwiperPagination(),
        itemCount: imgList.length,
        itemBuilder: (BuildContext context,int index){
          return Image.network(imgList[index]['url'],
          fit: BoxFit.fill,);
        },
      ),),
    );
  }

  Widget _hotProductList(){
    return  Container(
      padding: EdgeInsets.all(ScreenAdapter.setWidth(10.0)),
      height: ScreenAdapter.setHeight(200.0),
      child:   new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                width: ScreenAdapter.setWidth(160.0),
                height: ScreenAdapter.setHeight(140.0),
                margin: EdgeInsets.only(right: ScreenAdapter.setWidth(10.0)),
                child:  Image.network("https://www.itying.com/images/flutter/hot${index+1}.jpg",fit: BoxFit.cover),
              ),
              Text('第${index+1}个')
            ],
          );
        },
      ),
    );
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
            _titleWidget("猜你喜欢"),

          ],
        )
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
  void didUpdateWidget(HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}