import 'package:briefing/bloc/bloc_article.dart';
import 'package:briefing/bloc/bloc_provider.dart';
import 'package:briefing/model/article.dart';
import 'package:briefing/util/url_launcher.dart';
import 'package:briefing/widgets/briefing_card.dart';
import 'package:briefing/widgets/error_widget.dart';
import 'package:flutter/material.dart';

class BriefingSliverList extends StatefulWidget {
  const BriefingSliverList({Key key}) : super(key: key);

  @override
  _BriefingSliverListState createState() => _BriefingSliverListState();
}

class _BriefingSliverListState extends State<BriefingSliverList> {
  int dropdownValue = 24;
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.caption;
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 2.0))),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          margin: EdgeInsets.only(bottom: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Briefing', style: style),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<int>(
                      underline: Container(),
                      elevation: 10,
                      value: dropdownValue,
                      onChanged: (int newValue) {
                        setState(() {
                          if (newValue != null) {
                            dropdownValue = newValue;
                            articleBloc.durationSink.add(newValue);
                          }
                        });
                      },
                      items: [48, 24, 12, 3]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            'Since ${value}h',
                            style: style,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Text('Recent first', style: style),
                  Switch.adaptive(
                      value: switchValue,
                      onChanged: (bool value) {
                        setState(() {
                          switchValue = value;
                          articleBloc.descendingSink.add(switchValue);
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
        StreamBuilder<List<Article>>(
          stream: articleBloc.articlesStream,
          builder: (context, snapshot) {
            debugPrint("!!!snapshot state: ${snapshot.connectionState}!!!");
            debugPrint("!!!snapshot.hasData: ${snapshot.hasData}!!!");
            debugPrint("!!!snapshot.data.length: ${snapshot?.data?.length}!!!");
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: InkWell(
                        child: BriefingCard(article: snapshot.data[index]),
                        onTap: () {
                          UrlLauncher.launchURL(
                              context, snapshot.data[index].link);
                        },
                      ),
                    );
                  },
                );
              }

              return StreamErrorWidget(
                message: [
                  'No articles found',
                ],
              );
            }

            if (snapshot.hasError) {
              debugPrint("!!!snapshot error ${snapshot.error.toString()}");
              return StreamErrorWidget(
                message: [
                  '${snapshot.error}',
                  'Keep calm, and retry again',
                ],
              );
            }

            return Center(
              child: Container(
                margin: EdgeInsets.all(8.0),
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
