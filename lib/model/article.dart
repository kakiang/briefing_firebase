import 'package:briefing/model/channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Article {
  final String title;
  final String link;
  final List<String> categories;
  final String published;
  final String image;
  final String video;
  final String summary;
  final Channel channel;
  final DocumentReference reference;

  Article(
      {this.title,
      this.link,
      this.categories,
      this.published,
      this.image,
      this.video,
      this.summary,
      this.channel,
      this.reference});

  Article.fromMap(Map<dynamic, dynamic> data, {this.reference})
      : title = data['title'],
        link = data['link'],
        categories = List<String>.from(data['categories']),
        published = data['published'],
        image = data['image'],
        video = data['video'],
        summary = data['summary'],
        channel = Channel.fromMap(data['channel']);

  Article.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'link': link,
      'categories': categories,
      'published': published,
      'image': image,
      'video': video,
      'summary': summary,
      'channel': channel.toMap(),
    };
  }

  String get timeAgo {
    var formatter = DateFormat("EEE, d MMM yyyy HH:mm:ss zzz");

    DateTime parsedDate = formatter.parse(published);
    Duration duration = DateTime.now().difference(parsedDate);

    if (duration.inDays > 7 || duration.isNegative) {
      return DateFormat.MMMMd().format(parsedDate);
    } else if (duration.inDays >= 1 && duration.inDays <= 7) {
      return duration.inDays == 1 ? "1 day ago" : "${duration.inDays} days ago";
    } else if (duration.inHours >= 1) {
      return duration.inHours == 1
          ? "1 hour ago"
          : "${duration.inHours} hours ago";
    } else {
      return duration.inMinutes == 1
          ? "1 minute ago"
          : "${duration.inMinutes} minutes ago";
    }
  }

  bool isNew() {
    var formatter = DateFormat("EEE, d MMM yyyy HH:mm:ss zzz");

    DateTime parsedDate = formatter.parse(published);
    Duration duration = DateTime.now().difference(parsedDate);
    if (duration.inHours < 23) {
      return true;
    }
    return false;
  }

  set channel(Channel channel) {
    this.channel = channel;
  }

  bool get isValid =>
      title != null && title.length > 3 && link != null && channel != null;

  @override
  String toString() {
    return "Article{title:$title,link:$link}\n";
  }
}
