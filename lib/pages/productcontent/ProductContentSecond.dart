import 'package:flutter/material.dart';
import 'package:jd_shop/modal/ProductContentModel.dart';
import "package:flutter_inappwebview/flutter_inappwebview.dart";
class ProductContentSecond extends StatefulWidget {
  final List _productContentList ;

  ProductContentSecond(this._productContentList,{Key key}):super(key:key);
  @override
  ProductContentSecondState createState() => new ProductContentSecondState();
}

class ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin{
  var _id;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "http://jd.itying.com/pcontent?id=${ this._id}",
              onProgressChanged: (InAppWebViewController controller, int progress) {

              },
                initialOptions: InAppWebViewWidgetOptions(
                    inAppWebViewOptions: InAppWebViewOptions(
                      debuggingEnabled: true,
                    )
                )
            ),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._id = widget._productContentList[0].sId;
    print(this._id);
    print("http://jd.itying.com/pcontent?id=${ this._id}");
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(ProductContentSecond oldWidget) {
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