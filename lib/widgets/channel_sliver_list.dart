import 'package:briefing/bloc/bloc_channel.dart';
import 'package:briefing/bloc/bloc_provider.dart';
import 'package:briefing/model/channel.dart';
import 'package:briefing/util/url_launcher.dart';
import 'package:briefing/widgets/error_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChannelSliverList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final channelBloc = BlocProvider.of<ChannelBloc>(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        StreamBuilder<List<Channel>>(
            stream: channelBloc.channelStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    padding: EdgeInsets.all(12.0),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return channelListTile(
                          context, snapshot.data[index], index);
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
                    '${snapshot.error.toString()}',
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
            }),
      ]),
    );
  }

  Container channelListTile(BuildContext context, Channel channel, int index) {
    return Container(
      padding: const EdgeInsets.all(4.0),
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
          UrlLauncher.launchURL(context, channel.link);
        },
      ),
    );
  }
}
