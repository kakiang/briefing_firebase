import 'package:briefing/model/article.dart';
import 'package:briefing/widgets/article_bottom_section.dart';
import 'package:briefing/widgets/article_title_section.dart';
import 'package:flutter/material.dart';

class BriefingCard extends StatelessWidget {
  final Article article;

  const BriefingCard({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.0),
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          ArticleTitleSection(article: article),
          ArticleBottomSection(article: article),
        ],
      ),
    );
  }
}
