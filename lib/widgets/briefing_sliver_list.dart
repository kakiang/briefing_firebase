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
  @override
  Widget build(BuildContext context) {
    final ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context);
    var dropdownValue = 24;
    return SliverList(
      delegate: SliverChildListDelegate([
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<int>(
                underline: Container(),
                elevation: 0,
                icon: Icon(Icons.filter_list),
                value: dropdownValue,
                onChanged: (newValue) {
                  setState(() {
                    if (newValue != null) {
                      print(newValue);
                      dropdownValue = newValue;
                      articleBloc.durationSink.add(newValue);
                    }
                  });
                },
                items:
                    [100, 72, 48, 24, 6, 2].map<DropdownMenuItem<int>>((value) {
                  return DropdownMenuItem<int>(
                    child: Text(
                      value > 72 ? 'Any time' : '${value}h ago',
                      style: TextStyle(fontSize: 19.0),
                    ),
                    value: value,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Divider(),
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
                  'Please check your internet connection, and retry again',
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
