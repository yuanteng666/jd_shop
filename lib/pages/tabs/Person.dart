import 'package:flutter/material.dart';
import 'package:jd_shop/providers/Counter.dart';
import 'package:provider/provider.dart';
class PersonPage extends StatefulWidget {
  @override
  PersonPageState createState() => new PersonPageState();
}

class PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Counter>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('${provider.count}',style: TextStyle(color: Colors.red),)
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
  void didUpdateWidget(PersonPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}