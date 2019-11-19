import 'package:flutter/material.dart';

import 'package:jd_shop/utils/ScreenAdapter.dart';
class Search extends StatefulWidget {
  @override
  SearchState createState() => new SearchState();
}

class SearchState extends State<Search> {

  var keyWords = "";
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
            Container(
              margin: EdgeInsets.only(top: 10.0),
              padding:EdgeInsets.only(left: 10.0),
              child: Text('历史记录',style: Theme.of(context).textTheme.title,),
            ),
            Divider(),
            Column(
              children: <Widget>[
                ListTile(title: Text('手机'),),
                Divider(),
                ListTile(title: Text('笔记本电脑'),),
                Divider(),
                ListTile(title: Text('男装'),),
                Divider(),
                ListTile(title: Text('篮球鞋'),),
                Divider()
              ],
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(80.0),
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(left: 50.0,right: 50.0),
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
                print('清空历史记录');
              },
            )
          ],
        ),
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