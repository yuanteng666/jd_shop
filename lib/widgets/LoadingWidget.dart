import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(

        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Text('加载中...',style: TextStyle(fontSize: 16.0),),
                    CircularProgressIndicator(strokeWidth: 1.0,)
                ],
            ),
        ),
    );
  }
}