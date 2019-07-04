import 'package:briefing/model/channel.dart';
import 'package:briefing/widget/error_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChannelSliverList extends StatefulWidget {
  @override
  _ChannelSliverListState createState() => _ChannelSliverListState();
}

class _ChannelSliverListState extends State<ChannelSliverList> {
  final Firestore _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('channels').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return channelListTile(
                          Channel.fromSnapshot(snapshot.data.documents[index]),
                          index);
                    });
              } else if (snapshot.hasError) {
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
              } else {
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ]),
    );
  }

  Container channelListTile(Channel channel, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: Container(
          width: 44.0,
          height: 36.0,
          decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.grey[100]),
              borderRadius: BorderRadius.circular(3.0)),
          child: CachedNetworkImage(
            imageUrl: channel.iconUrl ?? '',
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3.0),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill)),
                  padding: EdgeInsets.only(right: 4.0),
                ),
            placeholder: (context, url) => Icon(Icons.image),
          ),
        ),
        title: Text(
          channel.title,
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text("${index + 1}. Available"),
        trailing: Container(
          alignment: Alignment.center,
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.7, color: Colors.grey[300]),
          ),
          child: Icon(
            Icons.star_border,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        onTap: () async {
          if (await canLaunch(channel.link)) {
            launch(channel.link);
          }
        },
      ),
    );
  }
}
