import 'package:flutter/material.dart';
import 'Person.dart';
import 'Cart.dart';
import 'Category.dart';
import 'Home.dart';
import 'package:jd_shop/utils/ScreenAdapter.dart';

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
    int _currentIndex  = 0;

    //页面状态保持
    PageController _pageController;

    List<Widget> pages = [
        HomePage(),
        CategoryPage(),
        CartPage(),
        PersonPage()
    ];
  @override
  Widget build(BuildContext context) {
      ScreenAdapter.init(context);
    return new Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.center_focus_weak,color: Colors.black45,size: 28,),
                onPressed: (){
                    print('扫一扫点击了');
                },
            ),
            title: InkWell(
                child: Container(
                    height: ScreenAdapter.setHeight(70.0),
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color.fromRGBO(230, 230, 230, 0.8)
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Icon(Icons.search,color: Colors.black,size: 20,),
                            Text('笔记本、手机',style: TextStyle(fontSize: ScreenAdapter.setFontsize(30.0),color: Colors.black,),)
                        ],
                    ),
                ),
                onTap: (){
                    Navigator.pushNamed(context, '/search');
                },
            ),
            actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.message,color: Colors.black45,size: 28,),
                    onPressed: (){},
                )
            ],
        ),
//        body: IndexedStack(
//            index: this._currentIndex,
//            children:this.pages,
//        ),
        body: PageView(
            controller: this._pageController,
            children: this.pages,
            onPageChanged: (index){
                setState(() {
                    this._currentIndex = index;
                });
            },
        ),
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.red,
            currentIndex: _currentIndex,
            onTap: (index){
                setState(() {
                  _currentIndex = index;
                  this._pageController.jumpToPage(index);
                });
            },
            type: BottomNavigationBarType.fixed,
            items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('首页')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    title: Text('分类')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    title: Text('购物车')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    title: Text('我的')
                )
            ],
        ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._pageController = new PageController(initialPage: this._currentIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Tabs oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}