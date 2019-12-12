import 'package:flutter/material.dart';
import 'package:jd_shop/modal/ProductContentModel.dart';

class ProductContentThrid extends StatefulWidget {
  final List _productContentList ;

  ProductContentThrid(this._productContentList,{Key key}):super(key:key);

  @override
  ProductContentThridState createState() => new ProductContentThridState();
}

class ProductContentThridState extends State<ProductContentThrid>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Text('评价'),
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
  void didUpdateWidget(ProductContentThrid oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}