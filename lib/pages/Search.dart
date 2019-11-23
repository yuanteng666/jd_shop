import 'package:flutter/material.dart';

import 'package:jd_shop/utils/ScreenAdapter.dart';
import 'package:jd_shop/utils/SearchService.dart';
class Search extends StatefulWidget {
  @override
  SearchState createState() => new SearchState();
}

class SearchState extends State<Search> {

  var keyWords = "";
  List _historySearchList = [];

  Widget _historyWidget(){
    if(this._historySearchList.length > 0){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0),
            padding:EdgeInsets.only(left: 10.0),
            child: Text('历史记录',style: Theme.of(context).textTheme.title,),
          ),
          Divider(),
          Column(
            children: this._historySearchList.map((value){
              return Column(
                children: <Widget>[
                  ListTile(title: Text('$value'),
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ),
          SizedBox(
            height: ScreenAdapter.setHeight(80.0),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 90.0,right: 50.0),
              width: ScreenAdapter.setWidth(400.0),
              height: ScreenAdapter.setHeight(64.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black38,
                      width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(2.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.delete_forever,),
                  Text('清空历史记录',)
                ],
              ),
            ),
            onTap: (){
              SearchService.removeSearchList();
              //重新给 historylist赋值
              this._getHistorySearchList();
              print('清空历史记录');
            },
          )
        ],
      );
    }else{
      return Text('');
    }
  }

//  _showAlertDialog(keywords) async{
//
//    var result= await showDialog(
//        barrierDismissible:false,   //表示点击灰色背景的时候是否消失弹出框
//        context:context,
//        builder: (context){
//          return AlertDialog(
//            title: Text("提示信息!"),
//            content:Text("您确定要删除吗?") ,
//            actions: <Widget>[
//              FlatButton(
//                child: Text("取消"),
//                onPressed: (){
//                  print("取消");
//                  Navigator.pop(context,'Cancle');
//                },
//              ),
//              FlatButton(
//                child: Text("确定"),
//                onPressed: () async{
//                  //注意异步      先删除数据 再返回OK
//                  await SearchService.removeSearchKeyword(keywords);
//                  this._getHistorySearchList();
//                  Navigator.pop(context,"Ok");
//                },
//              )
//            ],
//
//          );
//        }
//    );
//
//    //  print(result);
//
//  }


  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: new AppBar(
        title: Container(
          height: ScreenAdapter.setHeight(70.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, 230, 230, 0.8),
            borderRadius: BorderRadius.circular(30),

          ),
          child: TextField(
            autofocus: true,
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
                Navigator.pushReplacementNamed(context, '/productList',arguments: {
                  'keyWords':this.keyWords
                });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.setWidth(10.0)),
        child: ListView(
          children: <Widget>[
            Container(
              padding:EdgeInsets.only(left: 10.0),
              child: Text('热搜',style: Theme.of(context).textTheme.title,),
            ),
            Divider(),
            Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(230, 230, 230, 0.9),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text('笔记本'),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 230, 230, 0.9),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 230, 230, 0.9),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text('运动鞋'),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 230, 230, 0.9),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text('耐克篮球鞋'),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 230, 230, 0.9),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text('手机'),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 230, 230, 0.9),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text('数码相机'),
                )
              ],
            ),
            _historyWidget()
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getHistorySearchList();
  }


  _getHistorySearchList() async{
    List list  = await SearchService.getSearchList();
    setState(() {
      this._historySearchList = list;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Search oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}