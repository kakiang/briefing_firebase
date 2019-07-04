import 'package:briefing/model/article.dart';
import 'package:briefing/widget/bottomsheet_article_menu.dart';
import 'package:flutter/material.dart';

class ArticleBottomSection extends StatelessWidget {
  final Article article;

  const ArticleBottomSection({Key key, @required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _modalBottomSheetMenu() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return BottomSheetArticleMenu(article: article);
        },
      );
    }

    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                article.timeAgo,
                style: TextStyle(fontFamily: 'Libre_Franklin', fontSize: 12.0),
              ),
//              if (article.categories != null &&
//                  article.categories.length > 0 &&
//                  article.categories.first.isNotEmpty)
//                Expanded(child: categoryWidget(article.categories.first))
//              else
//                if (article.source != null && article.source.isNotEmpty)
//                  Expanded(
//                      child: categoryWidget(
//                          'src: ${article.source.replaceFirst('https://www.', '')}'))
            ],
          ),
          InkWell(
            child: Icon(
              Icons.more_vert,
              color: Colors.grey[600],
            ),
            onTap: () {
              _modalBottomSheetMenu();
            },
          ),
        ],
      ),
    );
  }
}
