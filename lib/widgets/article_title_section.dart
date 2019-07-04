import 'package:briefing/model/article.dart';
import 'package:briefing/widgets/article_thumbnail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticleTitleSection extends StatelessWidget {
  final Article article;

  const ArticleTitleSection({Key key, @required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                CachedNetworkImage(
                  imageUrl: article.channel.iconUrl ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                        width: 32.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(3.0),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fitWidth)),
                        margin: EdgeInsets.only(right: 8.0),
                      ),
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) {
                    print('image err ${error.toString()}');
                    return Container();
                  },
                ),
                Expanded(
                  child: Text(article.channel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Libre_Franklin', fontSize: 14.0)),
                ),
              ]),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 4.0, 8.0, 4.0),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  title: Text(article.title,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis),
                ),
              )
            ],
          ),
        ),
        ArticleThumbnail(article: article),
      ],
    );
  }
}
