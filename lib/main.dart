import 'package:briefing/theme.dart';
import 'package:briefing/widget/briefing_sliver_list.dart';
import 'package:briefing/widget/channel_sliver_list.dart';
import 'package:briefing/widget/main_sliverappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Briefing',
      theme: buildAppTheme(),
      home: MyHomePage(title: 'Briefing'),
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
  int _selectedIndex = 0;

  var _pages;

  @override
  void initState() {
    super.initState();
    _pages = {
      "Briefing": BriefingSliverList(),
      "Newsstands": ChannelSliverList(),
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.grey,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            body: CustomScrollView(
              slivers: <Widget>[
                MainSliverAppBar(title: _pages.keys.elementAt(_selectedIndex)),
                _pages.values.elementAt(_selectedIndex)
              ],
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Theme.of(context).accentIconTheme.color,
                textTheme: Theme.of(context).textTheme.copyWith(
                    caption: TextStyle(
                        fontFamily: 'Libre_Franklin',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700])),
              ),
              child: BottomNavigationBar(
                  selectedFontSize: 16,
                  unselectedFontSize: 16,
                  elevation: 10.0,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.format_list_bulleted),
                      title: Text('Headlines'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.filter_none),
                      title: Text('Newsstand'),
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed),
            )),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
