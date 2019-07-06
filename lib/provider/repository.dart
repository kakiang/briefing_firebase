import 'package:briefing/model/article.dart';
import 'package:briefing/model/channel.dart';
import 'package:briefing/provider/firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Stream<List<Channel>> getChannels() {
    return _firestoreProvider.getChannels().map((snapshot) {
      return List<Channel>.from(snapshot.documents
          .map((document) => Channel.fromDocumentSnapshot(document)));
    });
  }

  Stream<List<Article>> lastArticles({hours, descending}) {
    return _firestoreProvider
        .getLastArticles(hours: hours, descending: descending)
        .map((snapshot) {
      return List<Article>.from(snapshot.documents
          .map<Article>((document) => Article.fromDocumentSnapshot(document)));
    });
  }
}
