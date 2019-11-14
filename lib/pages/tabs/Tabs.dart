import 'package:flutter/material.dart';
import 'Person.dart';
import 'Cart.dart';
import 'Category.dart';
import 'Home.dart';

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
    int _currentIndex  = 0;

    List pages = [
        HomePage(),
        CategoryPage(),
        CartPage(),
        PersonPage()
    ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: Text('京东'),
        ),
        body: this.pages[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index){
                setState(() {
                  _currentIndex = index;
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