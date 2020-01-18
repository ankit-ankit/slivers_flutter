import 'package:custom_scroll_view/second_page.dart';
import 'package:custom_scroll_view/sliver_ankit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_scroll_view/providers/dummy_data.dart';
import './second_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DummyData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Custom Scroll View Demo Page'),
        routes: {SecondPage.routeName: (ctx) => SecondPage()},
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _scrollController = ScrollController();
  var message = 'My AppBar';
  List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.amber,
    Colors.yellowAccent
  ];

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        message = 'Reach the bottom';
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        message = 'Reached at the Top';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dummy = Provider.of<DummyData>(context);
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: mediaQuery.size.height / 1.5,
            pinned: true,
            iconTheme: IconThemeData(color: Colors.white),
            leading: IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, SecondPage.routeName);
                }),
            title: Text(message),
            centerTitle: true,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.more_vert), onPressed: null)
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://cdn.pixabay.com/photo/2020/01/11/10/08/landscape-4757116_960_720.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                color: _colors[index % 6],
                //   Colors.lightBlue[(100 * (index % 9) +100 )],
                child: Text(
                  dummy.dummyData[index],
                  style: TextStyle(fontSize: 19),
                ),
              );
            }, childCount: dummy.dummyData.length)),
          ),
          SliverAnkit(
              child: Container(
                  height: 100,
                  margin: EdgeInsets.only(right:2),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(8),
                        child: CircleAvatar(
                          backgroundColor: _colors[index % 6],
                          child: Text(dummy.dummyData[index].substring(0,2)),
                          radius: 50,
                        )
                      );
                    },
                    itemCount: dummy.dummyData.length,
                  ))),
          SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                color: Colors.green[100 * (index % 9)],
                child: Text(dummy.dummyData[index]),
              );
            }, childCount: dummy.dummyData.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 4 / 2),
          ),
          SliverToBoxAdapter(
            child: FlutterLogo(),
          ),
        ],
      ),
    );
  }
}
