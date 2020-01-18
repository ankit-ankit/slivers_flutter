import 'package:custom_scroll_view/providers/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatefulWidget {
  static const routeName = '/secondPage';
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DummyData>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

        ],
      ),
    );
  }
}
