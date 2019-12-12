import 'package:flutter/material.dart';
import 'package:jd_shop/providers/Counter.dart';
import 'package:provider/provider.dart';
class CartPage extends StatefulWidget {
  @override
  CartPageState createState() => new CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Counter>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: InkWell(
          child: new Text('${provider.count}'),
          onTap: (){
            provider.increamCount();
          },
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
  void didUpdateWidget(CartPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}