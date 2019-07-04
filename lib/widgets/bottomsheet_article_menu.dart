import 'package:briefing/model/article.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BottomSheetArticleMenu extends StatefulWidget {
  final Article article;

  const BottomSheetArticleMenu({Key key, @required this.article})
      : super(key: key);

  @override
  _BottomSheetArticleMenuState createState() => _BottomSheetArticleMenuState();
}

class _BottomSheetArticleMenuState extends State<BottomSheetArticleMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Wrap(children: <Widget>[
        ListTile(
          leading: Icon(Icons.share),
          title: Text('Share'),
          onTap: () {
            Share.share('check out ${widget.article.link}');
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark_border),
          title: Text('Bookmark'),
        ),
      ]),
    );
  }
}
