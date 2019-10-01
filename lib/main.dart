import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sneaky_app/my_theme.dart';
import 'package:flutter_sneaky_app/shoes.dart';
import 'package:flutter_sneaky_app/shoes_section.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  final List<ShoesSection> shoesItems = [
    ShoesSection.generate(),
    ShoesSection.generate(),
    ShoesSection.generate(),
    ShoesSection.generate()
  ];

  @override
  void initState() {
    _scrollController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  var marginMenu = MyTheme.MAX_MARGIN;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                buildSliverAppBar(),
                SliverList(
                  delegate: SliverChildListDelegate([
                    buildSection(0),
                    buildSection(1),
                    buildSection(2),
                    buildSection(3)
                  ]),
                )
              ],
            ),
            buildItemMenuLeft(),
            buildItemMenuRightBottom(),
            buildItemMenuRightTop()
          ],
        ));
  }

  AnimatedPositioned buildItemMenuRightTop() {
    return AnimatedPositioned(
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 500),
      right: marginMenu,
      bottom: 120,
      child: Container(
        child: Center(
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(51, 0, 0, 0),
              offset: Offset(0, 0),
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 50,
        height: 50,
      ),
    );
  }

  AnimatedPositioned buildItemMenuRightBottom() {
    return AnimatedPositioned(
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 500),
      right: marginMenu,
      bottom: 50,
      child: Container(
        child: Center(
          child: Text(
            "ME\nNU",
            style: MyTheme.menuTextStyle,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(51, 0, 0, 0),
              offset: Offset(0, 0),
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 50,
        height: 50,
      ),
    );
  }

  AnimatedPositioned buildItemMenuLeft() {
    return AnimatedPositioned(
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 500),
      left: marginMenu,
      bottom: 50,
      child: Container(
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(51, 0, 0, 0),
              offset: Offset(0, 0),
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 50,
        height: 50,
      ),
    );
  }

  Container buildSection(int index) {
    return Container(
        child: ShoesSectionItem(
      section: shoesItems[index],
    ));
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 12,
      title: Text(
        "Sneaky Men",
        style: MyTheme.titleAppBarTextStyle,
      ),
      floating: true,
    );
  }

  void listener() {
    final bool goTop = _scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !_scrollController.position.outOfRange &&
        marginMenu == MyTheme.MIN_MARGIN;

    final bool goBottom = _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        !_scrollController.position.outOfRange &&
        marginMenu == MyTheme.MAX_MARGIN;

    if (goBottom) {
      setState(() {
        marginMenu = MyTheme.MIN_MARGIN;
      });
    } else if (goTop) {
      setState(() {
        marginMenu = MyTheme.MAX_MARGIN;
      });
    }
  }
}
