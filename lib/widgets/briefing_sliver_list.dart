import 'dart:async';

import 'package:briefing/model/article.dart';
import 'package:briefing/widgets/briefing_card.dart';
import 'package:briefing/widgets/error_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class BriefingSliverList extends StatefulWidget {
  const BriefingSliverList({Key key}) : super(key: key);

  @override
  _BriefingSliverListState createState() => _BriefingSliverListState();
}

class _BriefingSliverListState extends State<BriefingSliverList> {
  final _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

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
                      DateTime.now().subtract(Duration(hours: 24)))
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            debugPrint("!!!snapshot state: ${snapshot.connectionState}!!!");

            if (snapshot.hasData) {
              List<DocumentSnapshot> documents = snapshot.data.documents;
              if (documents.length > 0) {
                return ListView.builder(
                  padding: EdgeInsets.all(12.0),
                  physics: ScrollPhysics(),
                  itemCount: documents.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var article = Article.fromSnapshot(documents[index]);
                    return Container(
                      child: InkWell(
                        child: BriefingCard(article: article),
                        onTap: () {
                          _launchURL(context, article.link);
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

  Future<void> _launchURL(BuildContext context, String link) async {
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
