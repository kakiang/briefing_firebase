import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;

  Stream<QuerySnapshot> getChannels() {
    return _firestore.collection('channels').snapshots();
  }

  Stream<QuerySnapshot> getLastArticles(
      {@required int hours, @required bool descending}) {
    return _firestore
        .collection('articles')
        .where('timestamp',
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(Duration(hours: hours)))
        .orderBy('timestamp', descending: descending)
        .snapshots();
  }
}
