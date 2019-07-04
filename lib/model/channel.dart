import 'package:cloud_firestore/cloud_firestore.dart';

class Channel {
  String title;
  String subtitle;
  String link;
  String linkRss;
  String iconUrl;
  String language;

  Channel(
      {this.title,
      this.subtitle,
      this.link,
      this.language,
      this.linkRss,
      this.iconUrl});

  Channel.fromMap(Map<dynamic, dynamic> data)
      : title = data['title'],
        subtitle = data['subtitle'],
        link = data['link'],
        language = data['language'],
        linkRss = data['rss_link'],
        iconUrl = data['icon_url'];

  Channel.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'link': link,
      'language': language,
      'rss_link': linkRss,
      'icon_url': iconUrl,
    };
  }

  @override
  String toString() {
    return 'Channel{link: $link}';
  }
}
