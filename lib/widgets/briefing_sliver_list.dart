import 'dart:async';

import 'package:briefing/model/article.dart';
import 'package:briefing/widget/briefing_card.dart';
import 'package:briefing/widget/error_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class BriefingSliverList extends StatefulWidget {
  const BriefingSliverList({Key key}) : super(key: key);

  @override
  _BriefingSliverListState createState() => _BriefingSliverListState();
}

class _BriefingSliverListState extends State<BriefingSliverList> {
  final Firestore _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('articles')
                .where('timestamp',
                    isGreaterThanOrEqualTo:
                        DateTime.now().subtract(Duration(hours: 6)))
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              debugPrint("!!!snapshot state: ${snapshot.connectionState}!!!");
              print('length ${snapshot.data?.documents?.length}');
              print('hasData ${snapshot.hasData}');
              if (snapshot.hasError) {
                debugPrint("!!!snapshot error ${snapshot.error.toString()}");
                return GestureDetector(
                  onTap: _onRefresh,
                  child: StreamErrorWidget(
                    message: [
                      '${snapshot.error}',
                      'Keep calm, and tap to retry',
                    ],
                  ),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasData && snapshot.data.documents.length == 0) {
                debugPrint("!!!snapshot error ${snapshot.error.toString()}");
                return StreamErrorWidget(
                  message: [
                    'There are no news in the world',
                    'Keep calm, and retry later',
                  ],
                );
              }

              return ListView.builder(
                  padding: EdgeInsets.all(12.0),
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Article article =
                        Article.fromSnapshot(snapshot.data.documents[index]);
                    return Container(
                      child: InkWell(
                        child: Column(
                          children: <Widget>[BriefingCard(article: article)],
                        ),
                        onTap: () {
                          _launchURL(context, article.link);
                        },
                      ),
                    );
                  });
            }),
      ]),
    );
  }

  void _launchURL(BuildContext context, String link) async {
    try {
      await launch(
        link,
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          enableInstantApps: true,
          animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class LoadingWidget extends StatelessWidget {
  final Stream<bool> _isLoading;

  const LoadingWidget(this._isLoading);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isLoading,
      initialData: true,
      builder: (context, snapshot) {
        debugPrint("_bloc.isLoading: ${snapshot.data}");
        return snapshot.data
            ? Center(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
